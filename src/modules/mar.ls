
{ log } = require \helpers

Flag    = require \../components/flag
LedBits = require \../components/ledbits
Module  = require \./module


#
# Memory Access Register
#
# Really simple register, 4 bits, no out mode
#

module.exports = class MemoryAccessRegister extends Module

  (sel) ->
    super ...

    # State
    @flag \in
    @value = 0

    # Components
    @bits  = new LedBits '[data-mar-bit]', @dom
    @flags = in: new Flag '[data-flag="in"]', @dom

  write: ->
    log \MAR-write it
    @value = it
    @bits.set it

  clock: (bus) ->
    if @in  then @write bus.value

