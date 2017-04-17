
{ log, pad, hex, bin, dec } = require \helpers

Flag    = require \../components/flag
LedBits = require \../components/ledbits
Module = require \./module

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
      2~0        # 3: <niL>
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
      2~00001110 # F: 14 const
    ]

    #@dump!

    # State
    @flag \in
    @flag \out
    @inputs = mar: { value: 0 }
    @addr   = 0
    @value  = @contents.0

    # Components
    @bits  = new LedBits '[data-ram-bit]'
    @flags =
      in:  new Flag '[data-ram-flag="in"]'
      out: new Flag '[data-ram-flag="out"]'

    # Init
    @flags.in.on-click  ~> @flip \in
    @flags.out.on-click ~> @flip \out

  expose-register: (name, reg) ->
    @inputs[name] = reg

  dump: ->
    log unlines [ 'ADDR   BINARY    HEX DEC' ] ++
      for val, addr in @contents
        ' ' + (pad 2, hex addr) + '    ' + (pad 8, bin val) + '  ' + (pad 2, hex val) + '  ' + (pad 3, dec val)

