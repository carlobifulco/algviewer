(function() {
  var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
  $(document).ready(__bind(function() {
    var a, chosen, enter_text, get_pos, make_rect, sort_rect, sort_rectb, z;
    window.rectangles = [];
    make_rect = function() {
      var a, b, text_box;
      b = $("#containment-wrapper");
      text_box = $("<div class='ui-widget-content selectable text_box' style='position: absolute'> TEST</div>");
      a = text_box.draggable({
        "grid": [20, 20],
        "opacity": 0.35,
        "refreshPositions": "true",
        "containment": "parent"
      }).appendTo(".new_box");
      window.rectangles.push(a);
      return (window.last = a);
    };
    enter_text = function() {
      var b;
      b = $(".ui-selected")[0];
      if (b) {
        b.innerText = document.text_form.text_content.value;
        return (document.text_form.text_content.value = "");
      }
    };
    chosen = function() {
      $(".text_box").css("color", "black");
      $(".ui-selected").css("color", "red");
      return $(".ancor").css("color", "black");
    };
    get_pos = function(text_box) {
      return $(text_box).position().top;
    };
    window.get_pos = get_pos;
    sort_rect = function() {
      var _i, _len, _ref, _result, a, text_box;
      a = (function() {
        _result = []; _ref = $(".text_box");
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          text_box = _ref[_i];
          _result.push(get_pos(text_box));
        }
        return _result;
      })();
      alert(a);
      return a;
    };
    window.sort_rect = sort_rect;
    $(document).bind('keydown', 'Ctrl+n', make_rect);
    $(document).bind('keydown', 'Ctrl+e', enter_text);
    z = 0;
    sort_rectb = function() {
      return alert([1, 2, 3, 4, 3]);
    };
    $("button").button();
    $("button").bind('click', function(event) {
      return sort_rect();
    });
    $(".selectable").selectable({
      "selected": chosen
    });
    $(".draggable").draggable();
    a = $('.alert').css("color", "yellow");
    $('.alert').bind('click', function(event) {
      return alert("ORCA");
    });
    $(".hide_edit").hide();
    return $("#view_view").click(__bind(function() {
      $(".hide_edit").toggle();
      z = !z;
      if (z) {
        $("#view_view").html("HIDE HERE");
      }
      if (!z) {
        return $("#view_view").html("SHOW HERE");
      }
    }, this));
  }, this));
}).call(this);
