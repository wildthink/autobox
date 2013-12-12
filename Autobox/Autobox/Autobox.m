//
//  Autobox.m
//  Autobox
//
//  Created by Jobe,Jason on 12/10/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import "Autobox.h"


static Autobox *_sharedAutobox;

@implementation Autobox


+ (instancetype)sharedInstance;
{
    if (_sharedAutobox == nil) {
        _sharedAutobox = [[[self class] alloc  ]init];
    }
    return _sharedAutobox;
}

- init {
    self = [super init];
    return self;
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
