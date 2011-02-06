(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  $(document).ready(__bind(function() {
    var GraphUrls, alg_name, colors, g, user_name;
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
    user_name = localStorage.user;
    $("#title").html(alg_name);
    $($("img")[0]).hide();
    _.each($(".small_acc"), function(e) {
      return e.style.height = "40px";
    });
    colors = JSON.parse(localStorage.getItem(alg_name));
    GraphUrls = (function() {
      function GraphUrls(graph_name) {
        this.update_urls = __bind(this.update_urls, this);;
        this.show = __bind(this.show, this);;
        this.get_graph = __bind(this.get_graph, this);;
        this.graph = __bind(this.graph, this);;
        this.yaml = __bind(this.yaml, this);;
        this.colors = __bind(this.colors, this);;        this.user_name = localStorage.user;
        this.graph_name = graph_name;
      }
      GraphUrls.prototype.colors = function() {
        var dfd;
        dfd = $.Deferred();
        this.colors_url = "/nodes_colors/" + this.graph_name;
        $.get(this.colors_url, {
          "user_name": this.user_name,
          type: "ajax"
        }, __bind(function(e) {
          this.color_hash = e;
          return dfd.resolve();
        }, this));
        return dfd.promise();
      };
      GraphUrls.prototype.yaml = function() {
        var dfd, graph_name;
        dfd = $.Deferred();
        graph_name = "/yaml/" + this.graph_name;
        $.get(graph_name, {
          "user_name": this.user_name,
          type: "ajax"
        }, __bind(function(e) {
          this.yaml_text = JSON.stringify(e);
          return dfd.resolve();
        }, this));
        return dfd.promise();
      };
      GraphUrls.prototype.graph = function() {
        return $.get("/graph", {
          "colors_hash": this.color_hash,
          "yaml_text": this.yaml_text,
          type: "ajax"
        }, __bind(function(e) {
          this.urls = JSON.parse(e);
          return this.update_urls(this.urls);
        }, this));
      };
      GraphUrls.prototype.get_graph = function() {
        return $.when(this.yaml(), this.colors()).done(this.graph);
      };
      GraphUrls.prototype.show = function(urls) {
        return alert(urls.pdf);
      };
      GraphUrls.prototype.update_urls = function(urls) {
        $(".pdf").attr("href", "http://" + urls.pdf);
        $(".png").attr("href", "http://" + urls.png);
        $(".dot").attr("href", "http://" + urls.dot);
        $(".svg").attr("href", "http://" + urls.svg);
        return $("src").attr("src", "http://" + urls.png);
      };
      return GraphUrls;
    })();
    window.GraphUrls = GraphUrls;
    g = new GraphUrls(alg_name);
    return g.get_graph();
  }, this));
}).call(this);
