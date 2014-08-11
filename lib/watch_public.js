(function() {
  var config, dead_hash, exec, finder, fs, has_key, knox, path, s3, sys, u_, upload, util, watch_public;
  var __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  };
  fs = require('fs');
  sys = require("sys");
  exec = require('child_process').exec;
  util = require('util');
  knox = require("knox");
  finder = require("findit");
  u_ = require("underscore");
  path = require("path");
  dead_hash = {};
  config = JSON.parse(fs.readFileSync("aws_key.json", "utf8"));
  config.bucket = "alg_images";
  s3 = knox.createClient(config);
  path = "./public";
  has_key = function(h, k) {
    return __indexOf.call(u_.keys(h), k) >= 0;
  };
  watch_public = function() {
    return fs.watchFile(path, function(cur, pre) {
      console.log("Changes");
      return finder.find(path, function(filename) {
        if (!has_key(dead_hash, filename)) {
          return upload(filename);
        }
      });
    });
  };
  upload = function(filename) {
    dead_hash[filename] = true;
    if ((filename.indexOf(" ")) === -1 && fs.lstatSync(filename).isFile()) {
      return fs.readFile(filename, function(err, buf) {
        var b, o, req;
        if (err) {
          delete dead_hash[filename];
          return;
        }
        b = buf.length;
        if ((!err) && buf) {
          o = {
            "Content-Length": b
          };
          req = s3.put(filename, o);
          req.on("response", function(res) {
            if (res.statusCode === 200) {
              console.log("saved " + req.url);
              delete dead_hash[filename];
              if (fs.lstatSync(filename).isFile()) {
                fs.unlinkSync(filename);
              }
              return exec("rmdir -p " + (path.dirname(filename)), function(e, i, o) {
                return console.log(e);
              });
            } else {
              console.log("ERRORRRRRR");
              console.log(res);
              return delete dead_hash[filename];
            }
          });
          return req.end(buf);
        }
      });
    } else {

    }
  };
  watch_public();
}).call(this);
