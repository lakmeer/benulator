
{ log, Q, pad, hex, dec, bin, nibbles } = require \helpers

#EMPTY = \▢
#FULL  = \▣

EMPTY = \◼
FULL  = \◻
JOIN  = \<br>  # Vertical
JOIN  = ''     # Horizontal
READ  = \read
WRITE = \write

bin-to-cell = (b) -> b.replace(/0/g, EMPTY).replace(/1/g, FULL)

row = (v, addr, i, mode) ->
  #cell = [ hex addr ] ++ (bin-to-cell (pad 8, bin v)).split('') ++ [ '', pad 2, hex v ]
  cell = (bin-to-cell (pad 8, bin v)).split('') # ++ [ '', pad 2, hex v ]
  "<div data-addr='#addr' data-value='#v' " + (if addr is i then mode else "") + ">" + (cell.join JOIN) + "</div>"

inspect-text = (value, addr) ->
  [ high, low ] = nibbles value
  instr = <[ NOP LDA ADD ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ OUT HLT ]>[high]

  if value === 0
    "#addr: <empty>"
  else if instr === \NOP
    "#addr: #value literal"
  else if low === 0
    "#addr: #instr"
  else
    "#addr: #instr #low OR #value literal"


hide = (node) -> node.style.display = \none
show = (node) -> node.style.display = \block
move = (node, x, y) -> node.style <<< left: x + \px, top: y + \px


#
# Memory Dump
#
# Show the contents of some eeprom or memory register
#

module.exports = class MemoryDump

  inspector = document.create-element \div
  inspector.class-list.add \inspector
  hide inspector

  (sel) ->
    @dom = Q sel

    update-inspector = (v, a, x, y) ->
      move inspector, x + 4, y
      inspector.text-content = inspect-text (parse-int v), a
      show inspector

    @dom.add-event-listener 'mouseover', ({ target, pageX, pageY }) ~>
      data = target.dataset
      update-inspector data.value, data.addr, pageX, pageY

    @dom.add-event-listener 'mousemove', ({{ dataset }:target, pageX, pageY }) ~>
      update-inspector dataset.value, dataset.addr, pageX, pageY

    @dom.add-event-listener 'mouseout', ({ target }) ~>
      hide inspector

    document.body.append-child inspector

  set: (cells, addr, write-enabled = false) ->
    mode = if write-enabled then WRITE else READ
    @dom.innerHTML = [ (row v, i, addr, mode) for v, i in cells ].join ''

