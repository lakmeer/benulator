
{ log, warn, Q } = require \helpers


#
# Module Common Base
#
# Deals with the setting of module flags and keeping things up to date when
# flags change and resetting flags for the next clock pulse
#

module.exports = class Module

  (sel) ->
    @dom = Q sel
    @log = off
    @_flags = []

  clock: (bus) ->
    warn "Module " + @@@display-name + " has not impelmented 'clock'"

  flag: (name, value = off) ->
    this[name] = value
    @_flags.push name

  set: (flag) ->
    if not this[flag]? then return warn @@@display-name + "::set - no such flag: #flag"
    if @log then log @@@display-name, \set, flag
    this[flag] = on
    @flags?[flag].set on

  flip: (flag) ->
    if not this[flag]? then return warn @@@display-name + "::set - no such flag: #flag"
    if this[flag] then @clear flag else @set flag

  clear: (flag) ->
    if not this[flag]? then return warn @@@display-name + "::clear - no such flag: #flag"
    this[flag] = off
    @flags?[flag].set off

  clear-all: ->
    for flag in @_flags
      @clear flag

