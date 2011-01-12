(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $(document).ready(__bind(function() {
    var render_inline, resize, show_mistake, update_graph;
    window.debug = false;
    window.graph_large = false;
    $("#accordion").accordion();
    $(".ui-accordion-content")[0].style.height = "40px";
    $(".ui-accordion-content")[1].style.height = "320px";
    $(".ui-accordion-content")[3].style.height = "40px";
    $("#submit").button();
    $("#submit").click(function() {
      return $("form").submit();
    });
    $("#accordion").accordion("activate", 2);
    resize = function() {
      if (!window.graph_large) {
        $("#text_graph_image").removeClass("text_graph_image_small");
        $("#text_graph_image").addClass("text_graph_image_large");
        return window.graph_large = true;
      } else {
        $("#text_graph_image").removeClass("text_graph_image_large");
        $("#text_graph_image").addClass("text_graph_image_small");
        return window.graph_large = false;
      }
    };
    render_inline = function(data) {
      var anchor;
      anchor = $("#text_graph");
      anchor.html("<img id=text_graph_image class=text_graph_image_small src=" + data.png + " style='opacity:0.9;z-index:10000'></img>");
      $("#text_graph").show();
      return $("#text_graph").click(resize);
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
        return $('#text_graph').html(error_obj.responseText);
      } else {
        return $('#text_graph').html("<h3>ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!</h3");
      }
    };
    window.show_mistake = show_mistake;
    $('#text_graph').ajaxError(function(o, e) {
      return show_mistake(e);
    });
    $('#update_graph_button').button().click(function(evt) {
      update_graph();
      return false;
    });
    return window.update_graph = update_graph;
  }, this));
}).call(this);
