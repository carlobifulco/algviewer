(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $(document).ready(__bind(function() {
    return $.get("/yaml/test?user_name=tester", __bind(function(e) {
      var o;
      console.log(e);
      o = {
        yaml_text: JSON.stringify(e),
        type: "json",
        algname: "test",
        user_name: "tester"
      };
      return $.post("/graph", o, __bind(function(r) {
        r = JSON.parse(r);
        console.log(r);
        console.log(r.svg);
        console.log(typeof r);
        return $("#svg").append("<a href=" + r.svg + "> SVG</a>");
      }, this));
    }, this));
  }, this));
}).call(this);
