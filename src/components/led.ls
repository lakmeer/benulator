
{ log, Q } = require \helpers


#
# LED
#
# A signle LED display. Comes in 4 colors.
#

module.exports = class Led
  (sel, scope) ->
    @dom = Q sel, scope

  on: ->
    @dom.set-attribute \on, true

  off: ->
    @dom.remove-attribute \on

  set: ->
    if it then @on! else @off!

