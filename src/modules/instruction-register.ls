
{ id, log, nibbles } = require \helpers

Segment = require \../components/segment
LedBits = require \../components/ledbits
Flag    = require \../components/flag
Module  = require \./module


#
# Instruction Register
#
# Reads in the next instruction (4 bits) and it's argument (another 4 bits)
#

module.exports = class InstructionRegister extends Module

  ->
    super ...

    # State
    @flag \in
    @flag \out
    @value = 0
    @instr = 0
    @arg   = 0

    # Components
    @bits = new LedBits '[data-instr-bit]'
    @flags =
      in:  new Flag '[data-instr-flag="in"]'
      out: new Flag '[data-instr-flag="out"]'
    @digits =
      instr: new Segment '[data-instr-value]'
      arg:   new Segment '[data-arg-value]'

  write: (value) ->
    @value = value
    [ @instr, @arg ] = nibbles @value
    @bits.set @value
    @digits.instr.set @instr
    @digits.arg.set @arg

  rise: (bus) ->
    if @out then bus.set @arg

  fall: (bus) ->
    if @in then @write bus.value

