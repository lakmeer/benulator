
Module = require \./module

Flag    = require \../components/flag
Segment = require \../components/segment


#
# Output
#
# 4-digit 7-segment display with switch for showing 2's-complement values as
# real negative decimals.
#

module.exports = class Output extends Module

  ->
    super ...

    # State
    @flag \in
    @value = 0

    # Components
    @display = new Segment '[data-out-value]', 4
    @flags = in: new Flag '[data-out-flag="oi"]'

    # Init
    @display.hex off

  clock: (bus) ->
    if @in then @value = bus.value
    @display.set @value

