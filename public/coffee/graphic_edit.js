(function() {
  var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
  $(document).ready(__bind(function() {
    var a;
    a = $("#load");
    return (window.nodes_n = eval(a.attr("code")));
  }, this));
}).call(this);
