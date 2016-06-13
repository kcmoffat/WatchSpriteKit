//
//  SKActionSequence.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/21/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionSequence.h"
#import "SKActionPrivate.h"

@interface SKActionSequence()

@property (nonatomic) NSArray <SKAction *> *actions;

@property (nonatomic) NSUInteger index;
@property (nonatomic) CGFloat nextSplit;

@end

@implementation SKActionSequence

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)sequence:(NSArray<SKAction *> *)actions
{
    return [[self alloc] initWithActions:actions];
}

-(instancetype)initWithActions:(NSArray<SKAction *> *)actions
{
    
    NSTimeInterval duration = 0.0;
    
    NSMutableArray *actionsCopy = [[NSMutableArray alloc] initWithCapacity:[_actions count]];
    
    for (SKAction *action in actions) {
        duration += action.duration;
        [actionsCopy addObject:[action copy]];
    }
    
    if (self = [super initWithDuration:duration]) {
        
        _actions = actionsCopy;
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionSequence *copy = [[[self class] allocWithZone:zone] initWithActions:_actions];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)startWithTarget:(SKNode *)node
{
    [super startWithTarget:node];
    
    _index = 0;
    
    _nextSplit = MIN(1.0,_actions[_index].duration / _duration); // ensure time >= nextRestart passes on last update
    
    [_actions[_index] startWithTarget:node];
}

/** Based on Cocos2D repeat method
 https://github.com/cocos2d/cocos2d-objc/blob/v3.5.0/cocos2d/CCActionInterval.m#L333
 */
-(void)update:(CGFloat)time
{
    if (time >= _nextSplit) {
        
        while (time >= _nextSplit && _index < [_actions count]) {
            
            [_actions[_index] update:[_actions[_index] adjustTime:1.0]];
            
            [_actions[_index] stop];
            _index++;
            
            if (_index < [_actions count]) {
                
                [_actions[_index] startWithTarget:_target];
                _nextSplit += _actions[_index].duration / _duration;
                _nextSplit = MIN(1.0, _nextSplit); // ensure time >= nextSplit passes on last update
            }
        }
        
        // Make sure end value is correct
        if (fabs(time - 1.0) < FLT_EPSILON && _index < [_actions count]) {
            
            [_actions[_index] update:[_actions[_index] adjustTime:1.0]];
            
            _index++;
        }
        
        // TODO exclude instant actions here
        if (_index == [_actions count]) {
            
            [_actions[_index-1] stop];
            
        } else {
            // TODO verify this is necessary and works correctly?
            // prevent jerking
            [_actions[_index] update:[_actions[_index] adjustTime:(time - (_nextSplit - _actions[_index].duration/_duration)) / (_actions[_index].duration/_duration)]];
        }
        
    } else {
        [_actions[_index] update:[_actions[_index] adjustTime:(time - (_nextSplit - _actions[_index].duration/_duration)) / (_actions[_index].duration/_duration)]];
    }
}

-(BOOL)isDone
{
    return _index == [_actions count];
}

-(void)stop
{
    for (SKAction *action in _actions) {
        [action stop];
    }
    
    [super stop];
}

@end
