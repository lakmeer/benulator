
{ log } = require \helpers

Module = require \./module

LedBits = require \../components/ledbits
Flag    = require \../components/flag


#
# Register
#
# We'll need two of these
#

module.exports = class Register extends Module

  (sel) ->
    super ...

    # State
    @flag \in
    @flag \out
    @value = 0

    # Components
    @bits  = new LedBits '[data-reg-bit]', @dom
    @flags =
      in:  new Flag '[data-reg-flag="in"]',  @dom
      out: new Flag '[data-reg-flag="out"]', @dom

  write: ->
    @value = it
    @bits.set it

  rise: (bus) ->
    if @out then bus.set @value

  fall: (bus) ->
    if @in then @write bus.value

