//
//  LogicTests.h
//  TranslationKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <TranslationKit/TranslationKit.h>

@interface LogicTests : SenTestCase < MRTranslationOperationDelegate > {
	NSOperationQueue *queue;
}

@end
