//
//  SKActionRepeatForever.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/21/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionRepeatForever.h"
#import "SKActionPrivate.h"
#import "SKActionInterval.h"

@interface SKActionRepeatForever()

@property (nonatomic) SKAction *action;

@end

@implementation SKActionRepeatForever

// TODO enforce repeat forever to only have finite time actions

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)repeatActionForever:(SKAction *)action
{
    return [[self alloc] initWithAction:action];
}

-(instancetype)initWithAction:(SKAction *)action
{
    if (![action isKindOfClass:[SKActionInterval class]]) {
        [NSException raise:@"SKActionCantRepeatInstantActionForever" format:@"Only non-instantaneous actions can be repeated forever"];
    }
    
    if (self = [super init]) {
        _action = [action copy];
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKAction *copy = [[[self class] allocWithZone:zone] initWithAction:_action];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)startWithTarget:(SKNode *)node
{
    [super startWithTarget:node];
    [_action startWithTarget:node];
}

-(void)step:(NSTimeInterval)dt
{
    [_action step:dt];
    
    if ([_action isDone]) {
        NSTimeInterval diff = ((SKActionInterval *)_action).elapsed - _action.duration;
        [_action startWithTarget:self.target];
        
        // to prevent jerk
        [_action step:0.0];
        [_action step:diff];
    }
}

-(BOOL)isDone
{
    return NO;
}

-(void)update:(CGFloat)time
{
    // Empty implementation
}
@end
