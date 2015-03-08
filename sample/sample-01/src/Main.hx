package ;

import angular.Angular;
import angular.service.Browser;
import angular.service.Injector;
import angular.provider.LogProvider;
import angular.service.Parse;
import angular.service.RootElement;
import angular.service.RootScope;
import angular.service.Scope;
import angular.service.Timeout;
import angular.support.DirectiveBuilder;
import angular.service.Compile;

class MyOtherModel {

	public function new () {}
}

class MyModel {
	var x : String = "hey";
	public function new () {}

	public static function mk (x:MyOtherModel) {
		var m =  new MyModel();
		m.x = "hey foo";
		return m;
	}

	public static function mk2 (x:MyOtherModel, y:Parse) {
		return new MyModel();
	}
}

class Foo {

	var val:Int;

	public function new (val:Int) {
		this.val = val;
	}
}


class FooProvider2 {
	public var val = 5;
	public function new ()
	{

	}



	public function get (t:Timeout) {
		trace("get a foo");
		return new Foo(val);
	}
}


abstract Whoot(String) {
	public function new () {
		this = "whoot";
	}
}

class Main {

	public static function main () {


		haxe.Log.trace;
		var m = Angular.module("myModule", []);

		m.factory(MyModel.new);



		m.factory(MyOtherModel.new);

		m.factory(function () return new Whoot());
		m.factory(function () return "hello");

		m.run(function (w:Whoot) {
			trace("the whoot:" + w);
		});
		m.run(function (w:String) {
			trace("the String:" + w);
		});

		m.filter("lower", function (w:Whoot) {
			trace(w);
			return function (x:String) {
				return x.toLowerCase();
			}
		});




		m.config(function (l:LogProvider) {
			trace(l);
			l.debugEnabled(true);
		});


		m.controller("MyController", function (s:Scope, m:MyModel) {
			trace("init controller");
			trace("scope phase:" + s.phase);
			trace(m);
		});


		m.run(function () { trace("wtf");} );

		m.run(function (m:MyModel, r:RootScope, inj:Injector) {
			trace(m);
			trace(r.root.phase);

			var t = inj.get(angular.service.Timeout);
			t.timeout(function () { trace("hello11");}, 1);
		});

		m.run(function (r:RootElement) {
			trace(r.injector());
		});

		var directive = function (r:Browser) {
			trace(r);
			return DirectiveBuilder.mk()
				.templateConst("<div></div>")
				.controller(function (s:Scope, t:Timeout ) {
					var x = t.timeout(function () { trace("timer call");},10);
					t.cancel(x);

				})
				.build();
		}

		m.directive("myDirective", directive);



		trace(Angular.version);

		trace("do bootstrap");
		Angular.bootstrap(new js.JQuery("body")[0], ["myModule"]);


	}

}