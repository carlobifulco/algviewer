(function() {
  function concat_object(obj) {
  str='';
  for(prop in obj)
  {
    str+=prop + " value :"+ obj[prop]+"\n";
  }
  return(str);
};  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  window.concat_object = concat_object;
  window.pos = {};
  window.counter = 0;
  window.error = false;
  $(document).ready(__bind(function() {
    var alg_text, boxes_to_yaml, chosen, cut, del_entry, enter_text, error, get_draggable_data, get_pos, get_selected, grid, make_draggable, make_layout, make_rect, make_text_position, move, new_box, offset, render_alg, render_inline, rendering_on_tab, resize_graph, save_alg, sort_rect, success, text_edit, text_multiply, unselected, x_start, y_start, z;
    grid = 25;
    x_start = grid * 2;
    y_start = (grid * 4) + $(".new_box").position().top;
    new_box = function(x, y, text, counter_id, positions_style) {
      var text_box;
      if (positions_style) {
        text_box = $("<div id='" + counter_id + "' class='ui-widget-content ui-corner selectable text_box' style='position: " + positions_style + "; left: " + x + "px; top: " + y + "px'>" + text + "</div>");
      } else {
        text_box = $("<div id='" + counter_id + "' class='ui-widget-content ui-corner selectable text_box' style='position:absolute'; left: " + x + "px; top: " + y + "px'>" + text + "</div>");
      }
      text_box.draggable({
        "grid": [grid, grid],
        "opacity": 0.35,
        "refreshPositions": "true",
        "containment": "document",
        "scroll": true,
        "zIndex": -1
      }).appendTo(".new_box");
      text_box.draggable({
        "stop": offset
      });
      return text_box;
    };
    make_layout = function(i) {
      var text, x, y;
      text = i[0];
      x = x_start + (i[1] * grid);
      y = y_start + (window.counter * grid);
      new_box(x, y, text, window.counter, "absolute");
      return window.counter += 1;
    };
    window.make_layout = make_layout;
    make_rect = function(evt) {
      var b, new_text, text, text_box;
      evt.stopPropagation();
      evt.preventDefault();
      b = $("#containment-wrapper");
      text = document.text_form.text_content.value;
      if (!text) {
        text = "new box; select me, enter the text in the empty box and press control-e to change me";
      }
      text_box = new_box(x_start, y_start - (grid * 2), text, window.counter, "absolute");
      new_text = document.text_form.text_content.value;
      text_box.css("background", "pink");
      $(".selectable").selectable({
        stop: function() {
          return get_selected();
        }
      });
      window.counter += 1;
      return window.text_box = text_box;
    };
    text_multiply = function(text, n) {
      var a, i;
      a = [];
      for (i = 0; (0 <= n ? i < n : i > n); (0 <= n ? i += 1 : i -= 1)) {
        a.push(text);
      }
      return a.join("");
    };
    window.text_multiply = text_multiply;
    enter_text = function() {
      var b;
      b = $(".ui-selected")[0];
      if (b) {
        b.innerText = document.text_form.text_content.value;
        return document.text_form.text_content.value = "";
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
    sort_rect = function() {
      var sorted_box, sorted_boxes, text_boxes, text_positions;
      text_boxes = $(".text_box");
      sorted_boxes = _.sortBy(text_boxes, get_pos);
      window.sorted_boxes = sorted_boxes;
      text_positions = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = sorted_boxes.length; _i < _len; _i++) {
          sorted_box = sorted_boxes[_i];
          _results.push(make_text_position(sorted_box));
        }
        return _results;
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
    offset = function(e, u) {
      var dragged, id, new_data, old_data, x, x_delta, y, y_delta;
      dragged = $(u.helper[0])[0];
      new_data = get_draggable_data(dragged);
      x = new_data.x;
      y = new_data.y;
      id = new_data.id;
      window.pos[_.size(window.pos)] = new_data;
      old_data = window.pos[_.size(window.pos) - 2];
      if (old_data) {
        old_data = _.detect(old_data, function(i) {
          return i.id === id;
        });
        if (old_data) {
          x_delta = new_data.x - old_data.x;
          y_delta = new_data.y - old_data.y;
          move(id, x_delta, y_delta);
        }
      }
      $(dragged).removeClass("ui-selected").css("color", "black");
      render_alg();
      window.u = dragged;
      return $(".text_box").css("background-color", "rgb(252, 187, 0)");
    };
    get_selected = function() {
      var data, i, s;
      s = _.sortBy($(".ui-selected"), get_pos);
      data = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = s.length; _i < _len; _i++) {
          i = s[_i];
          _results.push(get_draggable_data(i));
        }
        return _results;
      })();
      window.pos[_.size(window.pos)] = data;
      return s;
    };
    window.get_selected = get_selected;
    get_draggable_data = function(d) {
      var p, r;
      r = {};
      p = $(d).position();
      if (p) {
        r["x"] = p.left;
        r["y"] = p.top;
        r["text"] = $(d).text();
        r["id"] = $(d).attr("id");
        window.r = r;
        return r;
      }
    };
    window.get_draggable_data = get_draggable_data;
    make_draggable = function(id, text, x, y) {
      var text_box;
      text_box = $("<div id='" + id + "' class='ui-widget-content selectable text_box' style='position: absolute; left: " + x + "px; top: " + y + "px'>" + text + "</div>");
      text_box.draggable({
        "grid": [grid, grid],
        "opacity": 0.35,
        "refreshPositions": "true",
        "containment": "document",
        "scroll": true
      }).appendTo(".new_box");
      text_box.draggable({
        "stop": offset
      });
      return text_box;
    };
    window.make_draggable = make_draggable;
    cut = function(id) {
      var data, i, s, _i, _len;
      s = get_selected();
      s = _.reject(s, function(i) {
        return i.id === id;
      });
      data = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = s.length; _i < _len; _i++) {
          i = s[_i];
          _results.push(get_draggable_data(i));
        }
        return _results;
      })();
      for (_i = 0, _len = s.length; _i < _len; _i++) {
        i = s[_i];
        $(i).remove();
      }
      return data;
    };
    window.cut = cut;
    move = function(id, x_delta, y_delta) {
      var all, i, _i, _len;
      all = cut(id);
      for (_i = 0, _len = all.length; _i < _len; _i++) {
        i = all[_i];
        make_draggable(i.id, i.text, i.x + x_delta, i.y + y_delta);
      }
      return $(".text_box").css("background-color", "rgb(252, 187, 0)");
    };
    window.move = move;
    unselected = function() {
      return chosen();
    };
    get_pos = function(text_box) {
      return $(text_box).position().top;
    };
    window.get_pos = get_pos;
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
      window.z = data;
      anchor.html("<img src=" + data.png + " style='opacity:0.9;z-index:10000'></img>");
      $("#inline_graph").show();
      return resize_graph();
    };
    rendering_on_tab = function(data) {
      var alg_name;
      $("#results").html(data);
      $("#progressbar").progressbar({
        "value": 100
      });
      $("#progressbar").progressbar({
        "value": 5
      });
      $("#hide_me").hide();
      $($("img")[0]).hide();
      resize_graph();
      alg_name = _.last(window.location.pathname.split("/"));
      return $("#title").html(alg_name);
    };
    alg_text = function(text_positions) {
      var baseline, old_offset, t, text, text_position, _i, _len;
      window.text_positions = text_positions;
      text = "\n";
      baseline = text_positions[0][1];
      for (_i = 0, _len = text_positions.length; _i < _len; _i++) {
        text_position = text_positions[_i];
        offset = text_multiply("  ", (text_position[1] - baseline) / grid);
        if (offset > old_offset) {
          text += old_offset + "-" + "\n";
        }
        if (text_position[1] < baseline) {
          alert("Error! One of your boxes is too much on the left. Please reposition");
          return;
        }
        t = text_position[0].trim();
        text = text + offset + "- " + t + "\n";
        old_offset = offset;
      }
      return text;
    };
    boxes_to_yaml = function() {
      var result;
      result = alg_text(sort_rect());
      window.yaml = result;
      return result;
    };
    render_alg = function() {
      var alg_name, result, z;
      result = boxes_to_yaml();
      alg_name = _.last(window.location.pathname.split("/"));
      $("#progressbar").progressbar({
        "value": 25
      });
      z = $.post("/graphic_edit_view", {
        "text": result,
        "dataType": "json"
      }, function(data) {
        return render_inline(JSON.parse(data), success());
      });
      if (!window.error) {
        $.post("/upload_text", {
          "form_content": result,
          "form_name": alg_name,
          "type": "ajax"
        }, function(data) {
          return success();
        });
      }
      return window.error = false;
    };
    success = function() {
      return $("#progressbar").progressbar({
        "value": 100
      });
    };
    save_alg = function() {
      var alg_name, yaml;
      yaml = boxes_to_yaml();
      alg_name = _.last(window.location.pathname.split("/"));
      window.alg_name = alg_name;
      window.yaml = yaml;
      return $.post("/upload_text", {
        "form_content": yaml,
        "form_name": alg_name,
        "type": "ajax"
      }, function(data) {
        return success();
      });
    };
    window.save_alg = save_alg;
    text_edit = function() {
      var alg_name;
      alg_name = _.last(window.location.pathname.split("/"));
      window.location.href = "/edit_text/" + alg_name;
      return $(document).ready(__bind(function() {
        return $("#accordion").accordion("activate", 2);
      }, this));
    };
    window.alg_text = alg_text;
    window.sort_rect = sort_rect;
    $(document).bind('keydown', 'Return', function(evt) {
      return make_rect(evt);
    });
    $(document).bind('keydown', 'Ctrl+e', enter_text);
    z = 0;
    $("#progressbar").progressbar({
      "value": 0
    });
    $("#tabs").tabs();
    $("#home").bind('click', function() {
      return window.location.pathname = "/";
    });
    $("#new_entry").bind('click', make_rect);
    $("#del_entry").bind('click', del_entry);
    $("#text_edit").bind('click', text_edit);
    $("button").button();
    $(".selectable").selectable({
      "selected": chosen,
      "unselected": unselected
    });
    $(".draggable").draggable();
    $("#hide_graphic_edit").hide();
    window.a = eval($("#hide_graphic_edit").text());
    if (window.a) {
      _.each(window.a, function(i) {
        return make_layout(i);
      });
    }
    render_alg();
    $(".selectable").selectable({
      stop: function() {
        return get_selected();
      }
    });
    error = function() {
      return alert("ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!");
    };
    window.error = true;
    return $('#error_log').ajaxError(function() {
      return error();
    });
  }, this));
}).call(this);
