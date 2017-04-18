

{ log } = require \helpers

Flag    = require \../components/flag
LedBits = require \../components/ledbits
Module  = require \./module


#
# Control Readout
#
# Shows which switches are enabled by the console logic and lets the user
# flip them manually
#

module.exports = class ControlReadout extends Module

  (sel) ->
    super ...

    # State
    @flag \hlt
    @flag \mi
    @flag \ri
    @flag \ro
    @flag \io
    @flag \ii
    @flag \ai
    @flag \ao
    @flag \eo
    @flag \su
    @flag \bi
    @flag \oi
    @flag \ce
    @flag \co
    @flag \j

    @flags =
      hlt: new Flag '[data-cv="hlt"]', @dom
      mi:  new Flag '[data-cv="mi"]',  @dom
      ri:  new Flag '[data-cv="ri"]',  @dom
      ro:  new Flag '[data-cv="ro"]',  @dom
      io:  new Flag '[data-cv="io"]',  @dom
      ii:  new Flag '[data-cv="ii"]',  @dom
      ai:  new Flag '[data-cv="ai"]',  @dom
      ao:  new Flag '[data-cv="ao"]',  @dom
      eo:  new Flag '[data-cv="eo"]',  @dom
      su:  new Flag '[data-cv="su"]',  @dom
      bi:  new Flag '[data-cv="bi"]',  @dom
      oi:  new Flag '[data-cv="oi"]',  @dom
      ce:  new Flag '[data-cv="ce"]',  @dom
      co:  new Flag '[data-cv="co"]',  @dom
      j:   new Flag '[data-cv="j"]',   @dom

  write: ->
    @value = it

  clock: ->



