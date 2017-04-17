
{ log, warn } = require \helpers

Module = require \./module

Flag    = require \../components/flag
LedBits = require \../components/ledbits


module.exports = class ALU extends Module

  ->
    super ...

    # State
    @flag \out
    @flag \sub
    @value  = 0
    @inputs = a: { value: 0 }, b: { value: 0 }

    # Components
    @bits  = new LedBits '[data-alu-bit]'
    @flags =
      sub: new Flag '[data-alu-flag="sub"]'
      out: new Flag '[data-alu-flag="out"]'

  expose-register: (name, reg) ->
    if not @inputs[name]? then warn
    @inputs[name] = reg

  clock: (bus) ->
    a = @inputs.a.value
    b = @inputs.b.value
    @value = if @sub then a - b else a + b
    @bits.set @value
    if @out then
      log "ALU writing to bus:", @value
      bus.set @value

