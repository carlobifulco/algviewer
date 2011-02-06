(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $(document).ready(__bind(function() {
    var get_text, render_inline, resize, set_text, show_mistake, update_graph;
    window.debug = false;
    window.graph_large = false;
    $("#accordion").accordion();
    $(".ui-accordion-content")[0].style.height = "40px";
    $(".ui-accordion-content")[1].style.height = "320px";
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
      anchor.html("<img id=text_graph_image class=text_graph_image_small src='http://" + data + "' style='opacity:0.9;z-index:10000'></img>");
      $("#text_graph").show();
      return $("#text_graph").click(resize);
    };
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
    update_graph = function() {
      return set_text();
    };
    $('#update_graph_button').button().click(function(evt) {
      update_graph();
      return false;
    });
    set_text = function() {
      var alg_name, text, url, user;
      alg_name = _.last(window.location.pathname.split("/"));
      text = $("#edit").val();
      user = localStorage.user;
      url = "/text/" + alg_name;
      return $.post(url, {
        "user_name": user,
        "content": text
      }).success(function(e) {
        return render_inline(e.png);
      });
    };
    get_text = function() {
      var alg_name, url, user;
      user = localStorage.user;
      alg_name = _.last(window.location.pathname.split("/"));
      url = "/text/" + alg_name;
      return $.get(url, {
        "user_name": user
      }).success(function(e) {
        return $("#edit").val(e);
      });
    };
    get_text();
    window.get_text = get_text;
    return window.set_text = set_text;
  }, this));
}).call(this);
