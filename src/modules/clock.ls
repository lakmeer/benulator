
{ log, invoke } = require \helpers

Led    = require \../components/led
Module = require \./module


#
# Clock
#

module.exports = class Clock extends Module

  (sel) ->
    super ...

    # State
    @halt = no
    @rate = 500
    @callbacks = []

    # Display components
    @signal = new Led '[data-clock-signal]'

    # Init
    @blip!

  blip: ~>
    if !@halt
      @signal.on!
      set-timeout @signal~off, @rate/2
      set-timeout @blip, @rate
      @callbacks.map invoke

  on-clock: (λ) ->
    @callbacks.push λ

