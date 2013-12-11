//
//  AutoboxTests.m
//  AutoboxTests
//
//  Created by Jobe,Jason on 12/10/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import <XCTest/XCTest.h>

#define overload __attribute__((overloadable))

typedef enum : unsigned char { Red, Green, Blue } Color;

id static inline foo () {
    return nil;
}

overload id box (Color color) {
    return nil;
}

overload id box (unsigned char color) {
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
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    id foo; = Nil;
//    id bar = @(nil);
    const char *str = @encode(typeof (Red));
    [self log:@"Enum is %s", str];
    
    Color color = Red;
    id foo = box(color);
    [self log:@"Color is %@", foo];

    id bar = box ((unsigned char)color);
    [self log:@"Color is %@", bar];
}

@end
