
{ log, QSA } = require \helpers

Led = require \./led


module.exports = class LedBits

  (sel, scope) ->
    @dom = QSA sel, scope .reverse!
    @leds = @dom.map -> new Led it

  set: ->
    for led, ix in @leds
      led.set it .>>. ix .&. 1

