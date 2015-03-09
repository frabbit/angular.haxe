(function (console) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
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
	var newsDirective = ($_=new angular_support_DirectiveBuilder().templateConst("<div>\n\t<h2>Lates News</h2>\n\t<ul>\n\t\t<li ng-repeat=\"e in entries\" ng-click=\"clickEntry(e)\">\n\t\t\t<p>text: {{e.text}}</p>\n\t\t\t<p>image: {{e.img}}</p>\n\t\t</li>\n\t\t<div>\n\t\t\t<input type=\"text\" ng-model=\"newEntry.text\">\n\t\t\t<input type=\"text\" ng-model=\"newEntry.img\">\n\t\t\t<button ng-click=\"addNews()\">add</button>\n\t\t</div>\n\t\t<button ng-click=\"clear()\">clear</button>\n\t</ul>\n</div>").controllerDynamic(["$scope","News",newsController]),$bind($_,$_.build));
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
var Reflect = function() { };
Reflect.setField = function(o,field,value) {
	o[field] = value;
};
var angular__$Angular_TranscludeFn_$Impl_$ = {};
angular__$Angular_TranscludeFn_$Impl_$.call = function(this1,scope,link) {
	this1(scope,link);
};
angular__$Angular_TranscludeFn_$Impl_$.withoutScope = function(this1,link) {
	this1(link);
};
var angular_internal_ModuleMacros = function() { };
var angular_internal_DirectiveBuilderMacros = function() { };
var angular_internal_InjectorMacros = function() { };
var angular_internal_Options = function() { };
angular_internal_Options.each = function(o,f) {
	switch(o[1]) {
	case 0:
		var x = o[2];
		f(x);
		break;
	case 1:
		break;
	}
};
angular_internal_Options.map = function(o,f) {
	switch(o[1]) {
	case 0:
		var x = o[2];
		return haxe_ds_Option.Some(f(x));
	case 1:
		return haxe_ds_Option.None;
	}
};
angular_internal_Options.orElse = function(o,f) {
	switch(o[1]) {
	case 0:
		var x = o[2];
		return haxe_ds_Option.Some(x);
	case 1:
		return f();
	}
};
var angular_support_LinkOp = { __constructs__ : ["At","Eq","And"] };
angular_support_LinkOp.At = ["At",0];
angular_support_LinkOp.At.__enum__ = angular_support_LinkOp;
angular_support_LinkOp.Eq = ["Eq",1];
angular_support_LinkOp.Eq.__enum__ = angular_support_LinkOp;
angular_support_LinkOp.And = ["And",2];
angular_support_LinkOp.And.__enum__ = angular_support_LinkOp;
var angular_support_LinkOps = function() { };
angular_support_LinkOps.toString = function(op) {
	switch(op[1]) {
	case 0:
		return "@";
	case 1:
		return "=";
	case 2:
		return "&";
	}
};
var angular_support_DirectiveBuilder = function() {
	this._replace = haxe_ds_Option.None;
	this._restrict = haxe_ds_Option.None;
	this._scope = new haxe_ds_StringMap();
	this._template = haxe_ds_Option.None;
	this._controller = haxe_ds_Option.None;
	this._link = haxe_ds_Option.None;
	this._compile = haxe_ds_Option.None;
	this._transclude = haxe_ds_Option.None;
	this._priority = haxe_ds_Option.None;
	this._templateUrl = haxe_ds_Option.None;
	this._isolatedScope = true;
	this._childScope = true;
};
angular_support_DirectiveBuilder.mk = function() {
	return new angular_support_DirectiveBuilder();
};
angular_support_DirectiveBuilder.__super__ = angular_internal_DirectiveBuilderMacros;
angular_support_DirectiveBuilder.prototype = $extend(angular_internal_DirectiveBuilderMacros.prototype,{
	transclude: function(b) {
		this._transclude = haxe_ds_Option.Some(b);
		return this;
	}
	,priority: function(i) {
		this._priority = haxe_ds_Option.Some(i);
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
		this._restrict = angular_internal_Options.orElse(angular_internal_Options.map(this._restrict,function(x) {
			return x + "E";
		}),function() {
			return haxe_ds_Option.Some("E");
		});
		return this;
	}
	,restrictToAttribute: function() {
		this._restrict = angular_internal_Options.orElse(angular_internal_Options.map(this._restrict,function(x) {
			return x + "A";
		}),function() {
			return haxe_ds_Option.Some("A");
		});
		return this;
	}
	,restrictAll: function() {
		this._restrict = haxe_ds_Option.Some("AECM");
		return this;
	}
	,restrictClass: function() {
		this._restrict = angular_internal_Options.orElse(angular_internal_Options.map(this._restrict,function(x) {
			return x + "C";
		}),function() {
			return haxe_ds_Option.Some("C");
		});
		return this;
	}
	,restrictComment: function() {
		this._restrict = angular_internal_Options.orElse(angular_internal_Options.map(this._restrict,function(x) {
			return x + "M";
		}),function() {
			return haxe_ds_Option.Some("M");
		});
		return this;
	}
	,build: function() {
		var r = { };
		var set = Reflect.setField;
		angular_internal_Options.each(this._replace,(function(f,o,a1) {
			return function(a2) {
				f(o,a1,a2);
			};
		})(set,r,"replace"));
		angular_internal_Options.each(this._restrict,(function(f1,o1,a11) {
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
		angular_internal_Options.each(this._template,(function(f2,o2,a12) {
			return function(a22) {
				f2(o2,a12,a22);
			};
		})(set,r,"template"));
		angular_internal_Options.each(this._templateUrl,(function(f3,o3,a13) {
			return function(a23) {
				f3(o3,a13,a23);
			};
		})(set,r,"templateUrl"));
		angular_internal_Options.each(this._controller,(function(f4,o4,a14) {
			return function(a24) {
				f4(o4,a14,a24);
			};
		})(set,r,"controller"));
		angular_internal_Options.each(this._transclude,(function(f5,o5,a15) {
			return function(a25) {
				f5(o5,a15,a25);
			};
		})(set,r,"transclude"));
		angular_internal_Options.each(this._link,(function(f6,o6,a16) {
			return function(a26) {
				f6(o6,a16,a26);
			};
		})(set,r,"link"));
		angular_internal_Options.each(this._compile,(function(f7,o7,a17) {
			return function(a27) {
				f7(o7,a17,a27);
			};
		})(set,r,"compile"));
		angular_internal_Options.each(this._priority,(function(f8,o8,a18) {
			return function(a28) {
				f8(o8,a18,a28);
			};
		})(set,r,"priority"));
		return r;
	}
	,replace: function(v) {
		this._replace = haxe_ds_Option.Some(v);
		return this;
	}
	,scope: function(field,op,val) {
		if(val == null) val = "";
		this._scope.set(field,angular_support_LinkOps.toString(op) + val);
		return this;
	}
	,templateFunc: function(x) {
		this._template = haxe_ds_Option.Some(x);
		return this;
	}
	,templateConst: function(x) {
		this._template = haxe_ds_Option.Some(function() {
			return x;
		});
		return this;
	}
	,templateUrl: function(x) {
		this._templateUrl = haxe_ds_Option.Some(x);
		return this;
	}
	,compile: function(f) {
		this._compile = haxe_ds_Option.Some(f);
		return this;
	}
	,compilePrePost: function(f) {
		this._compile = haxe_ds_Option.Some(f);
		return this;
	}
	,link: function(f) {
		this._link = haxe_ds_Option.Some(f);
		return this;
	}
	,linkPreAndPost: function(pre,post) {
		this._link = haxe_ds_Option.Some({ pre : pre, post : post});
		return this;
	}
	,controllerDynamic: function(arr) {
		this._controller = haxe_ds_Option.Some(arr);
		return this;
	}
});
var haxe_IMap = function() { };
var haxe_ds_Option = { __constructs__ : ["Some","None"] };
haxe_ds_Option.Some = function(v) { var $x = ["Some",0,v]; $x.__enum__ = haxe_ds_Option; return $x; };
haxe_ds_Option.None = ["None",1];
haxe_ds_Option.None.__enum__ = haxe_ds_Option;
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	set: function(key,value) {
		if(__map_reserved[key] != null) this.setReserved(key,value); else this.h[key] = value;
	}
	,get: function(key) {
		if(__map_reserved[key] != null) return this.getReserved(key);
		return this.h[key];
	}
	,setReserved: function(key,value) {
		if(this.rh == null) this.rh = { };
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) return null; else return this.rh["$" + key];
	}
	,keys: function() {
		var _this = this.arrayKeys();
		return HxOverrides.iter(_this);
	}
	,arrayKeys: function() {
		var out = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) out.push(key);
		}
		if(this.rh != null) {
			for( var key in this.rh ) {
			if(key.charCodeAt(0) == 36) out.push(key.substr(1));
			}
		}
		return out;
	}
};
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
var q = window.jQuery;
var js = js || {}
js.JQuery = q;
var __map_reserved = {}
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
