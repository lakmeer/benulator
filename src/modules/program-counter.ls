
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
    @flag \inc
    @flag \out
    @flag \jmp
    @value = 0

    # Components
    @bits  = new LedBits '[data-pc-bit]'
    @digit = new Segment '[data-pc-value]'
    @flags =
      inc: new Flag '[data-pc-flag="ce"]'
      out: new Flag '[data-pc-flag="co"]'
      jmp: new Flag '[data-pc-flag="j"]'

  clock: (bus) ->
    if @inc
      @value = wrap 0, 15, @value + 1
      @bits.set  @value
      @digit.set @value

    if @out
      bus.set @value

