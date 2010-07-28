//
//  MRTranslationOperation.h
//  TranslationKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 Language codes refer to ISO language codes
 
 See http://code.google.com/apis/ajaxlanguage/documentation/reference.html#LangNameArray
 for a list of supported languages
 
 To convert the localized name of a language to its corresponding language code use:
 
 + [NSLocale canonicalLanguageIdentifierFromString:]
 
 for example calling:
 
   [NSLocale canonicalLanguageIdentifierFromString:@"English"]
 
 would return "en"
 
*/

@protocol MRTranslationOperationDelegate;

@interface MRTranslationOperation : NSOperation {
  @private
	NSString *sourceString;
	NSString *destLanguageCode;
	NSString *sourceLanguageCode;
	id < MRTranslationOperationDelegate > delegate;
}

// If not specified, the language of the source string will be detected automatically
@property (nonatomic, copy) NSString *sourceLanguageCode;

// All delegate methods are called back on the main thread
@property (nonatomic, assign) id < MRTranslationOperationDelegate > delegate;

/* The source string and destination language code must not be nil */
- (id)initWithSourceString:(NSString *)source destinationLanguageCode:(NSString *)code;

@end


@protocol MRTranslationOperationDelegate < NSObject >

- (void)translationOperation:(MRTranslationOperation *)operation didFinishTranslatingText:(NSString *)result;

@optional
- (void)translationOperation:(MRTranslationOperation *)operation didFailWithError:(NSError *)error;

@end
