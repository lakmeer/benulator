(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var Led, Flag;
Led = require('./led');
module.exports = Flag = (function(superclass){
  var prototype = extend$((import$(Flag, superclass).displayName = 'Flag', Flag), superclass).prototype, constructor = Flag;
  function Flag(){
    Flag.superclass.apply(this, arguments);
  }
  return Flag;
}(Led));
function extend$(sub, sup){
  function fun(){} fun.prototype = (sub.superclass = sup).prototype;
  (sub.prototype = new fun).constructor = sub;
  if (typeof sup.extended == 'function') sup.extended(sub);
  return sub;
}
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}



},{"./led":2}],2:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var ref$, log, Q, Led;
ref$ = require('helpers'), log = ref$.log, Q = ref$.Q;
module.exports = Led = (function(){
  Led.displayName = 'Led';
  var prototype = Led.prototype, constructor = Led;
  function Led(sel){
    this.dom = Q(sel);
  }
  prototype.on = function(){
    return this.dom.setAttribute('on', true);
  };
  prototype.off = function(){
    return this.dom.removeAttribute('on');
  };
  prototype.set = function(it){
    if (it) {
      return this.on();
    } else {
      return this.off();
    }
  };
  return Led;
}());



},{"helpers":5}],3:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var ref$, log, QSA, Led, LedBits;
ref$ = require('helpers'), log = ref$.log, QSA = ref$.QSA;
Led = require('./led');
module.exports = LedBits = (function(){
  LedBits.displayName = 'LedBits';
  var prototype = LedBits.prototype, constructor = LedBits;
  function LedBits(sel){
    this.dom = QSA(sel).reverse();
    this.leds = this.dom.map(function(it){
      return new Led(it);
    });
  }
  prototype.set = function(it){
    var i$, ref$, len$, ix, led, results$ = [];
    for (i$ = 0, len$ = (ref$ = this.leds).length; i$ < len$; ++i$) {
      ix = i$;
      led = ref$[i$];
      results$.push(led.set(it >> ix & 1));
    }
    return results$;
  };
  return LedBits;
}());



},{"./led":2,"helpers":5}],4:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var ref$, log, Q, hex, Segment;
ref$ = require('helpers'), log = ref$.log, Q = ref$.Q, hex = ref$.hex;
module.exports = Segment = (function(){
  Segment.displayName = 'Segment';
  var prototype = Segment.prototype, constructor = Segment;
  function Segment(sel){
    this.dom = Q(sel);
  }
  prototype.set = function(it){
    return this.dom.textContent = hex(it);
  };
  return Segment;
}());



},{"helpers":5}],5:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var log, hex, toArray, wrap, invoke, pad2, pad4, Q, QSA, out$ = typeof exports != 'undefined' && exports || this, slice$ = [].slice;
out$.log = log = function(){
  console.log.apply(this, arguments);
  return arguments[0];
};
out$.hex = hex = compose$(function(it){
  return it.toString(16);
}, function(it){
  return it.toUpperCase();
});
out$.toArray = toArray = function(alo){
  return Array.prototype.slice.apply(alo);
};
out$.wrap = wrap = curry$(function(a, b, n){
  if (n < a) {
    return b;
  } else if (n > b) {
    return a;
  } else {
    return n;
  }
});
out$.invoke = invoke = function(λ){
  var args;
  args = slice$.call(arguments, 1);
  return λ.apply(null, args);
};
out$.pad2 = pad2 = function(n, base){
  base == null && (base = 10);
  if (n < base) {
    return '0' + n.toString(base);
  } else {
    return n;
  }
};
out$.pad4 = pad4 = function(n, base){
  base == null && (base = 10);
  if (n < base * 3) {
    return '000' + n.toString(base);
  } else if (n < base * 2) {
    return '00' + n.toString(base);
  } else if (n < base * 1) {
    return '0' + n.toString(base);
  } else {
    return n.toString(base);
  }
};
out$.Q = Q = function(sel, scope){
  scope == null && (scope = document);
  if (typeof sel !== 'string') {
    return sel;
  } else {
    return scope.querySelector(sel);
  }
};
out$.QSA = QSA = function(sel, scope){
  scope == null && (scope = document);
  if (typeof sel !== 'string') {
    return sel;
  } else {
    return toArray(scope.querySelectorAll(sel));
  }
};
function compose$() {
  var functions = arguments;
  return function() {
    var i, result;
    result = functions[0].apply(this, arguments);
    for (i = 1; i < functions.length; ++i) {
      result = functions[i](result);
    }
    return result;
  };
}
function curry$(f, bound){
  var context,
  _curry = function(args) {
    return f.length > 1 ? function(){
      var params = args ? args.concat() : [];
      context = bound ? context || this : this;
      return params.push.apply(params, arguments) <
          f.length && arguments.length ?
        _curry.call(context, params) : f.apply(context, params);
    } : f;
  };
  return _curry();
}



},{}],6:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var ref$, log, pad2, wrap, Q, invoke, hex, Led, Flag, LedBits, Segment, Module, Clock, ProgramCounter, Mainbus, init;
ref$ = require('helpers'), log = ref$.log, pad2 = ref$.pad2, wrap = ref$.wrap, Q = ref$.Q, invoke = ref$.invoke, hex = ref$.hex;
Led = require('./components/led');
Flag = require('./components/flag');
LedBits = require('./components/ledbits');
Segment = require('./components/segment');
Module = require('./modules/module');
Clock = require('./modules/clock');
ProgramCounter = require('./modules/program-counter');
Mainbus = require('./modules/mainbus');
init = function(){
  var clock, pc, bus;
  clock = new Clock('#clock');
  pc = new ProgramCounter('#program-counter');
  bus = new Mainbus('#mainbus');
  pc.set('ce', true);
  return clock.onClock(function(){
    pc.clock();
    pc.set('co', !pc.co);
    if (pc.co) {
      return bus.set(pc.value);
    }
  });
};
document.addEventListener('DOMContentLoaded', init);



},{"./components/flag":1,"./components/led":2,"./components/ledbits":3,"./components/segment":4,"./modules/clock":7,"./modules/mainbus":8,"./modules/module":9,"./modules/program-counter":10,"helpers":5}],7:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var ref$, log, invoke, Led, Module, Clock;
ref$ = require('helpers'), log = ref$.log, invoke = ref$.invoke;
Led = require('../components/led');
Module = require('./module');
module.exports = Clock = (function(superclass){
  var prototype = extend$((import$(Clock, superclass).displayName = 'Clock', Clock), superclass).prototype, constructor = Clock;
  function Clock(sel){
    this.blip = bind$(this, 'blip', prototype);
    Clock.superclass.apply(this, arguments);
    this.halt = false;
    this.rate = 500;
    this.callbacks = [];
    this.signal = new Led('[data-clock-signal]');
    this.blip();
  }
  prototype.blip = function(){
    if (!this.halt) {
      this.signal.on();
      setTimeout(bind$(this.signal, 'off'), this.rate / 2);
      setTimeout(this.blip, this.rate);
      return this.callbacks.map(invoke);
    }
  };
  prototype.onClock = function(λ){
    return this.callbacks.push(λ);
  };
  return Clock;
}(Module));
function bind$(obj, key, target){
  return function(){ return (target || obj)[key].apply(obj, arguments) };
}
function extend$(sub, sup){
  function fun(){} fun.prototype = (sub.superclass = sup).prototype;
  (sub.prototype = new fun).constructor = sub;
  if (typeof sup.extended == 'function') sup.extended(sub);
  return sub;
}
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}



},{"../components/led":2,"./module":9,"helpers":5}],8:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var ref$, log, pad2, LedBits, Segment, Module, Mainbus;
ref$ = require('helpers'), log = ref$.log, pad2 = ref$.pad2;
LedBits = require('../components/ledbits');
Segment = require('../components/segment');
Module = require('./module');
module.exports = Mainbus = (function(superclass){
  var prototype = extend$((import$(Mainbus, superclass).displayName = 'Mainbus', Mainbus), superclass).prototype, constructor = Mainbus;
  function Mainbus(){
    Mainbus.superclass.apply(this, arguments);
    this.value = 0;
    this.bits = new LedBits('[data-mb-bit]');
    this.digit = new Segment('[data-mb-value]');
  }
  prototype.set = function(it){
    this.value = it;
    this.bits.set(it);
    return this.digit.set(pad2(it, 16));
  };
  return Mainbus;
}(Module));
function extend$(sub, sup){
  function fun(){} fun.prototype = (sub.superclass = sup).prototype;
  (sub.prototype = new fun).constructor = sub;
  if (typeof sup.extended == 'function') sup.extended(sub);
  return sub;
}
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}



},{"../components/ledbits":3,"../components/segment":4,"./module":9,"helpers":5}],9:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var ref$, log, Q, Module;
ref$ = require('helpers'), log = ref$.log, Q = ref$.Q;
module.exports = Module = (function(){
  Module.displayName = 'Module';
  var prototype = Module.prototype, constructor = Module;
  function Module(sel){
    this.dom = Q(sel);
  }
  prototype.clock = function(){
    return log('clock', this);
  };
  return Module;
}());



},{"helpers":5}],10:[function(require,module,exports){
// Generated by LiveScript 1.4.0
var ref$, log, wrap, LedBits, Segment, Flag, Module, ProgramCounter;
ref$ = require('helpers'), log = ref$.log, wrap = ref$.wrap;
LedBits = require('../components/ledbits');
Segment = require('../components/segment');
Flag = require('../components/flag');
Module = require('./module');
module.exports = ProgramCounter = (function(superclass){
  var prototype = extend$((import$(ProgramCounter, superclass).displayName = 'ProgramCounter', ProgramCounter), superclass).prototype, constructor = ProgramCounter;
  function ProgramCounter(){
    ProgramCounter.superclass.apply(this, arguments);
    this.ce = false;
    this.co = false;
    this.value = 0;
    this.bits = new LedBits('[data-pc-bit]');
    this.digit = new Segment('[data-pc-value]');
    this.flags = {
      ce: new Flag('[data-pc-flag="ce"]'),
      co: new Flag('[data-pc-flag="co"]')
    };
  }
  prototype.set = function(flag, val){
    if (this[flag] == null) {
      return console.warn('ProgramCounter::set - no such flag:', flag);
    }
    this[flag] = val;
    return this.flags[flag].set(val);
  };
  prototype.clock = function(){
    if (this.ce) {
      this.value = wrap(0, 15, this.value + 1);
      this.bits.set(this.value);
      return this.digit.set(this.value);
    }
  };
  return ProgramCounter;
}(Module));
function extend$(sub, sup){
  function fun(){} fun.prototype = (sub.superclass = sup).prototype;
  (sub.prototype = new fun).constructor = sub;
  if (typeof sup.extended == 'function') sup.extended(sub);
  return sub;
}
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}



},{"../components/flag":1,"../components/ledbits":3,"../components/segment":4,"./module":9,"helpers":5}]},{},[6])
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvaG9tZS9sYWttZWVyL2NvZGUvYmVudWxhdG9yL3NyYy9jb21wb25lbnRzL2ZsYWcubHMiLCIvaG9tZS9sYWttZWVyL2NvZGUvYmVudWxhdG9yL3NyYy9jb21wb25lbnRzL2xlZC5scyIsIi9ob21lL2xha21lZXIvY29kZS9iZW51bGF0b3Ivc3JjL2NvbXBvbmVudHMvbGVkYml0cy5scyIsIi9ob21lL2xha21lZXIvY29kZS9iZW51bGF0b3Ivc3JjL2NvbXBvbmVudHMvc2VnbWVudC5scyIsIi9ob21lL2xha21lZXIvY29kZS9iZW51bGF0b3Ivc3JjL2hlbHBlcnMubHMiLCIvaG9tZS9sYWttZWVyL2NvZGUvYmVudWxhdG9yL3NyYy9pbmRleC5scyIsIi9ob21lL2xha21lZXIvY29kZS9iZW51bGF0b3Ivc3JjL21vZHVsZXMvY2xvY2subHMiLCIvaG9tZS9sYWttZWVyL2NvZGUvYmVudWxhdG9yL3NyYy9tb2R1bGVzL21haW5idXMubHMiLCIvaG9tZS9sYWttZWVyL2NvZGUvYmVudWxhdG9yL3NyYy9tb2R1bGVzL21vZHVsZS5scyIsIi9ob21lL2xha21lZXIvY29kZS9iZW51bGF0b3Ivc3JjL21vZHVsZXMvcHJvZ3JhbS1jb3VudGVyLmxzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBOzs7QUNDQSxHQUFJLENBQUEsQ0FBQSxDQUFFLFFBQVEsT0FBQTtBQUVkLE1BQU0sQ0FBQyxPQUFRLENBQUEsQ0FBQSxDQUFRLFFBQU4sUUFBQSxDQUFBLFVBQUE7Ozs7OztFQUFXOzs7Ozs7Ozs7Ozs7Ozs7Ozs7QUNGNUIsSUFBQSxHQUFhLE9BQWIsQ0FBcUIsU0FBQSxDQUFyQixFQUFFLEdBQVMsQ0FBQSxDQUFBLENBQVgsSUFBQSxDQUFFLEdBQUYsRUFBTyxDQUFJLENBQUEsQ0FBQSxDQUFYLElBQUEsQ0FBTztBQVNQLE1BQU0sQ0FBQyxPQUFRLENBQUEsQ0FBQSxDQUFRLE9BQU4sUUFB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QUNFLElBQUMsQ0FBQSxLQUFNLENBQUEsQ0FBQSxDQUFFLEtBQUssR0FBRyxJQUFJLElBQUMsQ0FBQSxLQUFNLENBQUEsQ0FBQSxDQUFFLENBQWhCO01BQ2QsSUFBQyxDQUFBLElBQUksQ0FBQyxJQUFLLElBQUMsQ0FBQSxLQUFEO2FBQ1gsSUFBQyxDQUFBLEtBQUssQ0FBQyxJQUFJLElBQUMsQ0FBQSxLQUFEOzs7O0VBMUJxQiIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJcbkxlZCA9IHJlcXVpcmUgXFwuL2xlZFxuXG5tb2R1bGUuZXhwb3J0cyA9IGNsYXNzIEZsYWcgZXh0ZW5kcyBMZWRcblxuIiwiXG57IGxvZywgUSB9ID0gcmVxdWlyZSBcXGhlbHBlcnNcblxuXG4jXG4jIExFRFxuI1xuIyBBIHNpZ25sZSBMRUQgZGlzcGxheS4gQ29tZXMgaW4gNCBjb2xvcnMuXG4jXG5cbm1vZHVsZS5leHBvcnRzID0gY2xhc3MgTGVkXG4gIChzZWwpIC0+XG4gICAgQGRvbSA9IFEgc2VsXG5cbiAgb246IC0+XG4gICAgQGRvbS5zZXQtYXR0cmlidXRlIFxcb24sIHRydWVcblxuICBvZmY6IC0+XG4gICAgQGRvbS5yZW1vdmUtYXR0cmlidXRlIFxcb25cblxuICBzZXQ6IC0+XG4gICAgaWYgaXQgdGhlbiBAb24hIGVsc2UgQG9mZiFcblxuIiwiXG57IGxvZywgUVNBIH0gPSByZXF1aXJlIFxcaGVscGVyc1xuXG5MZWQgPSByZXF1aXJlIFxcLi9sZWRcblxuXG5tb2R1bGUuZXhwb3J0cyA9IGNsYXNzIExlZEJpdHNcblxuICAoc2VsKSAtPlxuICAgIEBkb20gPSBRU0Egc2VsIC5yZXZlcnNlIVxuICAgIEBsZWRzID0gQGRvbS5tYXAgLT4gbmV3IExlZCBpdFxuXG4gIHNldDogLT5cbiAgICBmb3IgbGVkLCBpeCBpbiBAbGVkc1xuICAgICAgbGVkLnNldCBpdCAuPj4uIGl4IC4mLiAxXG5cbiIsIlxueyBsb2csIFEsIGhleCB9ID0gcmVxdWlyZSBcXGhlbHBlcnNcblxuXG4jIFNlZ21lbnRcbiNcbiMgQSA3LXNlZ21lbnQgZGlzcGxheS4gSXQncyBub3QgU2VnbWVudCdzIGpvYiB0byBjb250cm9sIGhvdyBtYW55IGRpZ2l0cyBpdFxuIyBzaG93cywgdGhlIGNvbnRyb2xsaW5nIG1vZHVsZSBzaG91bGQgY2xhbXAgaXQncyB2YWx1ZXMgYXBwcm9wcmlhdGVseS5cblxubW9kdWxlLmV4cG9ydHMgPSBjbGFzcyBTZWdtZW50XG4gIChzZWwpIC0+XG4gICAgQGRvbSA9IFEgc2VsXG5cbiAgc2V0OiAtPlxuICAgIEBkb20udGV4dC1jb250ZW50ID0gaGV4IGl0XG5cbiIsIlxuI1xuIyBHZW5lcmFsXG4jXG5cbmV4cG9ydCBsb2cgPSAtPiBjb25zb2xlLmxvZyAuLi47ICYwXG5cbmV4cG9ydCBoZXggPSAoLnRvLXN0cmluZyAxNikgPj4gKC50by11cHBlci1jYXNlISlcblxuZXhwb3J0IHRvLWFycmF5ID0gKGFsbykgLT4gQXJyYXk6OnNsaWNlLmFwcGx5IGFsb1xuXG5leHBvcnQgd3JhcCA9IChhLCBiLCBuKSAtLT4gaWYgbiA8IGEgdGhlbiBiIGVsc2UgaWYgbiA+IGIgdGhlbiBhIGVsc2UgblxuXG5leHBvcnQgaW52b2tlID0gKM67LCAuLi5hcmdzKSAtPiDOuyAuLi5hcmdzXG5cbmV4cG9ydCBwYWQyID0gKG4sIGJhc2UgPSAxMCkgLT4gaWYgbiA8IGJhc2UgdGhlbiBcXDAgKyBuLnRvLXN0cmluZyBiYXNlIGVsc2UgblxuXG5leHBvcnQgcGFkNCA9IChuLCBiYXNlID0gMTApIC0+XG4gIGlmICAgICAgbiA8IGJhc2UgKiAzIHRoZW4gXFwwMDAgKyBuLnRvLXN0cmluZyBiYXNlXG4gIGVsc2UgaWYgbiA8IGJhc2UgKiAyIHRoZW4gXFwwMCAgKyBuLnRvLXN0cmluZyBiYXNlXG4gIGVsc2UgaWYgbiA8IGJhc2UgKiAxIHRoZW4gXFwwICAgKyBuLnRvLXN0cmluZyBiYXNlXG4gIGVsc2UgICAgbi50by1zdHJpbmcgYmFzZVxuXG5cbiNcbiMgRE9NIEhlbHBlcnNcbiNcblxuZXhwb3J0IFEgPSAoc2VsLCBzY29wZSA9IGRvY3VtZW50KSAtPlxuICBpZiB0eXBlb2Ygc2VsIGlzbnQgXFxzdHJpbmdcbiAgICBzZWxcbiAgZWxzZVxuICAgIHNjb3BlLnF1ZXJ5LXNlbGVjdG9yIHNlbFxuXG5leHBvcnQgUVNBID0gKHNlbCwgc2NvcGUgPSBkb2N1bWVudCkgLT5cbiAgaWYgdHlwZW9mIHNlbCBpc250IFxcc3RyaW5nXG4gICAgc2VsXG4gIGVsc2VcbiAgICB0by1hcnJheSBzY29wZS5xdWVyeS1zZWxlY3Rvci1hbGwgc2VsXG5cbiIsIlxueyBsb2csIHBhZDIsIHdyYXAsIFEsIGludm9rZSwgaGV4IH0gPSByZXF1aXJlIFxcaGVscGVyc1xuXG5cbiMgU3ViY29tcG9uZW50c1xuXG5MZWQgICAgID0gcmVxdWlyZSBcXC4vY29tcG9uZW50cy9sZWRcbkZsYWcgICAgPSByZXF1aXJlIFxcLi9jb21wb25lbnRzL2ZsYWdcbkxlZEJpdHMgPSByZXF1aXJlIFxcLi9jb21wb25lbnRzL2xlZGJpdHNcblNlZ21lbnQgPSByZXF1aXJlIFxcLi9jb21wb25lbnRzL3NlZ21lbnRcblxuXG4jIE1vZHVsZXNcblxuTW9kdWxlICAgICAgICAgPSByZXF1aXJlIFxcLi9tb2R1bGVzL21vZHVsZVxuQ2xvY2sgICAgICAgICAgPSByZXF1aXJlIFxcLi9tb2R1bGVzL2Nsb2NrXG5Qcm9ncmFtQ291bnRlciA9IHJlcXVpcmUgXFwuL21vZHVsZXMvcHJvZ3JhbS1jb3VudGVyXG5NYWluYnVzICAgICAgICA9IHJlcXVpcmUgXFwuL21vZHVsZXMvbWFpbmJ1c1xuXG5cbiMgTWFpbiBQcm9ncmFtXG5cbmluaXQgPSAtPlxuXG4gIGNsb2NrID0gbmV3IENsb2NrIFxcI2Nsb2NrXG4gIHBjICAgID0gbmV3IFByb2dyYW1Db3VudGVyIFxcI3Byb2dyYW0tY291bnRlclxuICBidXMgICA9IG5ldyBNYWluYnVzIFxcI21haW5idXNcblxuXG4gIHBjLnNldCBcXGNlIG9uXG5cbiAgY2xvY2sub24tY2xvY2sgLT5cbiAgICBwYy5jbG9jayFcblxuICAgIHBjLnNldCBcXGNvICFwYy5jb1xuXG4gICAgaWYgcGMuY29cbiAgICAgIGJ1cy5zZXQgcGMudmFsdWVcblxuXG5cblxuZG9jdW1lbnQuYWRkLWV2ZW50LWxpc3RlbmVyIFxcRE9NQ29udGVudExvYWRlZCwgaW5pdFxuXG4iLCJcbnsgbG9nLCBpbnZva2UgfSA9IHJlcXVpcmUgXFxoZWxwZXJzXG5cbkxlZCAgICA9IHJlcXVpcmUgXFwuLi9jb21wb25lbnRzL2xlZFxuTW9kdWxlID0gcmVxdWlyZSBcXC4vbW9kdWxlXG5cblxuI1xuIyBDbG9ja1xuI1xuXG5tb2R1bGUuZXhwb3J0cyA9IGNsYXNzIENsb2NrIGV4dGVuZHMgTW9kdWxlXG5cbiAgKHNlbCkgLT5cbiAgICBzdXBlciAuLi5cblxuICAgICMgU3RhdGVcbiAgICBAaGFsdCA9IG5vXG4gICAgQHJhdGUgPSA1MDBcbiAgICBAY2FsbGJhY2tzID0gW11cblxuICAgICMgRGlzcGxheSBjb21wb25lbnRzXG4gICAgQHNpZ25hbCA9IG5ldyBMZWQgJ1tkYXRhLWNsb2NrLXNpZ25hbF0nXG5cbiAgICAjIEluaXRcbiAgICBAYmxpcCFcblxuICBibGlwOiB+PlxuICAgIGlmICFAaGFsdFxuICAgICAgQHNpZ25hbC5vbiFcbiAgICAgIHNldC10aW1lb3V0IEBzaWduYWx+b2ZmLCBAcmF0ZS8yXG4gICAgICBzZXQtdGltZW91dCBAYmxpcCwgQHJhdGVcbiAgICAgIEBjYWxsYmFja3MubWFwIGludm9rZVxuXG4gIG9uLWNsb2NrOiAozrspIC0+XG4gICAgQGNhbGxiYWNrcy5wdXNoIM67XG5cbiIsIlxueyBsb2csIHBhZDIgfSA9IHJlcXVpcmUgXFxoZWxwZXJzXG5cbkxlZEJpdHMgPSByZXF1aXJlIFxcLi4vY29tcG9uZW50cy9sZWRiaXRzXG5TZWdtZW50ID0gcmVxdWlyZSBcXC4uL2NvbXBvbmVudHMvc2VnbWVudFxuXG5Nb2R1bGUgPSByZXF1aXJlIFxcLi9tb2R1bGVcblxuXG4jXG4jIE1haW5idXNcbiNcblxubW9kdWxlLmV4cG9ydHMgPSBjbGFzcyBNYWluYnVzIGV4dGVuZHMgTW9kdWxlXG5cbiAgLT5cbiAgICBzdXBlciAuLi5cblxuICAgICMgU3RhdGVcbiAgICBAdmFsdWUgPSAwXG5cbiAgICAjIENvbXBvbmVudHNcbiAgICBAYml0cyAgPSBuZXcgTGVkQml0cyAnW2RhdGEtbWItYml0XSdcbiAgICBAZGlnaXQgPSBuZXcgU2VnbWVudCAnW2RhdGEtbWItdmFsdWVdJ1xuXG4gIHNldDogLT5cbiAgICBAdmFsdWUgPSBpdFxuICAgIEBiaXRzLnNldCBpdFxuICAgIEBkaWdpdC5zZXQgcGFkMiBpdCwgMTZcblxuIiwiXG57IGxvZywgUSB9ID0gcmVxdWlyZSBcXGhlbHBlcnNcblxuXG4jXG4jIE1vZHVsZSBDb21tb24gQmFzZVxuI1xuXG5tb2R1bGUuZXhwb3J0cyA9IGNsYXNzIE1vZHVsZVxuXG4gIChzZWwpIC0+XG4gICAgQGRvbSA9IFEgc2VsXG5cbiAgY2xvY2s6IC0+XG4gICAgbG9nIFxcY2xvY2sgdGhpc1xuXG4iLCJcbnsgbG9nLCB3cmFwIH0gPSByZXF1aXJlIFxcaGVscGVyc1xuXG5MZWRCaXRzID0gcmVxdWlyZSBcXC4uL2NvbXBvbmVudHMvbGVkYml0c1xuU2VnbWVudCA9IHJlcXVpcmUgXFwuLi9jb21wb25lbnRzL3NlZ21lbnRcbkZsYWcgICAgPSByZXF1aXJlIFxcLi4vY29tcG9uZW50cy9mbGFnXG5cbk1vZHVsZSA9IHJlcXVpcmUgXFwuL21vZHVsZVxuXG5cbiNcbiMgUHJvZ3JhbSBDb3VudGVyXG4jXG5cbm1vZHVsZS5leHBvcnRzID0gY2xhc3MgUHJvZ3JhbUNvdW50ZXIgZXh0ZW5kcyBNb2R1bGVcblxuICAtPlxuICAgIHN1cGVyIC4uLlxuXG4gICAgIyBTdGF0ZVxuICAgIEBjZSA9IG5vXG4gICAgQGNvID0gbm9cbiAgICBAdmFsdWUgPSAwXG5cbiAgICAjIENvbXBvbmVudHNcbiAgICBAYml0cyAgPSBuZXcgTGVkQml0cyAnW2RhdGEtcGMtYml0XSdcbiAgICBAZGlnaXQgPSBuZXcgU2VnbWVudCAnW2RhdGEtcGMtdmFsdWVdJ1xuICAgIEBmbGFncyA9XG4gICAgICBjZTogbmV3IEZsYWcgJ1tkYXRhLXBjLWZsYWc9XCJjZVwiXSdcbiAgICAgIGNvOiBuZXcgRmxhZyAnW2RhdGEtcGMtZmxhZz1cImNvXCJdJ1xuXG4gIHNldDogKGZsYWcsIHZhbCkgLT5cbiAgICBpZiBub3QgdGhpc1tmbGFnXT8gdGhlbiByZXR1cm4gY29uc29sZS53YXJuICdQcm9ncmFtQ291bnRlcjo6c2V0IC0gbm8gc3VjaCBmbGFnOicsIGZsYWdcbiAgICB0aGlzW2ZsYWddID0gdmFsXG4gICAgQGZsYWdzW2ZsYWddLnNldCB2YWxcblxuICBjbG9jazogLT5cbiAgICBpZiBAY2VcbiAgICAgIEB2YWx1ZSA9IHdyYXAgMCwgMTUsIEB2YWx1ZSArIDFcbiAgICAgIEBiaXRzLnNldCAgQHZhbHVlXG4gICAgICBAZGlnaXQuc2V0IEB2YWx1ZVxuXG4iXX0=