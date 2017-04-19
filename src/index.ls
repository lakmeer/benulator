
{ log, wrap } = require \helpers


# Modules

Clock                = require \./modules/clock
ProgramCounter       = require \./modules/program-counter
Mainbus              = require \./modules/mainbus
Register             = require \./modules/register
Output               = require \./modules/output
ALU                  = require \./modules/alu
RAM                  = require \./modules/ram
MemoryAccessRegister = require \./modules/mar
Control              = require \./modules/control
InstructionRegister  = require \./modules/instruction-register


# Main Program

init = ->

  # Create all the module and map them to their DOM representations.
  # This will also be the order of resolution on each tick.

  all-modules = [
    bus     = new Mainbus \#mainbus
    clock   = new Clock \#clock
    pc      = new ProgramCounter \#program-counter
    mar     = new MemoryAccessRegister \#mar
    ram     = new RAM \#ram
    reg-i   = new InstructionRegister \#instr
    reg-a   = new Register \#register-a
    reg-b   = new Register \#register-b
    alu     = new ALU \#alu
    output  = new Output \#output, 4
    control = new Control \#control
  ]


  # Connect together those modules which need it (don't worry about the main
  # bus, everyone gets that automatically).
  #
  # Because of the way the simulator is designed, when modules are connected
  # together directly in this way, their ordering in that instantiation list
  # above becomes important. Basically, any dependants should go above their
  # dependers in the list, like registers above the ALU. This is because the
  # modules can draw updated values from their dependencies at any time, not
  # just on the falling edge of the clock, so we want the most recent update.

  alu.expose-register \a, reg-a
  alu.expose-register \b, reg-b
  ram.expose-register \mar, mar


  # Library of microinstructions, and helpers for performing them

  set = (mod, flag) -> all-modules.filter (is mod) .0.set flag

  micro = (...codes) ->
    for code in codes
      control.set code
      switch code
      | \hlt => clock.set  \halt
      | \mi  => mar.set    \in
      | \ri  => ram.set    \in
      | \ro  => ram.set    \out
      | \ii  => reg-i.set  \in
      | \io  => reg-i.set  \out
      | \ai  => reg-a.set  \in
      | \ao  => reg-a.set  \out
      | \eo  => alu.set    \out
      | \su  => alu.set    \sub
      | \bi  => reg-b.set  \in
      | \oi  => output.set \in
      | \ce  => pc.set     \inc
      | \co  => pc.set     \out
      | \j   => pc.set     \jmp
      | _    => warn "Unsupported microinstruction:", code


  # Run instructions when clock pulses

  mpc = 0

  [ NOP, LDA, ADD, _, _, _, _, _, _, _, _, _, _, _, OUT, HLT, ] = [ 0 to 15 ]

  microcode = (mpc, instr, arg = 0) ->

    steps =
      if mpc < 3 # Fetch steps
        [ [ \co \mi ], [ \ro \ii ], [ \ce ] ]
      else          # Instruction-specific steps
        switch instr
        | NOP => [ ]
        | LDA => [ [ \io \mi ], [ \ro \ai ] ]
        | ADD => [ [ \io \mi ], [ \ro \bi ], [ \eo \ai ] ]
        | OUT => [ [ \ao \oi ] ]
        | HLT => [ [ \hlt ] ]

    if action = steps[mpc % 3]
      micro ...action

    #log "Step:", mpc, if action then action.join ', ' else  "(no actions)"

  clock.on-clock ->
    all-modules.map (.rise bus)
    all-modules.map (.fall bus)
    all-modules.map (.clear-all!)
    microcode mpc, reg-i.instr, reg-i.arg
    mpc := wrap 0, 5, mpc + 1


  # Start

  clock.rate = 20
  #clock.start!


document.add-event-listener \DOMContentLoaded, init

