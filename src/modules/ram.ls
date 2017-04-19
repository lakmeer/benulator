
{ log, warn } = require \helpers

Flag       = require \../components/flag
LedBits    = require \../components/ledbits
MemoryDump = require \../components/memory
Module     = require \./module

unlines = (.join "\n")


#
# RAM Module
#
# Need explicit coupling to the MAR.
#

module.exports = class RAM extends Module

  ->
    super ...

    # Memory
    @contents = [
      2~00011110 # 0: LDA 14
      2~00101111 # 1: ADD 15
      2~11100000 # 2: OUT <nil>
      2~11110000 # 3: HLT <nil>
      2~0        # 4: <niL>
      2~0        # 5: <niL>
      2~0        # 6: <niL>
      2~0        # 7: <niL>
      2~0        # 8: <niL>
      2~0        # 9: <niL>
      2~0        # A: <niL>
      2~0        # B: <niL>
      2~0        # C: <niL>
      2~0        # D: <niL>
      2~00011100 # E: 28 const
      2~00001111 # F: 14 const
    ]

    #@dump!

    # State
    @flag \in
    @flag \out
    @inputs = mar: { value: 0 }
    @addr   = 0
    @value  = @contents[@addr]

    # Components
    @bits = new LedBits    '[data-ram-bit]'
    @dump = new MemoryDump '[data-ram-dump]'
    @flags =
      in:  new Flag '[data-ram-flag="in"]'
      out: new Flag '[data-ram-flag="out"]'

    # Init
    @dump.set @contents, @addr, @in
    @bits.set @value

  expose-register: (name, reg) ->
    @inputs[name] = reg

  dump: ->
    log unlines [ 'ADDR   BINARY    HEX DEC' ] ++
      for val, addr in @contents
        ' ' + (pad 2, hex addr) + '    ' + (pad 8, bin val) + '  ' + (pad 2, hex val) + '  ' + (pad 3, dec val)

  move: (addr) ->
    @addr  = addr
    @value = @contents[@addr]
    @bits.set @value
    @dump.set @contents, @addr, @in

  rise: (bus) ->
    if @out then bus.set @value

  fall: (bus) ->
    @move @inputs.mar.value

