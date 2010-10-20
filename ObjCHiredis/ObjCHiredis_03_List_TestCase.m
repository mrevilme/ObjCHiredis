//
//  ObjCHiredis_03_List_TestCase.m
//  ObjCHiredis
//
//  Created by Louis-Philippe on 10-10-20.
//  Copyright 2010 Modul. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <Foundation/Foundation.h>

#ifdef IOS
#import "ObjCHiredis.h"
#endif

#ifndef IOS
#import "ObjCHiredis/ObjCHiredis.h"
#endif

@interface ObjCHiredis_03_List_TestCase : SenTestCase {
	ObjCHiredis * redis;
}

@end

@implementation ObjCHiredis_03_List_TestCase

- (void)setUp {
	redis = [ObjCHiredis redis];
	[redis retain];
}

- (void)tearDown {
	[redis command:@"FLUSHALL"];
	[redis release];
}

- (void)test_11_List {
	STAssertTrue([[redis command:@"RPUSH BASKET APPLE"] isKindOfClass:[NSNumber class]], @"Couldn't RPUSH, got %@", [redis command:@"RPUSH BASKET APPLE"]);
	STAssertTrue([[redis command:@"RPOP BASKET"] isKindOfClass:[NSString class]], @"Couldn't RPOP, got %@", [redis command:@"RPOP BASKET"]);
	[redis command:@"RPUSH BASKET BANANA"];
	STAssertTrue([[redis command:@"RPOP BASKET"] isEqualToString:@"BANANA"], @"Couldn't RPOP, got %@", [redis command:@"RPOP BASKET"]);
	[redis command:@"RPUSH BASKET PRUNE"];
	[redis command:@"RPUSH BASKET TOMATO"];
	[redis command:@"RPUSH BASKET ZUCHINI"];
	STAssertTrue([[redis command:@"LRANGE BASKET 0 1"] isKindOfClass:[NSArray class]], @"Couldn't LRANGE, got %@", [redis command:@"LRANGE BASKET 0 1"]);
	STAssertTrue([[redis command:@"LRANGE BASKET 0 1"] count] == 2 , @"Couldn't LRANGE length, got %d", [[redis command:@"LRANGE BASKET 0 1"] count]);
}

@end