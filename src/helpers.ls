
# General

export log = -> console.log ...; &0

export warn = -> console.warn ...; &0

export invoke = (λ, ...args) -> λ ...args


# Numbers

export hex = (.to-string 16) >> (.to-upper-case!)
export dec = (.to-string 10)
export bin = (.to-string 2)

export wrap = (a, b, n) --> if n < a then b else if n > b then a else n

export nibbles = (byte) -> [ (byte .>>. 4), (byte .&. 15) ]


# Strings

export pad = (l, n) --> if n.length < l then (([ '0' ] * (l - n.length)).join '') + n else n


# Arrays

export to-array = (alo) -> Array::slice.apply alo

export unlines = (.join "\n")

export zip = (as, bs) ->
  out = []
  for a, ix in as
    b = bs[ix]
    out.push a
    out.push b
  return out


# DOM

export Q = (sel, scope = document) ->
  if typeof sel isnt \string
    sel
  else
    scope.query-selector sel

export QSA = (sel, scope = document) ->
  if typeof sel isnt \string
    sel
  else
    to-array scope.query-selector-all sel

