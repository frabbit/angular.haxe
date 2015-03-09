(function (console) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var MyOtherModel = function() {
};
MyOtherModel.__name__ = true;
var MyModel = function() {
	this.x = "hey";
};
MyModel.__name__ = true;
MyModel.mk = function(x) {
	var m = new MyModel();
	m.x = "hey foo";
	return m;
};
MyModel.mk2 = function(x,y) {
	return new MyModel();
};
var Foo = function(val) {
	this.val = val;
};
Foo.__name__ = true;
var FooProvider2 = function() {
	this.val = 5;
};
FooProvider2.__name__ = true;
FooProvider2.prototype = {
	get: function(t) {
		haxe_Log.trace("get a foo",{ fileName : "Main.hx", lineNumber : 55, className : "FooProvider2", methodName : "get"});
		return new Foo(this.val);
	}
};
var _$Main_Whoot_$Impl_$ = {};
_$Main_Whoot_$Impl_$.__name__ = true;
_$Main_Whoot_$Impl_$._new = function() {
	return "whoot";
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	haxe_Log.trace;
	var m = window.angular.module("myModule",[]);
	m.factory("MyModel",[function() {
		return new MyModel();
	}]);
	m.factory("MyOtherModel",[function() {
		return new MyOtherModel();
	}]);
	m.factory("Whoot",[function() {
		return _$Main_Whoot_$Impl_$._new();
	}]);
	m.factory("String",[function() {
		return "hello";
	}]);
	m.run(["Whoot",function(w) {
		haxe_Log.trace("the whoot:" + w,{ fileName : "Main.hx", lineNumber : 85, className : "Main", methodName : "main"});
	}]);
	m.run(["String",function(w1) {
		haxe_Log.trace("the String:" + w1,{ fileName : "Main.hx", lineNumber : 88, className : "Main", methodName : "main"});
	}]);
	m.filter("lower",["Whoot",function(w2) {
		haxe_Log.trace(w2,{ fileName : "Main.hx", lineNumber : 92, className : "Main", methodName : "main"});
		return function(x1) {
			return x1.toLowerCase();
		};
	}]);
	m.config(["$logProvider",function(l) {
		haxe_Log.trace(l,{ fileName : "Main.hx", lineNumber : 102, className : "Main", methodName : "main"});
		l.debugEnabled(true);
	}]);
	m.controller("MyController",["$scope","MyModel",function(s1,m1) {
		haxe_Log.trace("init controller",{ fileName : "Main.hx", lineNumber : 108, className : "Main", methodName : "main"});
		haxe_Log.trace("scope phase:" + s1.$$phase,{ fileName : "Main.hx", lineNumber : 109, className : "Main", methodName : "main"});
		haxe_Log.trace(m1,{ fileName : "Main.hx", lineNumber : 110, className : "Main", methodName : "main"});
	}]);
	m.run([function() {
		haxe_Log.trace("wtf",{ fileName : "Main.hx", lineNumber : 114, className : "Main", methodName : "main"});
	}]);
	m.run(["MyModel","$rootScope","$injector",function(m2,r1,inj) {
		haxe_Log.trace(m2,{ fileName : "Main.hx", lineNumber : 117, className : "Main", methodName : "main"});
		haxe_Log.trace(r1.$root.$$phase,{ fileName : "Main.hx", lineNumber : 118, className : "Main", methodName : "main"});
		var t1 = inj.get("$timeout");
		t1(function() {
			haxe_Log.trace("hello11",{ fileName : "Main.hx", lineNumber : 121, className : "Main", methodName : "main"});
		},1);
	}]);
	m.run(["$rootElement",function(r2) {
		haxe_Log.trace(r2.injector(),{ fileName : "Main.hx", lineNumber : 125, className : "Main", methodName : "main"});
	}]);
	var directive = function(r) {
		haxe_Log.trace(r,{ fileName : "Main.hx", lineNumber : 129, className : "Main", methodName : "main"});
		return new angular_support_DirectiveBuilder().templateConst("<div></div>").controllerDynamic(["$scope","$timeout",function(s,t) {
			var x = t(function() {
				haxe_Log.trace("timer call",{ fileName : "Main.hx", lineNumber : 133, className : "Main", methodName : "main"});
			},10);
			t.cancel(x);
		}]).build();
	};
	m.directive("myDirective",["$browser",directive]);
	haxe_Log.trace(window.angular.version,{ fileName : "Main.hx", lineNumber : 144, className : "Main", methodName : "main"});
	haxe_Log.trace("do bootstrap",{ fileName : "Main.hx", lineNumber : 146, className : "Main", methodName : "main"});
	window.angular.bootstrap(js.JQuery("body")[0],["myModule"]);
};
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.setField = function(o,field,value) {
	o[field] = value;
};
var angular__$Angular_TranscludeFn_$Impl_$ = {};
angular__$Angular_TranscludeFn_$Impl_$.__name__ = true;
angular__$Angular_TranscludeFn_$Impl_$.call = function(this1,scope,link) {
	this1(scope,link);
};
angular__$Angular_TranscludeFn_$Impl_$.withoutScope = function(this1,link) {
	this1(link);
};
var angular_internal_ModuleMacros = function() { };
angular_internal_ModuleMacros.__name__ = true;
var angular_internal_DirectiveBuilderMacros = function() { };
angular_internal_DirectiveBuilderMacros.__name__ = true;
var angular_internal_InjectorMacros = function() { };
angular_internal_InjectorMacros.__name__ = true;
var angular_internal_Options = function() { };
angular_internal_Options.__name__ = true;
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
var angular_support_LinkOp = { __ename__ : true, __constructs__ : ["At","Eq","And"] };
angular_support_LinkOp.At = ["At",0];
angular_support_LinkOp.At.__enum__ = angular_support_LinkOp;
angular_support_LinkOp.Eq = ["Eq",1];
angular_support_LinkOp.Eq.__enum__ = angular_support_LinkOp;
angular_support_LinkOp.And = ["And",2];
angular_support_LinkOp.And.__enum__ = angular_support_LinkOp;
var angular_support_LinkOps = function() { };
angular_support_LinkOps.__name__ = true;
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
angular_support_DirectiveBuilder.__name__ = true;
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
haxe_IMap.__name__ = true;
var haxe_Log = function() { };
haxe_Log.__name__ = true;
haxe_Log.trace = function(v,infos) {
	js_Boot.__trace(v,infos);
};
var haxe_ds_Option = { __ename__ : true, __constructs__ : ["Some","None"] };
haxe_ds_Option.Some = function(v) { var $x = ["Some",0,v]; $x.__enum__ = haxe_ds_Option; return $x; };
haxe_ds_Option.None = ["None",1];
haxe_ds_Option.None.__enum__ = haxe_ds_Option;
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__name__ = true;
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
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
};
js_Boot.__trace = function(v,i) {
	var msg;
	if(i != null) msg = i.fileName + ":" + i.lineNumber + ": "; else msg = "";
	msg += js_Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0;
		var _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js_Boot.__string_rec(v1,"");
		}
	}
	var d;
	if(typeof(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null) d.innerHTML += js_Boot.__unhtml(msg) + "<br/>"; else if(typeof console != "undefined" && console.log != null) console.log(msg);
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
var q = window.jQuery;
var js = js || {}
js.JQuery = q;
var __map_reserved = {}
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
