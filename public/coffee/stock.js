(function() {
  var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
  window.risk = 0.1;
  $(document).ready(__bind(function() {
    var data, initialize, show;
    data = function() {
      var p, r;
      p = 0;
      r = {};
      r["capital"] = $("#capital")[0].value;
      r["entry_price"] = $("#entry_price")[0].value;
      r["exit_price"] = $("#exit_price")[0].value;
      localStorage.setItem("capital", r["capital"]);
      localStorage.setItem("exit_price", r["exit_price"]);
      localStorage.setItem("entry_price", r["entry_price"]);
      p = $(".positions")[0].value;
      r["p"] = p;
      localStorage.setItem("p", p);
      return r;
    };
    window.data = data;
    show = function(r) {
      var capital, entry_price, exit_price, p, stocks_number, upper_exit;
      capital = parseFloat(r["capital"]);
      entry_price = parseFloat(r["entry_price"]);
      exit_price = parseFloat(r["exit_price"]);
      p = parseFloat(r["p"]);
      upper_exit = entry_price + (entry_price - exit_price);
      $("#exit").html("Upper Exit Price: " + (upper_exit));
      $("#lower_exit").html("Lower Exit Price: " + (exit_price));
      stocks_number = ((capital / p) * window.risk) / (entry_price - exit_price);
      $("#stocks_number").html("Stocks Number: " + (parseInt(stocks_number)));
      return $("#results").show();
    };
    initialize = function() {
      var capital, p;
      $("#submit").click(function() {
        show(data());
        return false;
      });
      capital = localStorage.getItem("capital");
      p = localStorage.getItem("p");
      $(".positions")[0].value = p;
      $("#entry_price")[0].value = localStorage.getItem("entry_price");
      $("#exit_price")[0].value = localStorage.getItem("exit_price");
      $("#capital")[0].value = capital;
      return $("#results").hide();
    };
    return initialize();
  }, this));
}).call(this);
