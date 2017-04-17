
{ log } = require \helpers


# Modules

Clock    = require \./modules/clock
Counter  = require \./modules/program-counter
Mainbus  = require \./modules/mainbus
Register = require \./modules/register
Output   = require \./modules/output
ALU      = require \./modules/alu
RAM      = require \./modules/ram


# Main Program

init = ->

  # Create all the module and map them to their DOM representations.
  # This will also be the order of resolution on each tick.

  all-modules = [
    clock  = new Clock \#clock
    pc     = new Counter \#program-counter
    ram    = new RAM \#ram
    bus    = new Mainbus \#mainbus
    alu    = new ALU \#alu
    reg-a  = new Register \#register-a
    reg-b  = new Register \#register-b
    output = new Output \#output, 4
  ]


  # Connect together those module which need it (don't worry about the main
  # bus, everyone gets that automatically)

  alu.expose-register \a, reg-a
  alu.expose-register \b, reg-b


  # Library of microinstructions, and helpers for performing them

  set = (mod, flag) -> all-modules.filter (is mod) .0.set flag

  micro = (...codes) -> ->
    for code in codes
      switch code
      | \hlt => clock.set  \halt
      #| \mi  => mar.set    \in
      | \ri  => ram.set    \in
      | \ro  => ram.set    \out
      #| \io  => instr.set  \out
      #| \ii  => instr.set  \in
      | \ai  => reg-a.set  \in
      | \ao  => reg-a.set  \out
      | \eo  => alu.set    \out
      | \su  => pc.set     \ce
      | \bi  => reg-b.set  \in
      | \oi  => output.set \in
      | \ce  => pc.set     \inc
      | \co  => pc.set     \out
      #| \j   => pc.set     \jump
      | _    => warn "Unsupported microinstruction:", code

  lib =
    LDA: (n) -> [
      # * micro \co \mi
      # * micro \ro \ii
      * micro \ce
      -> bus.set n
      * micro \ai
    ]

    ADD: (n) -> [
      # * micro \co \mi
      # * micro \ro \ii
      * micro \ce
      -> bus.set n
      * micro \bi
      # * micro \ro \bi
      * micro \eo \ai
    ]

    OUT: -> [
      # * micro \co \mi
      # * micro \ro \ii
      * micro \ce
      * micro \ao \oi
    ]


  # Assemble a program

  instr = [ ]
  instr ++= lib.LDA 28
  instr ++= lib.ADD 14
  instr ++= lib.OUT!


  # Run instructions when clock pulses

  pi = 0

  clock.on-clock ->
    all-modules.map (.clock bus)
    all-modules.map (.clear-all!)
    if instr[pi]? then that! else set clock, \halt
    pi += 1


  # Start

  clock.start!


document.add-event-listener \DOMContentLoaded, init

