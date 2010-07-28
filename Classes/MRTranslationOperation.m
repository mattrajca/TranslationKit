//
//  MRTranslationOperation.m
//  TranslationKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRTranslationOperation.h"

#import "JSON.h"

@implementation MRTranslationOperation

#define kTranslateURLFormat @"http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=%@&langpair=%@%%7C%@"

@synthesize sourceLanguageCode, delegate;

- (id)init {
	return [self initWithSourceString:nil destinationLanguageCode:nil];
}

- (id)initWithSourceString:(NSString *)source destinationLanguageCode:(NSString *)code {
	NSParameterAssert(source != nil);
	NSParameterAssert(code != nil);
	
	self = [super init];
	if (self) {
		sourceString = [[source stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] retain];
		sourceLanguageCode = [@"" retain];
		destLanguageCode = [code copy];
	}
	return self;
}

- (void)failedWithError:(NSError *)error {
	if ([delegate respondsToSelector:@selector(translationOperation:didFailWithError:)]) {
		[delegate translationOperation:self
					  didFailWithError:[[error retain] autorelease]];
	}
}

- (void)finishedWithResponse:(NSString *)response {
	if ([delegate respondsToSelector:@selector(translationOperation:didFinishTranslatingText:)]) {
		[delegate translationOperation:self
			  didFinishTranslatingText:[[response retain] autorelease]];
	}
}

- (void)main {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *urlString = [NSString stringWithFormat:kTranslateURLFormat,
													 sourceString,
													 sourceLanguageCode,
													 destLanguageCode, nil];
	
	NSURL *url = [NSURL URLWithString:urlString];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setValue:@"www.mattrajca.com" forHTTPHeaderField:@"Referrer"];
	
	NSError *error = nil;
	
	NSData *data = [NSURLConnection sendSynchronousRequest:request
										 returningResponse:nil
													 error:&error];
	
	if (!data) {
		[self performSelectorOnMainThread:@selector(failedWithError:)
							   withObject:error
							waitUntilDone:NO];
		
		return;
	}
	
	NSString *dataString = [[NSString alloc] initWithData:data
												 encoding:NSASCIIStringEncoding];
	
	NSDictionary *response = [dataString JSONValue];
	[dataString release];
	
	int statusCode = [[response objectForKey:@"responseStatus"] intValue];
	
	if (!response || statusCode != 200) {
		NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
											 code:-1
										 userInfo:nil];
		
		[self performSelectorOnMainThread:@selector(failedWithError:)
							   withObject:error
							waitUntilDone:NO];
		
		return;
	}
	
	NSDictionary *responseData = [response objectForKey:@"responseData"];
	NSString *translatedText = [responseData objectForKey:@"translatedText"];
	
	[self performSelectorOnMainThread:@selector(finishedWithResponse:)
						   withObject:translatedText
						waitUntilDone:NO];
	
	[pool drain];
}

- (void)dealloc {
	[sourceString release];
	[destLanguageCode release];
	[sourceLanguageCode release];
	
	[super dealloc];
}

@end
