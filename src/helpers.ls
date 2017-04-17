
#
# General
#

export log = -> console.log ...; &0

export hex = (.to-string 16) >> (.to-upper-case!)

export to-array = (alo) -> Array::slice.apply alo

export wrap = (a, b, n) --> if n < a then b else if n > b then a else n

export invoke = (λ, ...args) -> λ ...args

export pad2 = (n, base = 10) -> if n < base then \0 + n.to-string base else n

export pad4 = (n, base = 10) ->
  if      n < base * 3 then \000 + n.to-string base
  else if n < base * 2 then \00  + n.to-string base
  else if n < base * 1 then \0   + n.to-string base
  else    n.to-string base


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

