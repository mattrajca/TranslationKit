TranslationKit
==============

TranslationKit is a simple Cocoa framework that utilizes Google Translate to translate text.

Usage
-----

The framework itself consists of one class, `MRTranslationOperation`. As the name suggests, this class is a subclass of `NSOperation`. A list of language codes that Google Translate supports can be found [here](http://code.google.com/apis/ajaxlanguage/documentation/reference.html#LangNameArray).

Basic usage:

	MRTranslationOperation *op = [[MRTranslationOperation alloc] initWithSourceString:@"Buenos Dias!"
															  destinationLanguageCode:@"en"];
		
	op.delegate = self;
	
	[queue addOperation:op];
	[op release];

This code will translate the string "Buenos Dias!" to English. Don't forget to set the delegate to receive a callback method with the translated string.

Some applications may also want to convert a localized display name of a language to its corresponding language code. This can be done using the `NSLocale` class as shown below.

`[NSLocale canonicalLanguageIdentifierFromString:@"English"]; // this returns "en"`

The `MRTranslationOperation` class can also be used from within the context of a `NSThread`, if your application isn't using `NSOperationQueue`. This can be done by invoking the `main` method of an instance of `MRTranslationOperation` using `+ [NSThread detachNewThreadSelector:toTarget:withObject:]`

iPhone
------

To use TranslationKit on iPhone, simply include the MRTranslationOperation.h/.m files with your project. Be sure you also include the required JSON directory.
