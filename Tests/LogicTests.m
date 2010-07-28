//
//  LogicTests.m
//  TranslationKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "LogicTests.h"

@implementation LogicTests

- (void)setUp {
	queue = [[NSOperationQueue alloc] init];
}

- (void)testTranslation {
	MRTranslationOperation *op = [[MRTranslationOperation alloc] initWithSourceString:@"Buenos Dias!"
															  destinationLanguageCode:@"en"];
	
	STAssertNotNil(op, @"Cannot create the operation");
	
	op.delegate = self;
	
	[queue addOperation:op];
	[op release];
	
	while ([[queue operations] count]) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2f]];
	}
}

- (void)translationOperation:(MRTranslationOperation *)operation
	didFinishTranslatingText:(NSString *)result {
	
	NSLog(@"translation: %@", result);
	
	STAssertTrue([NSThread isMainThread], @"The delegate methods should be called on the main thread");
	STAssertNotNil(result, @"The translated text is invalid");
}

- (void)translationOperation:(MRTranslationOperation *)operation 
			didFailWithError:(NSError *)error {
	
	STAssertTrue([NSThread isMainThread], @"The delegate methods should be called on the main thread");
	STFail(@"Failed to translate the source string: %@", error);
}

- (void)tearDown {
	[queue release];
	queue = nil;
}

@end
