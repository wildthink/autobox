//
//  Autobox.h
//  Autobox
//
//  Created by Jobe,Jason on 12/10/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Autobox : NSObject

+ (instancetype)sharedInstance;

- valueWithRect:(NSRect)value;
- valueWithSize:(NSSize)value;
- valueWithPoint:(NSPoint)value;
- valueWithRange:(NSRange)value;

- valueForObject:value;

- valueWithInt:(int)value;
- valueWithInteger:(NSInteger)value;
- valueWithUnsignedInt:(unsigned int)value;

- valueWithLong:(long)value;
- valueWithLongLong:(long long)value;
- valueWithFloat:(float)value;
- valueWithDouble:(double)value;

@end


#define overload static inline __attribute__((overloadable))
#define $(...) autobox (__VA_ARGS__)

overload id autobox(NSRect val) {
    return [[Autobox sharedInstance] valueWithRect:val];
}
overload id autobox(NSSize val) {
    return [[Autobox sharedInstance] valueWithSize:val];
}
overload id autobox(NSPoint val) {
    return [[Autobox sharedInstance] valueWithPoint:val];
}

overload id autobox(int val) {
    return [[Autobox sharedInstance] valueWithInt:val];
}

overload id autobox(unsigned int val) {
    return [[Autobox sharedInstance] valueWithUnsignedInt:val];
}

overload id autobox(NSInteger val) {
    return [[Autobox sharedInstance] valueWithInteger:val];
}

overload id autobox(long long val) {
    return [[Autobox sharedInstance] valueWithLongLong:val];
}

overload id autobox(float val) {
    return [[Autobox sharedInstance] valueWithFloat:val];
}
overload id autobox(double val) {
    return [[Autobox sharedInstance] valueWithDouble:val];
}

overload id autobox(id val) {
    return [[Autobox sharedInstance] valueForObject:val];
}
