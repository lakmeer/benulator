
{ log, Q, hex } = require \helpers


# Segment
#
# A 7-segment display. It's not Segment's job to control how many digits it
# shows, the controlling module should clamp it's values appropriately.

module.exports = class Segment
  (sel) ->
    @dom = Q sel

  set: ->
    @dom.text-content = hex it

