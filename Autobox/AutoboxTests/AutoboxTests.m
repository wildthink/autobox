//
//  AutoboxTests.m
//  AutoboxTests
//
//  Created by Jobe,Jason on 12/10/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Autobox.h"

typedef enum : unsigned char { Red, Green, Blue } Color;

overload id autobox (Color color) {
    return nil;
}

overload id autobox (unsigned char color) {
    return nil;
}

@interface AutoboxTests : XCTestCase

- (void)log:(NSString*)format, ... NS_FORMAT_FUNCTION(1, 2);

@end

@implementation AutoboxTests

- (void)log:(NSString*)format, ...
{
    va_list args;
    
    va_start (args, format);

    NSLogv(format, args);

    va_end (args);
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testNumbers
{
    XCTAssertEqualObjects(@(10), $(10), @"Not equal");
    XCTAssertEqualObjects(@(10U), $(10U), @"Not equal");
    XCTAssertEqualObjects(@(10L), $(10L), @"Not equal");
    XCTAssertEqualObjects(@(10.10), $(10.10), @"Not equal");
}

- (void)testEnums
{
    Color color = Red;
    id foo = autobox(color);
    [self log:@"Color is %@", foo];

    id bar = autobox ((unsigned char)color);
    [self log:@"Color is %@", bar];
}

@end
