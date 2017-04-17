
{ log, wrap } = require \helpers

LedBits = require \../components/ledbits
Segment = require \../components/segment
Flag    = require \../components/flag

Module = require \./module


#
# Program Counter
#

module.exports = class ProgramCounter extends Module

  ->
    super ...

    # State
    @ce = no
    @co = no
    @value = 0

    # Components
    @bits  = new LedBits '[data-pc-bit]'
    @digit = new Segment '[data-pc-value]'
    @flags =
      ce: new Flag '[data-pc-flag="ce"]'
      co: new Flag '[data-pc-flag="co"]'

  set: (flag, val) ->
    if not this[flag]? then return console.warn 'ProgramCounter::set - no such flag:', flag
    this[flag] = val
    @flags[flag].set val

  clock: ->
    if @ce
      @value = wrap 0, 15, @value + 1
      @bits.set  @value
      @digit.set @value

