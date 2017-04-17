
{ log, pad2, wrap, Q, invoke, hex } = require \helpers


# Subcomponents

Led     = require \./components/led
Flag    = require \./components/flag
LedBits = require \./components/ledbits
Segment = require \./components/segment


# Modules

Module         = require \./modules/module
Clock          = require \./modules/clock
ProgramCounter = require \./modules/program-counter
Mainbus        = require \./modules/mainbus


# Main Program

init = ->

  clock = new Clock \#clock
  pc    = new ProgramCounter \#program-counter
  bus   = new Mainbus \#mainbus


  pc.set \ce on

  clock.on-clock ->
    pc.clock!

    pc.set \co !pc.co

    if pc.co
      bus.set pc.value




document.add-event-listener \DOMContentLoaded, init

