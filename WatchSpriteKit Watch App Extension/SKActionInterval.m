//
//  SKActionInterval.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/20/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInterval.h"
#import "SKActionPrivate.h"
#import <tgmath.h>

@interface SKActionInterval()

@property (nonatomic) BOOL firstTick;

@end

@implementation SKActionInterval

#pragma mark Initialization
-(instancetype)initWithDuration:(NSTimeInterval)sec
{
    if (self = [super init]) {
        
        _duration = sec;
        
        _elapsed = 0.0;
        _firstTick = YES;
        
        if (_duration == 0) _duration = FLT_EPSILON; // prevent division by 0
        
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKAction *copy = [[[self class] allocWithZone:zone] initWithDuration:_duration];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)startWithTarget:(SKNode *)node
{
    [super startWithTarget:node];
    _firstTick = YES;
    _elapsed = 0.0;
}

-(void)step:(NSTimeInterval)dt
{
    if (_firstTick) {
        _firstTick = NO;
        _elapsed = 0.0;
    } else {
        _elapsed += dt;
    }
    
    CGFloat updateTime = MAX(0, MIN(1, _elapsed / MAX(_duration, FLT_EPSILON)));
    
    [self update:[self adjustTime:updateTime]];
}

-(BOOL)isDone
{
    return _elapsed >= _duration;
}

@end