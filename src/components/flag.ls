
{ log, invoke } = require \helpers

Led = require \./led


#
# Flag
#
# Derives from LED for display purposed but also supports user interactions
#

module.exports = class Flag extends Led

  ->
    super ...

    @callbacks = []

    @dom.add-event-listener \click, this~dispatch

  dispatch: ->
    @callbacks.map invoke

  on-click: (λ) ->
    @callbacks.push λ

