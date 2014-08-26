
import jasmine.Jasmine.Jasmine.*;
import protractor.Protractor.Protractor.*;

class Test1 {

	public static function main () {

		describe('angularjs homepage', function() {
			it('should have a title', function() {
				browser.get('http://juliemr.github.io/protractor-demo/');
				expect(browser.getTitle()).toEqual('Super Calculator');
			});
		});


	}

}