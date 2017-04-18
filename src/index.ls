
{ log } = require \helpers


# Modules

Clock    = require \./modules/clock
Counter  = require \./modules/program-counter
Mainbus  = require \./modules/mainbus
Register = require \./modules/register
Output   = require \./modules/output
ALU      = require \./modules/alu
RAM      = require \./modules/ram
MAR      = require \./modules/mar


# Main Program

init = ->

  # Create all the module and map them to their DOM representations.
  # This will also be the order of resolution on each tick.

  all-modules = [
    bus    = new Mainbus \#mainbus
    clock  = new Clock \#clock
    pc     = new Counter \#program-counter
    mar    = new MAR \#mar
    ram    = new RAM \#ram
    alu    = new ALU \#alu
    reg-a  = new Register \#register-a
    reg-b  = new Register \#register-b
    output = new Output \#output, 4
  ]


  # Connect together those module which need it (don't worry about the main
  # bus, everyone gets that automatically)

  alu.expose-register \a, reg-a
  alu.expose-register \b, reg-b
  ram.expose-register \mar, mar


  # Library of microinstructions, and helpers for performing them

  set = (mod, flag) -> all-modules.filter (is mod) .0.set flag

  micro = (...codes) -> ->
    for code in codes
      switch code
      | \hlt => clock.set  \halt
      | \mi  => mar.set    \in
      | \ri  => ram.set    \in
      | \ro  => ram.set    \out
      #| \io  => instr.set  \out
      #| \ii  => instr.set  \in
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

  lib =
    LDA: (n) -> [
      # * micro \co \mi
      # * micro \ro \ii
      * micro \ce
      -> bus.set n
      * micro \mi
      * micro \ro \ai
    ]

    ADD: (n) -> [
      # * micro \co \mi
      # * micro \ro \ii
      * micro \ce
      -> bus.set n
      * micro \mi
      * micro \ro \bi
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
  instr ++= lib.LDA 14
  instr ++= lib.ADD 15
  instr ++= lib.OUT!


  # Run instructions when clock pulses

  pi = 0

  clock.on-clock ->
    all-modules.map (.clock bus)
    all-modules.map (.clear-all!)
    if instr[pi]? then that! else set clock, \halt
    pi += 1


  # Start

  clock.rate = 1
  clock.start!


  # TODO: Seperate rising/falling clock edges so the state of population
  # of various registers can look identical to ben's videos


document.add-event-listener \DOMContentLoaded, init

