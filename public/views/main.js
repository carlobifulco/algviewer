(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $(document).ready(__bind(function() {
    var check_auth, check_autocomplete, check_entry, check_local_storage, check_user_dialog, confirm_link, delete_dialog, insert_template, logout, no_entry_open_accordion, template_alg_names, who_are_you;
    who_are_you = function() {
      var params, pw, r, user;
      if (!localStorage.getItem("user")) {
        return check_user_dialog();
      } else {
        user = localStorage.user;
        pw = localStorage.password;
        params = {
          'user': "" + user,
          'password': "" + pw
        };
        return r = $.post('/check_user', params, check_local_storage, "json");
      }
    };
    check_user_dialog = function() {
      $("#dialog-form").dialog({
        "autoOpen": false,
        "height": 300,
        "width": 350,
        "modal": true
      });
      $("#create-user").button();
      $("#dialog-form").dialog("open");
      $("#dialog-form").dialog({
        "closeOnEscape": false,
        close: function() {
          return $("#dialog-form").dialog("open");
        }
      });
      return $("#create-user").click(function(e) {
        check_auth();
        return false;
      });
    };
    check_local_storage = function(r) {
      if (r === "OK") {
        return $("#dialog-form").hide();
      } else {
        return check_user_dialog();
      }
    };
    check_auth = function() {
      var params, pw, r, update, user;
      update = function(r) {
        var pw, user;
        user = $("#user")[0].value;
        pw = $("#password")[0].value;
        if (r === "OK") {
          localStorage.user = user;
          localStorage.password = pw;
          window.location.url = "/";
          return $("#dialog-form").dialog("destroy");
        } else {
          alert("Incorrect User or Password");
          window.location.url = "/";
          return false;
        }
      };
      user = $("#user")[0].value;
      pw = $("#password")[0].value;
      params = {
        'user': "" + user,
        'password': "" + pw
      };
      r = $.post('/check_user', params, update, "json");
      return window.r = r;
    };
    logout = function() {
      localStorage.user = false;
      localStorage.password = false;
      return window.location.reload();
    };
    $("#view_view").click(function() {
      return $("#hide_view").toggle();
    });
    $("#hide_edit").hide();
    $("#view_edit").click(function() {
      return $("#hide_edit").toggle();
    });
    $("#hide_delete").hide();
    $("#view_delete").click(function() {
      return $("#hide_delete").toggle();
    });
    $("#hide_graphic_edit").hide();
    $("#view_graphic_edit").click(function() {
      return $("#hide_graphic_edit").toggle();
    });
    $("#accordion").accordion();
    _.each($(".small_acc"), function(e) {
      return e.style.height = "40px";
    });
    _.each($(".int_acc"), function(e) {
      return e.style.height = "80px";
    });
    check_entry = function(r) {
      var s, v;
      s = "#entry" + r;
      v = $(s)[0].value;
      if (v === "") {
        alert("no entry");
        return false;
      } else {
        return true;
      }
    };
    window.check_entry = check_entry;
    check_autocomplete = function(r) {
      var s, v;
      s = "#autocomplete";
      v = $(s)[0].value;
      if (v === "") {
        alert("No entry; please enter a new name or select or select an existing graph");
        return false;
      } else {
        return v;
      }
    };
    window.check_entry = check_entry;
    no_entry_open_accordion = function(n) {
      var entry;
      entry = $("#autocomplete")[0].value;
      if (!entry) {
        $("#accordion").accordion("activate", n);
        return false;
      } else {
        return entry;
      }
    };
    delete_dialog = function(url, filename) {
      $("#delete").dialog({
        buttons: [
          {
            text: "Confirm Delete " + filename,
            "click": function() {
              return window.location.href = url;
            }
          }, {
            text: "Cancel",
            "click": function() {
              return $("#delete").dialog("close");
            }
          }
        ]
      });
      return $("#delete").dialog("open");
    };
    confirm_link = __bind(function(e) {
      var target_url;
      window.e = e;
      e.preventDefault();
      target_url = e.srcElement.href;
      $("#delete").dialog({
        buttons: [
          {
            text: "Confirm",
            "click": function() {
              return window.location.href = target_url;
            }
          }, {
            text: "Cancel",
            "click": function() {
              return $("#delete").dialog("close");
            }
          }
        ]
      });
      return $("#delete").dialog("open");
    }, this);
    $("#text_edit_button").click(function(e) {
      if (check_entry(1)) {
        return window.location.href = "/edit_text/" + ($("#entry1")[0].value);
      }
    });
    $("#graph_edit_button").click(function(e) {
      if (check_entry(2)) {
        return window.location.href = "/graphic_edit/" + ($("#entry2")[0].value);
      }
    });
    $("#text_edit_button2").click(function(e) {
      var entry;
      entry = no_entry_open_accordion(2);
      if (entry) {
        return window.location.href = "/edit_text/" + entry;
      }
    });
    $("#graph_edit_button2").click(function(e) {
      var entry;
      entry = no_entry_open_accordion(3);
      if (entry) {
        return window.location.href = "/graphic_edit/" + entry;
      }
    });
    $("#delete_button2").click(function(e) {
      var entry;
      entry = no_entry_open_accordion(4);
      if (entry) {
        return delete_dialog("/delete/" + entry, entry);
      }
    });
    $("#view_button_2").click(function(e) {
      var entry;
      entry = no_entry_open_accordion(1);
      if (entry) {
        return window.location.href = "/view/" + entry;
      }
    });
    $("#logout").click(logout);
    $("#button").button();
    $("#button2").button();
    $(".button").button();
    $("#all_algs_names").hide();
    window.alg_names = eval($("#all_algs_names").text());
    $("#autocomplete").autocomplete({
      "source": window.alg_names
    });
    who_are_you();
    template_alg_names = function(graph_names_list) {
      var markdown_list;
      markdown_list = [];
      _.each(graph_names_list, function(graph_name) {
        return markdown_list.push({
          "graph_name": graph_name
        });
      });
      return markdown_list;
    };
    insert_template = function(template) {
      $("#text_edit").append($("#edit_text_template").tmpl(template));
      $("#view").append($("#view_template").tmpl(template));
      $("#graphic_edit").append($("#graphic_edit_template").tmpl(template));
      return $("#delete").append($("#delete_template").tmpl(template));
    };
    $.get("/alg_names/" + localStorage.user, function(r) {
      return insert_template(template_alg_names(JSON.parse(r)));
    });
    window.template_alg_names = template_alg_names;
    window.insert_template = insert_template;
    return $(".confirmLink").bind("click", __bind(function(e) {
      return confirm_link(e);
    }, this));
  }, this));
}).call(this);
