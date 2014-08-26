package angular.support;


import haxe.ds.StringMap;
import haxe.ds.Option;

import angular.internal.DirectiveBuilderMacros;
import angular.service.Element;
import angular.Angular;
import angular.service.Attributes;
import angular.service.Controller;
import angular.service.Scope;
import angular.Module;
import angular.service.Attributes;
import angular.service.Controller;
import angular.service.Scope;

using angular.internal.Options;
using angular.support.DirectiveBuilder.LinkOps;

private typedef LinkingFunction = Scope->Element->Attributes->Controller->TranscludeFn->Void;

enum LinkOp {
	At;
	Eq;
	And;
}

class LinkOps {
	public static function toString (op:LinkOp) return switch (op)
	{
		case At: "@";
		case Eq: "=";
		case And: "&";
	}
}

class DirectiveBuilder extends DirectiveBuilderMacros
{

	var _isolatedScope : Bool;
	var _childScope : Bool;
	var _replace : Option<Bool>;
	var _restrict : Option<String>;
	var _scope : StringMap<String>;
	var _template : Option<Void->String>;
	var _controller : Option<Dynamic>;

	var _link : Option<Dynamic>;

	var _transclude : Option<Bool>;

	var _compile : Option<Dynamic>;
	var _priority : Option<Int>;

	public function new ()
	{
		_replace = None;
		_restrict = None;
		_scope = new StringMap();
		_template = None;
		_controller = None;
		_link = None;
		_compile = None;
		_transclude = None;
		_priority = None;
		_isolatedScope = true;
		_childScope = true;
	}

	public function transclude (b:Bool) {
		this._transclude = Some(b);
		return this;
	}

	public function priority (i:Int) {
		this._priority = Some(i);
		return this;
	}

	public static inline function mk() {
		return new DirectiveBuilder();
	}

	public function isolatedScope () {
		_isolatedScope = true;
		_childScope = false;
		return this;
	}

	public function inheritScope () {
		_isolatedScope = false;
		_childScope = false;
		return this;
	}
	public function restrictToElement ()
	{
		_restrict = _restrict.map(function (x) return x + "E").orElse(function () return Some("E"));
		return this;
	}

	public function restrictToAttribute ()
	{
		_restrict = _restrict.map(function (x) return x + "A").orElse(function () return Some("A"));
		return this;
	}

	public function restrictAll ()
	{
		_restrict = Some("AECM");
		return this;
	}

	public function restrictClass ()
	{
		_restrict = _restrict.map(function (x) return x + "C").orElse(function () return Some("C"));
		return this;
	}

	public function restrictComment ()
	{
		_restrict = _restrict.map(function (x) return x + "M").orElse(function () return Some("M"));
		return this;
	}

	public function build()
	{
		var r = {};

		var set = Reflect.setField;

		_replace.each(set.bind(r, "replace", _));
		_restrict.each(set.bind(r, "restrict", _));

		if (_scope.keys().hasNext())
		{
			var scopeObj = {};
			for (k in _scope.keys())
			{
				set(scopeObj, k, _scope.get(k));
			}

			set(r, "scope", scopeObj);

		} else {
			if (_isolatedScope) {
				set(r, "scope", {});
			} else if (_childScope) {
				set(r, "scope", true);
			}
		}
		_template.each(set.bind(r, "template", _));
		_controller.each(set.bind(r, "controller", _));

		_transclude.each(set.bind(r, "transclude",_));
		_link.each(set.bind(r, "link",_));
		_compile.each(set.bind(r, "compile",_));
		_priority.each(set.bind(r, "priority",_));

		return r;
	}

	public function replace (v:Bool)
	{
		_replace = Some(v);
		return this;
	}

	public function scope (field:String, op:LinkOp, ?val:String = "")
	{
		_scope.set(field, op.toString() + val);
		return this;
	}

	public function templateFunc (x:Void->String)
	{
		_template = Some(x);
		return this;
	}

	public function templateConst (x:String)
	{
		_template = Some(function () return x);
		return this;
	}

	public function compile (f:Element->Attributes->LinkingFunction)
	{
		_compile = Some(f);
		return this;
	}

	public function compilePrePost (f:Element->Attributes->{ pre : LinkingFunction, post : LinkingFunction})
	{
		_compile = Some(f);
		return this;
	}

	public function link (f:LinkingFunction)
	{

		_link = Some(f);
		return this;
	}

	public function linkPreAndPost (pre:LinkingFunction, post:LinkingFunction)
	{
		_link = Some({ pre : pre, post : post });
		return this;
	}

	@:noCompletion public function controllerDynamic (arr:Array<Dynamic>)
	{
		_controller = Some(arr);
		return this;
	}




}