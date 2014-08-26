
package angular.internal;

import haxe.ds.Option;

class Options {

	public static function each <T>(o:Option<T>, f:T->Void) {
		switch (o) {
			case Some(x): f(x);
			case None:
		}
	}

	public static function map <T,S>(o:Option<T>, f:T->S)
	{
		return switch (o) {
			case Some(x): Some(f(x));
			case None: None;
		}
	}

	public static function orElse <T,S>(o:Option<T>, f:Void->Option<T>)
	{
		return switch (o) {
			case Some(x): Some(x);
			case None: f();
		}
	}

}