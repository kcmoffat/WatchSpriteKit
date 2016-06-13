//
//  SKActionWait.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/22/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionWait.h"
#import "SKActionPrivate.h"

@implementation SKActionWait

#pragma mark Creating an Action to Introduce a Delay into a Sequence
+ (SKAction *)waitForDuration:(NSTimeInterval)sec
{
    return [[[self class] alloc] initWithDuration:sec];
}

+ (SKAction *)waitForDuration:(NSTimeInterval)sec
                    withRange:(NSTimeInterval)durationRange
{
    // TODO generate random duration
    return [[[self class] alloc] initWithDuration:durationRange];
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionWait *copy = [[[self class] allocWithZone:zone] initWithDuration:_duration];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)update:(CGFloat)time
{
    // No update actions necessary
}

@end
