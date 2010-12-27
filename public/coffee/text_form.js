(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $(document).ready(__bind(function() {
    var render_inline, resize_graph, show_mistake, update_graph;
    window.debug = false;
    $("#accordion").accordion();
    $(".ui-accordion-content")[0].style.height = "40px";
    $(".ui-accordion-content")[1].style.height = "140px";
    $(".ui-accordion-content")[3].style.height = "40px";
    $("#submit").button();
    $("#submit").click(function() {
      return $("form").submit();
    });
    $("#accordion").accordion("activate", 2);
    resize_graph = function() {
      return $($("img")[0]).load(function() {
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
        return $($("img")[0]).show();
      });
    };
    render_inline = function(data) {
      var anchor;
      anchor = $("#inline_graph");
      anchor.html("<img id=graph src=" + data.png + " style='opacity:0.9;z-index:10000'></img>");
      $("#inline_graph").show();
      return resize_graph();
    };
    update_graph = function() {
      var result, z;
      result = $("#edit").val();
      z = $.post("/graphic_edit_view", {
        "text": result,
        "dataType": "json"
      }, function(data) {
        return render_inline(JSON.parse(data));
      });
      return z;
    };
    update_graph();
    show_mistake = function(error_obj) {
      window.error_obj = error_obj;
      if (window.debug) {
        return $('#inline_graph').html(error_obj.responseText);
      } else {
        return $('#inline_graph').html("<h3>ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!</h3");
      }
    };
    window.show_mistake = show_mistake;
    $('#inline_graph').ajaxError(function(o, e) {
      return show_mistake(e);
    });
    $(document).bind('keydown', 'Return', function(evt) {
      return update_graph();
    });
    return window.update_graph = update_graph;
  }, this));
}).call(this);
