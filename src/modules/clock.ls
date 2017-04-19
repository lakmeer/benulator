
{ log, invoke, Q } = require \helpers

Led    = require \../components/led
Flag   = require \../components/flag

Module = require \./module


#
# Clock
#

module.exports = class Clock extends Module

  (sel) ->
    super ...

    # State
    @halt = on
    @rate = 200
    @callbacks = []

    # Display components
    @signal = new Led '[data-clock-signal]'
    @button = Q '[data-clock-step]'
    @flags  = halt: new Flag '[data-clock-flag="hlt"]'

    # Init
    @blip!
    @flags.halt.on-click ~> @flip \halt
    @button.add-event-listener \click, @step

  start: ->
    @clear \halt
    @blip!

  step: ~>
    @signal.on!
    set-timeout @signal~off, @rate/2
    @callbacks.map invoke

  blip: ~>
    if not @halt
      @step!
      set-timeout @blip, @rate

  on-clock: (λ) ->
    @callbacks.push λ

  rise: ->  # Clock doesn't implement 'clock'
  fall: ->  # Clock doesn't implement 'fall'

