TranslationKit
==============

TranslationKit is a simple Cocoa framework which utilizes Google Translate to translate text.

Usage
-----

The framework consists of one class - `MRTranslationOperation` - and as the name suggests, it is a subclass of `NSOperation`. A source string to translate and a destination language code need to be passed to the initializer. A list of language codes that Google Translate supports can be found [here](http://code.google.com/apis/ajaxlanguage/documentation/reference.html#LangNameArray).

Basic usage:

	MRTranslationOperation *op = [[MRTranslationOperation alloc] initWithSourceString:@"Buenos Dias!"
															  destinationLanguageCode:@"en"];
		
	op.delegate = self;
	
	[queue addOperation:op];
	[op release];

The code above will translate the string "Buenos Dias!" to English. Don't forget to set the delegate to receive a callback with the translated string.

Some applications may also want to convert a localized display name of a language to its corresponding language code. This can be done using the `NSLocale` class as shown below.

`[NSLocale canonicalLanguageIdentifierFromString:@"English"]; // this returns "en"`

The `MRTranslationOperation` class can also be used from within the context of a `NSThread`. This can be done by invoking the `main` method of an instance of `MRTranslationOperation` using `+ [NSThread detachNewThreadSelector:toTarget:withObject:]`

iPhone
------

To use TranslationKit on iPhone, simply include the MRTranslationOperation.[hm] files with your project. Be sure you also include the required JSON directory.
