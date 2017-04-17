
{ log, pad2 } = require \helpers

LedBits = require \../components/ledbits
Segment = require \../components/segment

Module = require \./module


#
# Mainbus
#

module.exports = class Mainbus extends Module

  ->
    super ...

    # State
    @value = 0

    # Components
    @bits  = new LedBits '[data-mb-bit]'
    @digit = new Segment '[data-mb-value]'

  set: ->
    @value = it
    @bits.set it
    @digit.set pad2 it, 16

