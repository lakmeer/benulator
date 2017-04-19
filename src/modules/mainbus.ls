
{ log, warn, pad } = require \helpers

LedBits = require \../components/ledbits
Segment = require \../components/segment

Module = require \./module


#
# Mainbus
#
# 'wrote' property tracks whether more than one module tried to write to the
# bus during a single clock cycle
#

module.exports = class Mainbus extends Module

  ->
    super ...

    # State
    @value = 0
    @wrote = no

    # Components
    @bits  = new LedBits '[data-mb-bit]'
    @digit = new Segment '[data-mb-value]'

  set: ->
    if @wrote then return warn "Mainbus::clock - already got written to this cycle!"
    @value = it
    @wrote = yes
    @bits.set it
    @digit.set pad 2, it.to-string 16

  rise: ->
  fall: -> @wrote = no

