//
//  SKActionMoveBy.m
//  Watchi
//
//  Created by KASEY MOFFAT on 4/5/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionMoveBy.h"
#import "SKActionPrivate.h"
#import "SKNode.h"

@interface SKActionMoveBy()

@property (nonatomic) CGVector moveBy;

@property (nonatomic) CGPoint startPosition;
@property (nonatomic) CGPoint previousPosition;

@end

@implementation SKActionMoveBy

#pragma mark Creating Actions That Move Nodes
+ (SKAction *)moveByX:(CGFloat)deltaX
                    y:(CGFloat)deltaY
             duration:(NSTimeInterval)sec
{
    return [self moveBy:CGVectorMake(deltaX, deltaY) duration:sec];
}

+ (SKAction *)moveBy:(CGVector)delta
            duration:(NSTimeInterval)sec
{
    return [[self alloc] initWithDuration:sec moveBy:delta];
}

#pragma mark Initialization
-(instancetype)initWithDuration:(NSTimeInterval)sec moveBy:(CGVector)delta
{
    if (self = [super initWithDuration:sec]) {
        _moveBy = delta;
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionMoveBy *copy = [[[self class] allocWithZone:zone] initWithDuration:self.duration moveBy:_moveBy];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)startWithTarget:(SKNode *)node
{
    [super startWithTarget:node];
    _previousPosition = _startPosition = node.position;
}

// based on https://github.com/cocos2d/cocos2d-objc/blob/v3.5.0/cocos2d/CCActionInterval.m#L758
-(void)update:(CGFloat)time
{
    if (_target) {
        CGPoint currentPos = _target.position;
        CGPoint diff = CGPointMake(currentPos.x-_previousPosition.x, currentPos.y-_previousPosition.y);
        _startPosition = CGPointMake(_startPosition.x+diff.x, _startPosition.y+diff.y);
        CGPoint newPos = CGPointMake(_startPosition.x + _moveBy.dx*time, _startPosition.y + _moveBy.dy*time);
        _target.position = newPos;
        _previousPosition = newPos;
    }
}

@end
