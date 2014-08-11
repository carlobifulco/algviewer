(function() {
  var PATH, config, dead_hash, debug, dir_remove, exec, finder, fs, has_key, knox, nest, nest_destroy, nested_dirs, path, r, repl, run, s3, sys, u_, upload, util, watch_public;
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
  repl = require("repl");
  run = function(command) {
    return exec("" + command, function(stdin, stdout, err) {
      if (err) {
        console.log("" + command + " err: " + err);
        return;
      }
      return console.log("" + command + " stdout: " + stdout);
    });
  };
  config = JSON.parse(fs.readFileSync("aws_key.json", "utf8"));
  config.bucket = "alg_images";
  s3 = knox.createClient(config);
  PATH = "./public";
  has_key = function(h, k) {
    return __indexOf.call(u_.keys(h), k) >= 0;
  };
  nested_dirs = ["1", "2", "3", "4", "5"];
  nest = function() {
    var dirname, i, nests, _i, _len, _results;
    nests = ["."];
    _results = [];
    for (_i = 0, _len = nested_dirs.length; _i < _len; _i++) {
      i = nested_dirs[_i];
      nests.push(i);
      console.log("my pushed array " + i);
      dirname = nests.reduce(function(a, b) {
        return path.join(a, b);
      });
      console.log("./" + dirname);
      _results.push(fs.mkdir("./" + dirname, 0777));
    }
    return _results;
  };
  nest_destroy = function() {
    var dirname, i, nests, _i, _len, _results;
    nests = ["."];
    _results = [];
    for (_i = 0, _len = nested_dirs.length; _i < _len; _i++) {
      i = nested_dirs[_i];
      nests.push(i);
      dirname = nests.reduce(function(a, b) {
        return path.join(a, b);
      });
      _results.push(run("rm -R " + dirname));
    }
    return _results;
  };
  dir_remove = function(filename) {
    var dirname;
    dirname = fs.realpathSync(path.dirname(filename));
    if (dirname === fs.realpathSync(PATH)) {
      return;
    }
    fs.readdir(dirname, function(e, d) {
      console.log(d);
      if (d.length === 0) {
        return fs.rmdirSync(dirname);
      }
    });
    return dir_remove(path.join(dirname, ".."));
  };
  watch_public = function() {
    return fs.watchFile(PATH, function(cur, pre) {
      console.log("Changes");
      console.log(dead_hash);
      return finder.find(PATH, function(filename) {
        if ((!has_key(dead_hash, filename)) && fs.lstatSync(filename).isFile()) {
          upload(filename);
        }
        if (fs.readdirSync(path.dirname(filename)).length === 0) {
          return fs.rmdirSync(path.dirname(filename));
        } else {
          return console.log("" + filename + ", " + (fs.readdirSync(pathname.dirname(filename)).length) + ",  " + (fs.readdirSync(pathname.dirname(filename))));
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
              return dir_remove(filename);
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
  debug = function(obj, seen) {
    var item, printProps, source;
    printProps = function(obj) {
      var prop;
      return ((function() {
        var _results;
        _results = [];
        for (prop in obj) {
          _results.push((!/^\d+$/.test(prop) ? prop + ": " + debug(obj[prop], seen) : ''));
        }
        return _results;
      })()).join(', ');
    };
    seen = seen || [];
    if (__indexOf.call(seen, obj) >= 0) {
      return '[Circular]';
    }
    seen.push(obj);
    switch (typeof obj) {
      case 'boolean':
        return obj.toString();
      case 'number':
        return obj.toString();
      case 'string':
        return obj.toString();
      case 'undefined':
        return 'undefined';
      case 'function':
        source = obj.toString();
        return source.slice(0, source.indexOf('{')) + ' {...}';
      default:
        if (Object.prototype.toString.call(obj) === Object.prototype.toString.call([])) {
          return '[' + (((function() {
            var _i, _len, _results;
            _results = [];
            for (_i = 0, _len = obj.length; _i < _len; _i++) {
              item = obj[_i];
              _results.push(debug(item, seen));
            }
            return _results;
          })()).join(', ')) + ']' + printProps(obj);
        } else {
          return (obj || 'null').toString() + printProps(obj);
        }
    }
  };
  module.exports = {
    watch_public: watch_public,
    upload: upload,
    nest: nest
  };
  if (require.main === module) {
    r = repl.start();
    r.context.nest = nest;
    r.context.nest_destroy = nest_destroy;
    r.context.debug = debug;
  }
}).call(this);
