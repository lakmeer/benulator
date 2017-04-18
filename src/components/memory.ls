
{ log, Q, pad, hex, dec, bin, zip } = require \helpers

#EMPTY = \▢
#FULL  = \▣

EMPTY = \◻
FULL  = \◼

row = (v, selected) ->
  b = (pad 8, bin v) |> (.replace /0/g, EMPTY) |> (.replace /1/g, FULL)
  #h = (pad 2, hex v)
  #d = (pad 3, dec v)
  #"#b[#h|#d]"
  if selected then \▸ + b + \◂ else " #b "


#
# Memory Dump
#
# Show the contents of some eeprom or memory register
#

module.exports = class MemoryDump

  (sel) ->
    @dom = Q sel

  set: (cells, addr) ->
    l = cells.length
    z = l/2
    a = [ (row v, addr is i + 0) + "  " for v, i in cells[0 til l/2] ]
    b = [ (row v, addr is i + z) + "\n" for v, i in cells[l/2 to  l] ]
    @dom.text-content = (zip a, b).join ''

