//
//  Autobox.m
//  Autobox
//
//  Created by Jobe,Jason on 12/10/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import "Autobox.h"

/*
 void main(int argc, const char *argv[]) {
 // character literals.
 NSNumber *theLetterZ = @'Z';          // equivalent to [NSNumber numberWithChar:'Z']
 
 // integral literals.
 NSNumber *fortyTwo = @42;             // equivalent to [NSNumber numberWithInt:42]
 NSNumber *fortyTwoUnsigned = @42U;    // equivalent to [NSNumber numberWithUnsignedInt:42U]
 NSNumber *fortyTwoLong = @42L;        // equivalent to [NSNumber numberWithLong:42L]
 NSNumber *fortyTwoLongLong = @42LL;   // equivalent to [NSNumber numberWithLongLong:42LL]
 
 // floating point literals.
 NSNumber *piFloat = @3.141592654F;    // equivalent to [NSNumber numberWithFloat:3.141592654F]
 NSNumber *piDouble = @3.1415926535;   // equivalent to [NSNumber numberWithDouble:3.1415926535]
 
 // BOOL literals.
 NSNumber *yesNumber = @YES;           // equivalent to [NSNumber numberWithBool:YES]
 NSNumber *noNumber = @NO;             // equivalent to [NSNumber numberWithBool:NO]
 
 #ifdef __cplusplus
 NSNumber *trueNumber = @true;         // equivalent to [NSNumber numberWithBool:(BOOL)true]
 NSNumber *falseNumber = @false;       // equivalent to [NSNumber numberWithBool:(BOOL)false]
 #endif
 }
 */

@implementation Autobox

static Autobox *_sharedAutobox;

+ (instancetype)sharedInstance;
{
    if (_sharedAutobox == nil) {
        _sharedAutobox = [[self class] init];
    }
    return _sharedAutobox;
}

- valueWithRect:(NSRect)value {
    return [NSValue valueWithRect:value];
}

- valueWithSize:(NSSize)value {
    return [NSValue valueWithSize:value];
}

- valueWithPoint:(NSPoint)value {
    return [NSValue valueWithPoint:value];
}

- valueWithRange:(NSRange)value {
    return [NSValue valueWithRange:value];
}

- valueForObject:value {
    return (value ? value : [NSNull null]);
}

- valueWithInt:(int)value {
    return [NSNumber numberWithInt:value];
}

- valueWithUnsignedInt:(unsigned int)value {
    return [NSNumber numberWithUnsignedInt:value];
}

- valueWithInteger:(NSInteger)value {
    return [NSNumber numberWithInteger:value];
}

- valueWithLong:(long)value {
    return [NSNumber numberWithLong:value];
}

- valueWithLongLong:(long long)value {
    return [NSNumber numberWithLongLong:value];
}

- valueWithFloat:(float)value {
    return [NSNumber numberWithFloat:value];
}

- valueWithDouble:(double)value {
    return [NSNumber numberWithDouble:value];
}

@end
