(function() {
  var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
  function concat_object(obj) {
  str='';
  for(prop in obj)
  {
    str+=prop + " value :"+ obj[prop]+"\n";
  }
  return(str);
};
  window.concat_object = concat_object;
  window.pos = {};
  window.counter = 0;
  window.image_is_large = false;
  $(document).ready(__bind(function() {
    var alg_name, alg_text, alg_text_edit, alg_view, boxes_to_yaml, chosen, cut, del_entry, edit_text, enter, expand_graph, get_draggable_data, get_pos, get_selected, grid, initial_layout, make_draggable, make_layout, make_rect, make_text_position, move, new_box, offset, render_alg, render_inline, resize_graph, save, save_alg, sort_rect, success, text_multiply, unselected, x_start, y_start, z;
    grid = 25;
    x_start = grid * 2;
    y_start = (grid * 4) + $(".new_box").position().top;
    new_box = function(x, y, text, counter_id) {
      var text_box;
      text_box = $("<div id='" + (counter_id) + "' class='ui-widget-content ui-corner selectable text_box' style='position: absolute; left: " + (x) + "px; top: " + (y) + "px'>" + (text) + "</div>");
      text_box.draggable({
        "grid": [grid, grid],
        "opacity": 0.35,
        "refreshPositions": "true",
        "scroll": true
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
      new_box(x, y, text, window.counter);
      return window.counter += 1;
    };
    window.make_layout = make_layout;
    alg_text = function(text_positions) {
      var _i, _len, _ref, baseline, indent_level, offset, old_offset, text, text_position;
      text = "\n";
      baseline = text_positions[0][1];
      _ref = text_positions;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        text_position = _ref[_i];
        indent_level = Math.round((text_position[1] - baseline) / grid);
        offset = text_multiply("  ", indent_level);
        if (offset > old_offset) {
          text += old_offset + "-" + "\n";
        }
        if (text_position[1] === baseline) {
          text += "\n";
        }
        text += (offset + "- " + text_position[0].trim() + "\n");
        old_offset = offset;
      }
      return text;
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
    make_rect = function(evt) {
      var b, new_text, text;
      evt.stopPropagation();
      evt.preventDefault();
      b = $("#containment-wrapper");
      text = String(document.text_form.text_content.value);
      document.text_form.text_content.value = "";
      if (!(text)) {
        text = "new box; select me, enter the text in the empty box and press control-e to change me";
      }
      new_box(x_start, y_start - grid * 2, text, window.counter);
      new_text = document.text_form.text_content.value;
      $(".selectable").selectable({
        stop: function() {
          return get_selected();
        }
      });
      $("#text_entry").focus();
      return window.counter += 1;
    };
    edit_text = function() {
      var b;
      b = $(".ui-selected")[0];
      if (b !== "") {
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
      var yaml_structure;
      $(".ui-selected").remove();
      yaml_structure = boxes_to_yaml();
      return render_alg();
    };
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
      return (window.u = dragged);
    };
    get_selected = function() {
      var _i, _len, _ref, _result, data, i, s;
      s = _.sortBy($(".ui-selected"), get_pos);
      data = (function() {
        _result = []; _ref = s;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          i = _ref[_i];
          _result.push(get_draggable_data(i));
        }
        return _result;
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
      text_box = $("<div id='" + (id) + "' class='ui-widget-content selectable text_box' style='position: absolute; left: " + (x) + "px; top: " + (y) + "px'>" + (text) + "</div>");
      text_box.draggable({
        "grid": [grid, grid],
        "opacity": 0.35,
        "refreshPositions": "true",
        "scroll": true
      }).appendTo(".new_box");
      text_box.draggable({
        "stop": offset
      });
      return text_box;
    };
    window.make_draggable = make_draggable;
    cut = function(id) {
      var _i, _len, _ref, _result, data, i, s;
      s = get_selected();
      s = _.reject(s, function(i) {
        return i.id === id;
      });
      data = (function() {
        _result = []; _ref = s;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          i = _ref[_i];
          _result.push(get_draggable_data(i));
        }
        return _result;
      })();
      (function() {
        _result = []; _ref = s;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          i = _ref[_i];
          _result.push($(i).remove());
        }
        return _result;
      })();
      return data;
    };
    window.cut = cut;
    move = function(id, x_delta, y_delta) {
      var _i, _len, _ref, _result, all, i;
      all = cut(id);
      _result = []; _ref = all;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        _result.push(make_draggable(i.id, i.text, i.x + x_delta, i.y + y_delta));
      }
      return _result;
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
      var h, image, w, w_height, w_width;
      image = $('#graph_preview');
      window.image = image;
      w_height = $(window).height();
      w_width = $(window).width();
      w = image.width();
      h = image.height();
      if (w > h) {
        image.width((w_width / 2) - 50);
        image.height("");
      } else {
        image.height(w_height - 150);
        image.width("");
      }
      window.image_h = image.height();
      window.image_w = image.width();
      return (window.image_top = image.css("top"));
    };
    window.resize_graph = resize_graph;
    render_inline = function(data) {
      var anchor, image;
      anchor = $("#inline_graph");
      window.z = data;
      anchor.html("<img class=inline_graph id=graph_preview src=" + (data.png) + "></img>");
      image = $("#graph_preview");
      image.hide();
      image.click(function() {
        return expand_graph();
      });
      return image.load(function() {
        resize_graph();
        return image.show();
      });
    };
    expand_graph = function() {
      var h, im, w;
      im = $('#graph_preview');
      if (!window.image_is_large) {
        im.addClass("image_full");
        h = ($(window).height() - 100);
        w = ($(window).width() - 50);
        if (window.image_h > window.image_w) {
          im.height(h);
          im.width("");
          im.css("top", 5);
        }
        if (window.image_w >= window.image_h) {
          im.width(w);
          im.height("");
          im.css("top", 100);
        }
        window.image_is_large = true;
        return im.effect("bounce", function() {
          return im.show();
        });
      } else {
        im.removeClass("image_full");
        im.css("height", window.image_h);
        im.css("width", window.image_w);
        im.css("top", window.image_top);
        window.image_is_large = false;
        return $("#text_entry").focus();
      }
    };
    boxes_to_yaml = function() {
      var result;
      result = alg_text(sort_rect());
      window.yaml = result;
      return result;
    };
    window.boxes_to_yaml = boxes_to_yaml;
    render_alg = function() {
      var yaml_structure, z;
      $("#progressbar").progressbar({
        "value": 25
      });
      yaml_structure = boxes_to_yaml();
      z = $.post("/graphic_edit_view", {
        "text": yaml_structure,
        "dataType": "json"
      }, function(data) {
        return render_inline(JSON.parse(data));
      });
      save(yaml_structure);
      return $("#text_entry").focus();
    };
    save = function(yaml_structure) {
      var alg_name;
      alg_name = _.last(window.location.pathname.split("/"));
      return $.post("/upload_text", {
        "form_content": yaml_structure,
        "form_name": alg_name,
        "type": "ajax"
      }, function(data) {
        return success();
      });
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
      return (window.yaml = yaml);
    };
    window.save_alg = save_alg;
    window.alg_text = alg_text;
    window.sort_rect = sort_rect;
    enter = function(e) {
      var selected;
      e.stopPropagation();
      selected = $(".ui-selected")[0];
      if (e.keyCode === 13) {
        if (!selected) {
          return make_rect(e);
        } else {
          e.preventDefault();
          selected.innerText = document.text_form.text_content.value;
          document.text_form.text_content.value = "";
          return render_alg();
        }
      }
    };
    $(document).keyup(function(e) {
      if (e.keyCode === 17) {
        return (window.is_ctrl = false);
      }
    });
    $("#text_entry").keydown(function(e) {
      return enter(e);
    });
    $("#progressbar").progressbar({
      "value": 0
    });
    $("#tabs").tabs();
    alg_text_edit = function() {
      var alg_name;
      alg_name = _.last(window.location.pathname.split("/"));
      return (window.location.href = ("/edit_text/" + (alg_name)));
    };
    alg_view = function() {
      var alg_name;
      alg_name = _.last(window.location.pathname.split("/"));
      return (window.location.href = ("/view/" + (alg_name)));
    };
    $("#home").bind('click', function() {
      return (window.location.pathname = "/");
    });
    $("#new_entry").bind('click', make_rect);
    $("#del_entry").bind('click', del_entry);
    $("#text_edit").bind('click', alg_text_edit);
    $("#edit_entry").bind('click', edit_text);
    $("#view").bind('click', alg_view);
    $("button").button();
    $(".selectable").selectable({
      "selected": chosen,
      "unselected": unselected
    });
    $(".draggable").draggable();
    initial_layout = function(text_indent) {
      var boxes_struct;
      boxes_struct = JSON.parse(JSON.parse(text_indent));
      window.boxes_struct = boxes_struct;
      if (boxes_struct) {
        _.each(boxes_struct, function(i) {
          return make_layout(i);
        });
      }
      render_alg();
      return (window.counter = 0);
    };
    $.ajaxSetup({
      cache: false
    });
    $(".hide").hide();
    alg_name = _.last(window.location.pathname.split("/"));
    z = $.get("/ajax_text_indent/" + (alg_name), function(text_indent) {
      return initial_layout(text_indent);
    });
    $(".selectable").selectable({
      stop: function() {
        return get_selected();
      }
    });
    return $('#error_log').ajaxError(__bind(function() {
      return alert("ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!");
    }, this));
  }, this));
}).call(this);
