
#
# General
#

export log = -> console.log ...; &0

export warn = -> console.warn ...; &0

export hex = (.to-string 16) >> (.to-upper-case!)
export dec = (.to-string 10)
export bin = (.to-string 2)

export to-array = (alo) -> Array::slice.apply alo

export wrap = (a, b, n) --> if n < a then b else if n > b then a else n

export invoke = (λ, ...args) -> λ ...args

export pad = (l, n) --> if n.length < l then (([ '0' ] * (l - n.length)).join '') + n else n


#
# DOM Helpers
#

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

