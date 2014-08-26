(function () { "use strict";
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
		haxe.Log.trace("get a foo",{ fileName : "Main.hx", lineNumber : 56, className : "FooProvider2", methodName : "get"});
		return new Foo(this.val);
	}
};
var _Main = {};
_Main.Whoot_Impl_ = function() { };
_Main.Whoot_Impl_.__name__ = true;
_Main.Whoot_Impl_._new = function() {
	return "whoot";
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	haxe.Log.trace;
	var m = window.angular.module("myModule",[]);
	m.factory("MyModel",[function() {
		return new MyModel();
	}]);
	m.factory("MyModel",["MyOtherModel",MyModel.mk]);
	m.factory("MyOtherModel",[function() {
		return new MyOtherModel();
	}]);
	m.factory("Whoot",[function() {
		return _Main.Whoot_Impl_._new();
	}]);
	m.factory("String",[function() {
		return "hello";
	}]);
	m.run(["Whoot",function(w) {
		haxe.Log.trace("the whoot:" + w,{ fileName : "Main.hx", lineNumber : 86, className : "Main", methodName : "main"});
	}]);
	m.run(["String",function(w1) {
		haxe.Log.trace("the String:" + w1,{ fileName : "Main.hx", lineNumber : 89, className : "Main", methodName : "main"});
	}]);
	m.filter("lower",["Whoot",function(w2) {
		haxe.Log.trace(w2,{ fileName : "Main.hx", lineNumber : 93, className : "Main", methodName : "main"});
		return function(x) {
			return x.toLowerCase();
		};
	}]);
	m.provider("myFoo",["$logProvider",function(argWrapper0) {
		var res;
		haxe.Log.trace(argWrapper0,{ fileName : "Main.hx", lineNumber : 100, className : "Main", methodName : "main"});
		haxe.Log.trace("provider called",{ fileName : "Main.hx", lineNumber : 101, className : "Main", methodName : "main"});
		res = new FooProvider2();
		if(!Object.prototype.hasOwnProperty.call(res,"$get")) res.$get = ["$timeout",function(arg0) {
			return res.get(arg0);
		}];
		return res;
	}]);
	m.config(["myFooProvider",function(f) {
		haxe.Log.trace("provider config called",{ fileName : "Main.hx", lineNumber : 106, className : "Main", methodName : "main"});
		f.val = 10;
	}]);
	m.config(["$logProvider",function(l) {
		haxe.Log.trace(l,{ fileName : "Main.hx", lineNumber : 111, className : "Main", methodName : "main"});
		l.debugEnabled(true);
	}]);
	m.controller("MyController",["$scope","foo",function(s,m1) {
		haxe.Log.trace("init controller",{ fileName : "Main.hx", lineNumber : 117, className : "Main", methodName : "main"});
		haxe.Log.trace("scope phase:" + s.$$phase,{ fileName : "Main.hx", lineNumber : 118, className : "Main", methodName : "main"});
		haxe.Log.trace(m1,{ fileName : "Main.hx", lineNumber : 119, className : "Main", methodName : "main"});
	}]);
	m.run([function() {
		haxe.Log.trace("wtf",{ fileName : "Main.hx", lineNumber : 123, className : "Main", methodName : "main"});
	}]);
	m.run(["MyModel","$rootScope","$injector",function(m2,r,inj) {
		haxe.Log.trace(m2,{ fileName : "Main.hx", lineNumber : 126, className : "Main", methodName : "main"});
		haxe.Log.trace(r.$root.$$phase,{ fileName : "Main.hx", lineNumber : 127, className : "Main", methodName : "main"});
		var t = inj.get("$timeout");
		t(function() {
			haxe.Log.trace("hello11",{ fileName : "Main.hx", lineNumber : 130, className : "Main", methodName : "main"});
		},1);
	}]);
	m.run(["$rootElement",function(r1) {
		haxe.Log.trace(r1.injector(),{ fileName : "Main.hx", lineNumber : 134, className : "Main", methodName : "main"});
	}]);
	var directive = function(r2) {
		haxe.Log.trace(r2,{ fileName : "Main.hx", lineNumber : 138, className : "Main", methodName : "main"});
		return new angular.support.DirectiveBuilder().templateConst("<div></div>").controllerDynamic(["$scope","$timeout",function(s1,t1) {
			var x1 = t1(function() {
				haxe.Log.trace("timer call",{ fileName : "Main.hx", lineNumber : 142, className : "Main", methodName : "main"});
			},10);
			angular.service._Timeout.Timeout_Impl_.cancel(t1,x1);
		}]).build();
	};
	m.directive("myDirective",["$browser",directive]);
	m.run(["myFoo",function(x2) {
		haxe.Log.trace(x2,{ fileName : "Main.hx", lineNumber : 152, className : "Main", methodName : "main"});
	}]);
	haxe.Log.trace(window.angular.version,{ fileName : "Main.hx", lineNumber : 155, className : "Main", methodName : "main"});
	haxe.Log.trace("do bootstrap",{ fileName : "Main.hx", lineNumber : 157, className : "Main", methodName : "main"});
	window.angular.bootstrap(new js.JQuery("body")[0],["myModule"]);
};
var IMap = function() { };
IMap.__name__ = true;
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.setField = function(o,field,value) {
	o[field] = value;
};
var angular = {};
angular._Angular = {};
angular._Angular.TranscludeFn_Impl_ = function() { };
angular._Angular.TranscludeFn_Impl_.__name__ = true;
angular._Angular.TranscludeFn_Impl_.call = function(this1,scope,link) {
	this1(scope,link);
};
angular._Angular.TranscludeFn_Impl_.withoutScope = function(this1,link) {
	this1(link);
};
angular.internal = {};
angular.internal.Options = function() { };
angular.internal.Options.__name__ = true;
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
angular.service = {};
angular.service._Timeout = {};
angular.service._Timeout.Timeout_Impl_ = function() { };
angular.service._Timeout.Timeout_Impl_.__name__ = true;
angular.service._Timeout.Timeout_Impl_.cancel = function(this1,promise) {
	return this1.cancel(promise);
};
angular.support = {};
angular.support.LinkOp = { __ename__ : true, __constructs__ : ["At","Eq","And"] };
angular.support.LinkOp.At = ["At",0];
angular.support.LinkOp.At.__enum__ = angular.support.LinkOp;
angular.support.LinkOp.Eq = ["Eq",1];
angular.support.LinkOp.Eq.__enum__ = angular.support.LinkOp;
angular.support.LinkOp.And = ["And",2];
angular.support.LinkOp.And.__enum__ = angular.support.LinkOp;
angular.support.LinkOps = function() { };
angular.support.LinkOps.__name__ = true;
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
angular.support.DirectiveBuilder.__name__ = true;
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
haxe.Log = function() { };
haxe.Log.__name__ = true;
haxe.Log.trace = function(v,infos) {
	js.Boot.__trace(v,infos);
};
haxe.ds = {};
haxe.ds.Option = { __ename__ : true, __constructs__ : ["Some","None"] };
haxe.ds.Option.Some = function(v) { var $x = ["Some",0,v]; $x.__enum__ = haxe.ds.Option; return $x; };
haxe.ds.Option.None = ["None",1];
haxe.ds.Option.None.__enum__ = haxe.ds.Option;
haxe.ds.StringMap = function() {
	this.h = { };
};
haxe.ds.StringMap.__name__ = true;
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
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
};
js.Boot.__trace = function(v,i) {
	var msg;
	if(i != null) msg = i.fileName + ":" + i.lineNumber + ": "; else msg = "";
	msg += js.Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0;
		var _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js.Boot.__string_rec(v1,"");
		}
	}
	var d;
	if(typeof(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null) d.innerHTML += js.Boot.__unhtml(msg) + "<br/>"; else if(typeof console != "undefined" && console.log != null) console.log(msg);
};
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
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
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
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
Main.main();
})();
