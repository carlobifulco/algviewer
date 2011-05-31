(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $(document).ready(__bind(function() {
    var colorme;
    colorme = function(color) {
      var b, g, r, result;
      console.log(color.color);
      r = Math.round(color.color.rgb[0] * 255);
      g = Math.round(color.color.rgb[1] * 255);
      b = Math.round(color.color.rgb[2] * 255);
      console.log(JSON.stringify([r, g, b]));
      result = "rgb(" + r + ", " + g + ", " + b + ")";
      console.log(result);
      return color;
    };
    return window.colorme = colorme;
  }, this));
}).call(this);
