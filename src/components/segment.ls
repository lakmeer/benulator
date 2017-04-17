
{ log, Q, pad } = require \helpers



# Segment
#
# A 7-segment display. It's not Segment's job to control how many digits it
# shows, the controlling module should clamp it's values appropriately.

module.exports = class Segment
  (sel, @len = 1, scope = document) ->
    @dom = Q sel, scope
    @base = 16
    @set 0

  hex: ->
    @base = if it then 16 else 10

  set: ->
    @dom.text-content = pad @len, it.to-string @base

