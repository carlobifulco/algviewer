(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $(document).ready(__bind(function() {
    var alg_name;
    $("#accordion").accordion();
    $(".links").button();
    $($("img")[0]).load(function() {
      var h, r, size, w;
      w = $("img")[0].width;
      h = $("img")[0].height;
      if (!(w < 500 && h < 500)) {
        r = w / h;
        size = 500;
        if (r > 1) {
          $("img")[0].height = size / r;
          $("img")[0].width = size;
        }
        if (r <= 1) {
          $("img")[0].width = size * r;
          $("img")[0].height = size;
        }
      }
      $($("img")[0]).show();
      return $(".ui-accordion-content")[0].style.height = "" + ($('img')[0].height) + "px";
    });
    alg_name = _.last(window.location.pathname.split("/"));
    $("#title").html(alg_name);
    $($("img")[0]).hide();
    return _.each($(".small_acc"), function(e) {
      return e.style.height = "40px";
    });
  }, this));
}).call(this);
