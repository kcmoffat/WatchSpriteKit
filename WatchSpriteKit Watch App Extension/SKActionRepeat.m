//
//  SKActionRepeat.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/14/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionRepeat.h"
#import "SKActionPrivate.h"
#import <tgmath.h>


@interface SKActionRepeat()

@property (nonatomic) SKAction *action;
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger currentCount;

@property (nonatomic) CGFloat nextRestart;

@end

@implementation SKActionRepeat

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)repeatAction:(SKAction *)action
                     count:(NSUInteger)count
{
    return [[self alloc] initWithAction:action count:count];
}

#pragma mark Initialization
-(instancetype)initWithAction:(SKAction*)action count:(NSUInteger)count
{
    if (self = [super initWithDuration:action.duration*count]) {
        _action = [action copy];
        _count = count;
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionRepeat *copy = [[[self class] allocWithZone:zone] initWithAction:_action count:_count];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)startWithTarget:(SKNode *)node
{
    [super startWithTarget:node];
    
    _currentCount = 0;
    _nextRestart = MIN(1.0, _action.duration / self.duration); // ensure time >= nextRestart passes on last update
    
    [_action startWithTarget:self.target];
}

/** Based on Cocos2D repeat method
 https://github.com/cocos2d/cocos2d-objc/blob/v3.5.0/cocos2d/CCActionInterval.m#L333
*/
-(void)update:(CGFloat)time
{
    if (time >= _nextRestart) {
        
        while (time >= _nextRestart && _currentCount < _count) {
            
            [_action update:[_action adjustTime:1.0]];
            
            _currentCount++;
            [_action stop];
            
            [_action startWithTarget:self.target];
            _nextRestart += _action.duration / self.duration;
            _nextRestart = MIN(1.0, _nextRestart); // ensure time >= nextRestart passes on last update
            
        }
        
        // Make sure end value is correct
        if (fabs(time - 1.0) < FLT_EPSILON && _currentCount < _count) {
            
            [_action update:[_action adjustTime:1.0]];
            
            _currentCount++;
        }
        // TODO exclude instant actions here
        if (_currentCount == _count) {
            
            [_action stop];
            
        } else {
            // to prevent jerk
            [_action update:[_action adjustTime:time - (_nextRestart - _action.duration/self.duration)]];
        }
        
    } else {
        [_action update:[_action adjustTime:fmod(time * _count, 1.0)]];
    }
}

-(BOOL)isDone
{
    return _currentCount == _count;
}

-(void)stop
{
    [_action stop];
    [super stop];
}

@end
