(function() {
  var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
  $(document).ready(__bind(function() {
    var a, alg_text, chosen, del_entry, enter_text, get_pos, grid, make_layout, make_rect, make_text_position, render_alg, rendering_ok, sort_rect, sort_rectb, text_multiply, unselected, x_start, y_start, z;
    window.rectangles = [];
    grid = 20;
    x_start = 40;
    y_start = 60 + $(".new_box").position().top;
    window.counter = 0;
    make_layout = function(i) {
      var text, text_box, x, y;
      text = i[0];
      x = x_start + (i[1] * grid);
      y = y_start + (window.counter * grid);
      text_box = $("<div class='ui-widget-content selectable text_box' style='position: absolute; left: " + (x) + "px; top: " + (y) + "px'>" + (text) + "</div>");
      text_box.draggable({
        "grid": [20, 20],
        "opacity": 0.35,
        "refreshPositions": "true",
        "containment": "parent"
      }).appendTo(".new_box");
      return window.counter += 1;
    };
    window.make_layout = make_layout;
    make_rect = function(evt) {
      var b, new_text, text_box;
      evt.stopPropagation();
      evt.preventDefault();
      b = $("#containment-wrapper");
      text_box = $("<div class='ui-widget-content selectable text_box' style='position: absolute; left: 40px'> TEST</div>");
      text_box.draggable({
        "grid": [20, 20],
        "opacity": 0.35,
        "refreshPositions": "true",
        "containment": "parent"
      }).appendTo(".new_box");
      new_text = document.text_form.text_content.value;
      if (new_text) {
        text_box.html(document.text_form.text_content.value);
      }
      document.text_form.text_content.value = "";
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
    del_entry = function() {
      return $(".ui-selected").remove();
    };
    unselected = function() {
      return chosen();
    };
    get_pos = function(text_box) {
      return $(text_box).position().top;
    };
    window.get_pos = get_pos;
    sort_rect = function() {
      var _i, _len, _ref, _result, sorted_box, sorted_boxes, text_boxes, text_positions;
      text_boxes = $(".text_box");
      sorted_boxes = _.sortBy(text_boxes, get_pos);
      window.sorted_boxes = sorted_boxes;
      text_positions = (function() {
        _result = []; _ref = sorted_boxes;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          sorted_box = _ref[_i];
          _result.push(make_text_position(sorted_box));
        }
        return _result;
      })();
      window.text_positions = text_positions;
      return text_positions;
    };
    make_text_position = function(text_box) {
      var pos_left, text;
      text = $(text_box).text();
      pos_left = $(text_box).position().left;
      return [text, pos_left];
    };
    alg_text = function(text_positions) {
      var _i, _len, _ref, baseline, offset, old_offset, text, text_position;
      text = "\n";
      baseline = text_positions[0][1];
      _ref = text_positions;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        text_position = _ref[_i];
        offset = text_multiply("  ", (text_position[1] - baseline) / grid);
        if (offset > old_offset) {
          text += old_offset + "-" + "\n";
        }
        if (text_position[1] === baseline) {
          text += "\n";
        }
        text += (offset + "- " + text_position[0] + "\n");
        old_offset = offset;
      }
      return text;
    };
    window.alg_text = alg_text;
    text_multiply = function(text, n) {
      var a, i;
      a = [];
      for (i = 0; (0 <= n ? i < n : i > n); (0 <= n ? i += 1 : i -= 1)) {
        a.push(text);
      }
      return a.join("");
    };
    window.text_multiply = text_multiply;
    rendering_ok = function(data) {
      $("#results").append(data);
      $("#progressbar").progressbar({
        "value": 100
      });
      $("#progressbar").progressbar({
        "value": 0
      });
      $("#hide_me").hide();
      $($("img")[0]).hide();
      $("#tabs").tabs("destroy");
      $("#tabs").tabs();
      $("#tabs").tabs("select", "tabs-2");
      return $($("img")[0]).load(function() {
        var r;
        r = $("img")[0].width / $("img")[0].height;
        $("img")[0].height = 400;
        $("img")[0].width = 400 * r;
        return $($("img")[0]).show();
      });
    };
    render_alg = function() {
      var result, z;
      result = alg_text(sort_rect());
      $("#progressbar").progressbar({
        "value": 25
      });
      return (z = $.post("/view_text", {
        "text": result
      }, function(data) {
        return rendering_ok(data);
      }));
    };
    $(document).bind('keydown', 'Return', function(evt) {
      return make_rect(evt);
    });
    $(document).bind('keydown', 'Ctrl+e', enter_text);
    z = 0;
    sort_rectb = function() {
      return alert([1, 2, 3, 4, 3]);
    };
    $("#progressbar").progressbar({
      "value": 0
    });
    $("#tabs").tabs();
    $("#new_entry").bind('click', make_rect);
    $("#del_entry").bind('click', del_entry);
    $("button").button();
    $("#pos_calc").bind('click', function() {
      return render_alg();
    });
    $(".selectable").selectable({
      "selected": chosen,
      "unselected": unselected
    });
    $(".draggable").draggable();
    $("#hide_graphic_edit").hide();
    a = $('.alert').css("color", "yellow");
    $('.alert').bind('click', function(event) {
      return alert("ORCA");
    });
    window.a = eval($("#hide_graphic_edit").text());
    if (window.a) {
      _.each(window.a, function(i) {
        return make_layout(i);
      });
      return (window.counter = 0);
    }
  }, this));
}).call(this);
