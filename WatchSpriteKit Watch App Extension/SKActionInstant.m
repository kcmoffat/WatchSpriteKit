//
//  SKActionInstant.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/20/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInstant.h"
#import "SKActionPrivate.h"

@implementation SKActionInstant

-(instancetype)init
{
    if (self = [super init]) {
        _duration = 0;
        _complete = NO;
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionInstant *copy = [[[self class] alloc] init];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)startWithTarget:(SKNode *)node
{
    [super startWithTarget:node];
    _complete = NO;
}

-(void)step:(NSTimeInterval)dt
{
    [self update:1];
}

-(BOOL)isDone
{
    return _complete;
}

@end
