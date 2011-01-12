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
  window.image_is_large = false;
  $(document).ready(__bind(function() {
    var alg_name, alg_text, alg_text_edit, alg_view, boxes_text, boxes_to_yaml, choose_color, chosen, colors_to_hex, cut, del_entry, edit_text, enter, expand_graph, get_alg_name, get_boxes, get_draggable_data, get_nodes_colors, get_pos, get_selected, grid, initial_layout, make_draggable, make_layout, make_rect, make_text_position, move, new_box, offset, render_alg, render_inline, resize_graph, rgb2hex, save, save_alg, set_boxes_colors, sort_rect, sorted_colors, store_boxes_colors, success, text_multiply, unique_colors, unselected, x_start, y_start, z;
    grid = 48;
    x_start = grid * 2;
    y_start = (grid * 4) + $(".new_box").position().top;
    $.ajaxSetup({
      cache: false
    });
    rgb2hex = function(rgb) {
      rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
      return "#" + ("0" + parseInt(rgb[1], 10).toString(16)).slice(-2) + ("0" + parseInt(rgb[2], 10).toString(16)).slice(-2) + ("0" + parseInt(rgb[3], 10).toString(16)).slice(-2);
    };
    window.rgb2hex = rgb2hex;
    new_box = function(x, y, text, counter_id) {
      var text_box;
      text_box = $("<div id='" + counter_id + "' class='ui-widget-content ui-corner text_box' style='position: absolute; left: " + x + "px; top: " + y + "px'>" + text + "</div>");
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
    make_rect = function(evt) {
      var b, new_text, text;
      evt.stopPropagation();
      evt.preventDefault();
      b = $("#containment-wrapper");
      text = String(document.text_form.text_content.value);
      document.text_form.text_content.value = "";
      if (!text) {
        text = "New box; enter new text in the entry form, select me and press Edit Box to change me";
      }
      new_box(x_start, y_start - grid * 2, text, window.counter);
      new_text = document.text_form.text_content.value;
      $("#text_entry").focus();
      return window.counter += 1;
    };
    edit_text = function() {
      var b;
      b = get_selected();
      if (b.length === 1) {
        $(b[0]).text($("#text_entry").val());
        $("#text_entry").val("");
      } else {
        $("#text_entry").val("");
      }
      return $("#text_entry").focus();
    };
    alg_text = function(text_positions) {
      var baseline, indent_level, offset, old_offset, text, text_position, text_to_be_added, _i, _len;
      text = "\n";
      baseline = text_positions[0][1];
      for (_i = 0, _len = text_positions.length; _i < _len; _i++) {
        text_position = text_positions[_i];
        indent_level = Math.round((text_position[1] - baseline) / grid);
        offset = text_multiply("  ", indent_level);
        if (offset > old_offset) {
          text += old_offset + "-" + "\n";
        }
        if (text_position[1] === baseline) {
          text += "\n";
        }
        text_to_be_added = text_position[0].trim();
        text += offset + "- " + text_to_be_added + "\n";
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
    boxes_to_yaml = function() {
      var result;
      result = alg_text(sort_rect());
      window.yaml = result;
      return result;
    };
    window.boxes_to_yaml = boxes_to_yaml;
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
      return window.u = dragged;
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
      if (s.length === 1) {
        if ($("#text_entry").val() === "") {
          $("#text_entry").val($.trim($(s).text()));
          $("#text_entry").focus();
        } else {
          $("#text_entry").focus();
        }
      }
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
      return set_boxes_colors();
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
        image.width(350);
        image.height("");
      } else {
        image.height(350);
        image.width("");
      }
      window.image_h = image.height();
      window.image_w = image.width();
      return window.image_top = image.css("top");
    };
    window.resize_graph = resize_graph;
    render_inline = function(data) {
      var anchor, image;
      anchor = $("#inline_graph");
      window.z = data;
      anchor.html("<img class=inline_graph id=graph_preview src=" + data.png + "></img>");
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
        im.css("opacity", "1");
        h = $(window).height() - 100;
        w = $(window).width() - 50;
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
        return im.effect("slide", function() {
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
    render_alg = function() {
      var colors, yaml_structure, z;
      $("#progressbar").progressbar({
        "value": 25
      });
      yaml_structure = boxes_to_yaml();
      colors = colors_to_hex(unique_colors());
      z = $.post("/graphic_edit_view", {
        "text": yaml_structure,
        "hex": colors,
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
      return window.yaml = yaml;
    };
    window.save_alg = save_alg;
    window.alg_text = alg_text;
    window.sort_rect = sort_rect;
    $("#progressbar").progressbar({
      "value": 0
    });
    $("#tabs").tabs();
    get_alg_name = function() {
      var alg_name;
      return alg_name = _.last(window.location.pathname.split("/"));
    };
    alg_text_edit = function() {
      return window.location.href = "/edit_text/" + (get_alg_name());
    };
    alg_view = function() {
      return window.location.href = "/view/" + (get_alg_name());
    };
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
        return window.is_ctrl = false;
      }
    });
    $("#text_entry").keydown(function(e) {
      return enter(e);
    });
    $("#home").bind('click', function() {
      return window.location.pathname = "/";
    });
    $("#new_entry").bind('click', make_rect);
    $("#del_entry").bind('click', del_entry);
    $("#text_edit").bind('click', alg_text_edit);
    $("#edit_entry").bind('click', edit_text);
    $("#view").bind('click', alg_view);
    $("button").button();
    $(".selectable").selectable({
      "selected": chosen
    });
    $(".draggable").draggable();
    $(".selectable").selectable({
      stop: get_selected
    });
    $('#error_log').ajaxError(__bind(function() {
      return alert("ERROR IN YOUR GRAPH STRUCTURE. PLEASE FIX YOUR BOXES POSITION!!!");
    }, this));
    get_boxes = function() {
      var sorted_boxes, text_boxes;
      text_boxes = $(".text_box");
      return sorted_boxes = _.sortBy(text_boxes, get_pos);
    };
    window.get_boxes = get_boxes;
    boxes_text = function() {
      var i, _i, _len, _ref, _results;
      _ref = get_boxes();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        _results.push($(i).text().trim());
      }
      return _results;
    };
    window.boxes_text = boxes_text;
    get_nodes_colors = function() {
      var nodes_colors, selected;
      selected = [];
      return nodes_colors = _.zip(boxes_text(), sorted_colors());
    };
    window.get_nodes_colors = get_nodes_colors;
    sorted_colors = function() {
      var colors, i, sorted_boxes;
      sorted_boxes = get_boxes();
      return colors = (function() {
        var _i, _len, _ref, _results;
        _ref = get_boxes();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          i = _ref[_i];
          _results.push($(i).css("background-color"));
        }
        return _results;
      })();
    };
    window.sorted_colors = sorted_colors;
    store_boxes_colors = function() {
      var bc, color_key, colors, i, sorted_boxes;
      bc = {};
      sorted_boxes = get_boxes();
      if (sorted_boxes) {
        colors = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = sorted_boxes.length; _i < _len; _i++) {
            i = sorted_boxes[_i];
            _results.push($(i).css("background-color"));
          }
          return _results;
        })();
        color_key = "" + (get_alg_name()) + "_colors";
        return localStorage.setItem(color_key, JSON.stringify(colors));
      }
    };
    window.store_boxes_colors = store_boxes_colors;
    choose_color = function(color) {
      $(get_selected()).css("background", color);
      return store_boxes_colors();
    };
    set_boxes_colors = function() {
      var boxes, color_key, colors_list, pos_col, position_colors, _i, _j, _len, _ref, _results, _results2;
      color_key = "" + (get_alg_name()) + "_colors";
      colors_list = JSON.parse(localStorage.getItem(color_key));
      boxes = get_boxes();
      if (colors_list) {
        position_colors = _.zip((function() {
          _results = [];
          for (var _i = 0, _ref = colors_list.length; 0 <= _ref ? _i < _ref : _i > _ref; 0 <= _ref ? _i += 1 : _i -= 1){ _results.push(_i); }
          return _results;
        }).call(this), colors_list);
        window.position_colors = position_colors;
        _results2 = [];
        for (_j = 0, _len = position_colors.length; _j < _len; _j++) {
          pos_col = position_colors[_j];
          _results2.push($(boxes[pos_col[0]]).css("background-color", pos_col[1]));
        }
        return _results2;
      }
    };
    window.set_boxes_colors = set_boxes_colors;
    unique_colors = function() {
      var all_boxes, all_colors, i, unique_boxes, unique_pos, _i, _len, _results;
      all_colors = sorted_colors();
      all_boxes = boxes_text();
      unique_boxes = _.uniq(boxes_text());
      unique_pos = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = unique_boxes.length; _i < _len; _i++) {
          i = unique_boxes[_i];
          _results.push(all_boxes.indexOf(i));
        }
        return _results;
      })();
      _results = [];
      for (_i = 0, _len = unique_pos.length; _i < _len; _i++) {
        i = unique_pos[_i];
        _results.push(all_colors[i]);
      }
      return _results;
    };
    window.unique_colors = unique_colors;
    colors_to_hex = function(colors_array) {
      var i;
      return JSON.stringify((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = colors_array.length; _i < _len; _i++) {
          i = colors_array[_i];
          _results.push(rgb2hex(i));
        }
        return _results;
      })());
    };
    window.colors_to_hex = colors_to_hex;
    initial_layout = function(text_indent) {
      var boxes_struct;
      boxes_struct = JSON.parse(JSON.parse(text_indent));
      window.boxes_struct = boxes_struct;
      if (boxes_struct) {
        _.each(boxes_struct, function(i) {
          return make_layout(i);
        });
      }
      set_boxes_colors();
      render_alg();
      $.farbtastic("#colorpicker").setColor("#f896c2");
      return window.counter = 0;
    };
    $(".hide").hide();
    alg_name = _.last(window.location.pathname.split("/"));
    z = $.get("/ajax_text_indent/" + alg_name, function(text_indent) {
      return initial_layout(text_indent);
    });
    $("#colorpicker").farbtastic(choose_color);
    return $("#colorpicker").draggable();
  }, this));
}).call(this);
