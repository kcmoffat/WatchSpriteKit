//
//  SKActionGroup.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/22/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionGroup.h"
#import "SKActionPrivate.h"

@interface SKActionGroup()

@property (nonatomic) NSArray <SKAction *> *actions;

@end

@implementation SKActionGroup

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)group:(NSArray<SKAction *> *)actions
{
    return [[self alloc] initWithActions:actions];
}

-(instancetype)initWithActions:(NSArray<SKAction *> *)actions
{
    NSTimeInterval maxDuration = 0.0;
    NSMutableArray *actionsCopy = [[NSMutableArray alloc] init];
    
    for (SKAction *action in actions) {
        if (action.duration > maxDuration) {
            maxDuration = action.duration;
        }
        [actionsCopy addObject:[action copy]];
    }
    
    if (self = [super initWithDuration:maxDuration]) {
        
        _actions = actionsCopy;
        
    }
    
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionGroup *copy = [[[self class] allocWithZone:zone] initWithActions:_actions];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)startWithTarget:(SKNode *)node
{
    [super startWithTarget:node];
    for (SKAction *action in _actions) {
        [action startWithTarget:node];
    }
}

-(void)update:(CGFloat)time
{
    for (SKAction *action in _actions) {
        
        if (![action isDone]) {
            [action update:[action adjustTime:time]];
            
            if ([action isDone]) {
                [action stop];
            }
        }
    }
}

-(void)stop
{
    for (SKAction *action in _actions) {
        [action stop];
    }
    
    [super stop];
}


@end
