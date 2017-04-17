
{ log, Q } = require \helpers


#
# Module Common Base
#

module.exports = class Module

  (sel) ->
    @dom = Q sel

  clock: ->
    log \clock this

