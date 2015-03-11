
package angular.internal;

import haxe.io.Path;
import haxe.macro.Context;

import haxe.ds.Option;

class FileMacros {


	#if !macro macro #end public static function getHtmlRelative (pathWithoutSuffix:String)
	{
		return getFileRelative(pathWithoutSuffix + ".html");
	}

	#if !macro macro #end public static function getFileRelative (fileName:String)
	{
		return getContentAsValue(fileName, true);
	}

	macro public static function getHtml (pathWithoutSuffix:String)
	{
		var p = pathWithoutSuffix.split(".");
		var last = p.pop();

		return getContentAsValueByClassPath(p.join("."), last + ".html");
	}

	#if !macro macro #end public static function insertJsFile (pack:String, file:String, exports:haxe.macro.Expr) {
		var content = getContentAsValueByClassPath(pack, file);
		var content = switch (content.expr) {
			case EConst(CString(s)): "(" + s + ")";
			case _ : throw "assert";
		}
		return macro untyped __js__($v{content})($exports);
	}

	#if !macro macro #end public static function getContentAsValueByClassPath (pack:String, file:String)
	{
		var chunks = pack.split(".");
		var roots = Context.getClassPath();
		var path = "";
		for (c in chunks) {

			path = Path.addTrailingSlash(path + c);
		}
		path = Path.addTrailingSlash(path) + file;


		var found = None;


		for ( r in roots) {
			var test = r + path;
			//trace(test);
			if (sys.FileSystem.exists(test)) {
				found = Some(test);
			}
		}


		return switch (found) {
			case Some(f): getContentAsValue(f, false);
			case None: Context.error("Cannot find file " + file + " in pack " + pack, Context.currentPos());
		}

	}


	#if !macro macro #end public static function getContentAsValue (path:String, relative:Bool = false) {
		#if display
		return macro "";
		#end
		var file = if (relative)
		{
			var pos = Context.getPosInfos(Context.currentPos());
			var dir = Path.directory(pos.file);
			var file = Path.addTrailingSlash(dir) + path;
			file;
		}
		else
		{
			path;
		}
		var content = sys.io.File.getContent(file);

		return macro $v{content};
	}



}