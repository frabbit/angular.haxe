(function () { "use strict";
var HxOverrides = function() { };
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var News = function(c) {
	var base = "http://" + c.host + c.imagePath;
	this.entries = [{ text : "Wonderful new car invented", img : base + "car.jpg"},{ text : "Evolution finally happened", img : base + "evolution.jpg"}];
};
News.prototype = {
	add: function(text,img) {
		this.entries.push({ text : text, img : img});
	}
	,clear: function() {
		this.entries.splice(0,this.entries.length);
	}
};
var Locale = function() {
	this.lang = "de";
};
Locale.prototype = {
	localize: function(x) {
		return this.lang + ": " + x;
	}
};
var Config = function() {
	this.host = "localhost";
	this.imagePath = "/img/";
	this.appName = "News App";
};
var Main = function() { };
Main.main = function() {
	var newsController = function(scope,news) {
		var newEntry = { text : "", img : ""};
		scope.newEntry = newEntry;
		scope.entries = news.entries;
		scope.clickEntry = function(e) {
			console.log("entry clicked: " + e.text);
		};
		scope.addNews = function() {
			news.add(newEntry.text,newEntry.img);
			newEntry.text = "";
			newEntry.img = "";
		};
		scope.clear = $bind(news,news.clear);
	};
	var newsDirective = ($_=new angular.support.DirectiveBuilder().templateConst("<div>\n\t<h2>Lates News</h2>\n\t<ul>\n\t\t<li ng-repeat=\"e in entries\" ng-click=\"clickEntry(e)\">\n\t\t\t<p>text: {{e.text}}</p>\n\t\t\t<p>image: {{e.img}}</p>\n\t\t</li>\n\t\t<div>\n\t\t\t<input type=\"text\" ng-model=\"newEntry.text\">\n\t\t\t<input type=\"text\" ng-model=\"newEntry.img\">\n\t\t\t<button ng-click=\"addNews()\">add</button>\n\t\t</div>\n\t\t<button ng-click=\"clear()\">clear</button>\n\t</ul>\n</div>").controllerDynamic(["$scope","News",newsController]),$bind($_,$_.build));
	var appController = function(scope1,config) {
		console.log("appController initialized");
		scope1.data = { appName : config.appName};
	};
	var module = window.angular.module("myModule",[]).factory("News",["Config",function(c) {
		return new News(c);
	}]).factory("Config",[function() {
		return new Config();
	}]).factory("Locale",[function() {
		return new Locale();
	}]).filter("localize",["Locale",function(l) {
		return function(x) {
			return l.localize(x);
		};
	}]).directive("news",[newsDirective]).controller("AppController",["$scope","Config",appController]);
};
var IMap = function() { };
var Reflect = function() { };
Reflect.setField = function(o,field,value) {
	o[field] = value;
};
var angular = {};
angular._Angular = {};
angular._Angular.TranscludeFn_Impl_ = function() { };
angular._Angular.TranscludeFn_Impl_.call = function(this1,scope,link) {
	this1(scope,link);
};
angular._Angular.TranscludeFn_Impl_.withoutScope = function(this1,link) {
	this1(link);
};
angular.internal = {};
angular.internal.Options = function() { };
angular.internal.Options.each = function(o,f) {
	switch(o[1]) {
	case 0:
		var x = o[2];
		f(x);
		break;
	case 1:
		break;
	}
};
angular.internal.Options.map = function(o,f) {
	switch(o[1]) {
	case 0:
		var x = o[2];
		return haxe.ds.Option.Some(f(x));
	case 1:
		return haxe.ds.Option.None;
	}
};
angular.internal.Options.orElse = function(o,f) {
	switch(o[1]) {
	case 0:
		var x = o[2];
		return haxe.ds.Option.Some(x);
	case 1:
		return f();
	}
};
var js = {};
angular.support = {};
angular.support.LinkOp = { __constructs__ : ["At","Eq","And"] };
angular.support.LinkOp.At = ["At",0];
angular.support.LinkOp.At.__enum__ = angular.support.LinkOp;
angular.support.LinkOp.Eq = ["Eq",1];
angular.support.LinkOp.Eq.__enum__ = angular.support.LinkOp;
angular.support.LinkOp.And = ["And",2];
angular.support.LinkOp.And.__enum__ = angular.support.LinkOp;
angular.support.LinkOps = function() { };
angular.support.LinkOps.toString = function(op) {
	switch(op[1]) {
	case 0:
		return "@";
	case 1:
		return "=";
	case 2:
		return "&";
	}
};
angular.support.DirectiveBuilder = function() {
	this._replace = haxe.ds.Option.None;
	this._restrict = haxe.ds.Option.None;
	this._scope = new haxe.ds.StringMap();
	this._template = haxe.ds.Option.None;
	this._controller = haxe.ds.Option.None;
	this._link = haxe.ds.Option.None;
	this._compile = haxe.ds.Option.None;
	this._transclude = haxe.ds.Option.None;
	this._priority = haxe.ds.Option.None;
	this._isolatedScope = true;
	this._childScope = true;
};
angular.support.DirectiveBuilder.mk = function() {
	return new angular.support.DirectiveBuilder();
};
angular.support.DirectiveBuilder.prototype = {
	transclude: function(b) {
		this._transclude = haxe.ds.Option.Some(b);
		return this;
	}
	,priority: function(i) {
		this._priority = haxe.ds.Option.Some(i);
		return this;
	}
	,isolatedScope: function() {
		this._isolatedScope = true;
		this._childScope = false;
		return this;
	}
	,inheritScope: function() {
		this._isolatedScope = false;
		this._childScope = false;
		return this;
	}
	,restrictToElement: function() {
		this._restrict = angular.internal.Options.orElse(angular.internal.Options.map(this._restrict,function(x) {
			return x + "E";
		}),function() {
			return haxe.ds.Option.Some("E");
		});
		return this;
	}
	,restrictToAttribute: function() {
		this._restrict = angular.internal.Options.orElse(angular.internal.Options.map(this._restrict,function(x) {
			return x + "A";
		}),function() {
			return haxe.ds.Option.Some("A");
		});
		return this;
	}
	,restrictAll: function() {
		this._restrict = haxe.ds.Option.Some("AECM");
		return this;
	}
	,restrictClass: function() {
		this._restrict = angular.internal.Options.orElse(angular.internal.Options.map(this._restrict,function(x) {
			return x + "C";
		}),function() {
			return haxe.ds.Option.Some("C");
		});
		return this;
	}
	,restrictComment: function() {
		this._restrict = angular.internal.Options.orElse(angular.internal.Options.map(this._restrict,function(x) {
			return x + "M";
		}),function() {
			return haxe.ds.Option.Some("M");
		});
		return this;
	}
	,build: function() {
		var r = { };
		var set = Reflect.setField;
		angular.internal.Options.each(this._replace,(function(f,o,a1) {
			return function(a2) {
				f(o,a1,a2);
			};
		})(set,r,"replace"));
		angular.internal.Options.each(this._restrict,(function(f1,o1,a11) {
			return function(a21) {
				f1(o1,a11,a21);
			};
		})(set,r,"restrict"));
		if(this._scope.keys().hasNext()) {
			var scopeObj = { };
			var $it0 = this._scope.keys();
			while( $it0.hasNext() ) {
				var k = $it0.next();
				set(scopeObj,k,this._scope.get(k));
			}
			set(r,"scope",scopeObj);
		} else if(this._isolatedScope) set(r,"scope",{ }); else if(this._childScope) set(r,"scope",true);
		angular.internal.Options.each(this._template,(function(f2,o2,a12) {
			return function(a22) {
				f2(o2,a12,a22);
			};
		})(set,r,"template"));
		angular.internal.Options.each(this._controller,(function(f3,o3,a13) {
			return function(a23) {
				f3(o3,a13,a23);
			};
		})(set,r,"controller"));
		angular.internal.Options.each(this._transclude,(function(f4,o4,a14) {
			return function(a24) {
				f4(o4,a14,a24);
			};
		})(set,r,"transclude"));
		angular.internal.Options.each(this._link,(function(f5,o5,a15) {
			return function(a25) {
				f5(o5,a15,a25);
			};
		})(set,r,"link"));
		angular.internal.Options.each(this._compile,(function(f6,o6,a16) {
			return function(a26) {
				f6(o6,a16,a26);
			};
		})(set,r,"compile"));
		angular.internal.Options.each(this._priority,(function(f7,o7,a17) {
			return function(a27) {
				f7(o7,a17,a27);
			};
		})(set,r,"priority"));
		return r;
	}
	,replace: function(v) {
		this._replace = haxe.ds.Option.Some(v);
		return this;
	}
	,scope: function(field,op,val) {
		if(val == null) val = "";
		this._scope.set(field,angular.support.LinkOps.toString(op) + val);
		return this;
	}
	,templateFunc: function(x) {
		this._template = haxe.ds.Option.Some(x);
		return this;
	}
	,templateConst: function(x) {
		this._template = haxe.ds.Option.Some(function() {
			return x;
		});
		return this;
	}
	,compile: function(f) {
		this._compile = haxe.ds.Option.Some(f);
		return this;
	}
	,compilePrePost: function(f) {
		this._compile = haxe.ds.Option.Some(f);
		return this;
	}
	,link: function(f) {
		this._link = haxe.ds.Option.Some(f);
		return this;
	}
	,linkPreAndPost: function(pre,post) {
		this._link = haxe.ds.Option.Some({ pre : pre, post : post});
		return this;
	}
	,controllerDynamic: function(arr) {
		this._controller = haxe.ds.Option.Some(arr);
		return this;
	}
};
var haxe = {};
haxe.ds = {};
haxe.ds.Option = { __constructs__ : ["Some","None"] };
haxe.ds.Option.Some = function(v) { var $x = ["Some",0,v]; $x.__enum__ = haxe.ds.Option; return $x; };
haxe.ds.Option.None = ["None",1];
haxe.ds.Option.None.__enum__ = haxe.ds.Option;
haxe.ds.StringMap = function() {
	this.h = { };
};
haxe.ds.StringMap.__interfaces__ = [IMap];
haxe.ds.StringMap.prototype = {
	set: function(key,value) {
		this.h["$" + key] = value;
	}
	,get: function(key) {
		return this.h["$" + key];
	}
	,keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key.substr(1));
		}
		return HxOverrides.iter(a);
	}
};
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
var q = window.jQuery;
var js = js || {}
js.JQuery = q;
Main.main();
})();
