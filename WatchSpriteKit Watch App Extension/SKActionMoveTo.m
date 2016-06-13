//
//  SKActionMove.m
//  Watchi
//
//  Created by KASEY MOFFAT on 3/31/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionMoveTo.h"
#import "SKActionPrivate.h"
#import "SKNode.h"

@interface SKActionMoveTo()

@property (nonatomic) CGPoint startPosition;

@property (nonatomic) CGFloat moveToX;
@property (nonatomic) CGFloat moveToY;
@property (nonatomic) BOOL shouldMoveX;
@property (nonatomic) BOOL shouldMoveY;

@end

@implementation SKActionMoveTo

#pragma mark Creating Actions That Move Nodes
+ (SKAction *)moveTo:(CGPoint)location
            duration:(NSTimeInterval)sec
{
    return [[self alloc] initWithDuration:sec moveToX:location.x moveToY:location.y shouldMoveX:YES shouldMoveY:YES];
}

+ (SKAction *)moveToX:(CGFloat)x
             duration:(NSTimeInterval)sec
{
    return [[self alloc] initWithDuration:sec moveToX:x moveToY:NAN shouldMoveX:YES shouldMoveY:NO];
}

+ (SKAction *)moveToY:(CGFloat)y
             duration:(NSTimeInterval)sec
{
    return [[self alloc] initWithDuration:sec moveToX:NAN moveToY:y shouldMoveX:NO shouldMoveY:YES];
}

#pragma mark Initialization
-(instancetype)initWithDuration:(NSTimeInterval)sec
                         moveToX:(CGFloat)moveToX
                        moveToY:(CGFloat)moveToY
                          shouldMoveX:(BOOL)shouldMoveX
                          shouldMoveY:(BOOL)shouldMoveY
{
    if (self = [super initWithDuration:sec]) {
        _moveToX = moveToX;
        _moveToY = moveToY;
        _shouldMoveX = shouldMoveX;
        _shouldMoveY = shouldMoveY;
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionMoveTo *copy = [[[self class] allocWithZone:zone] initWithDuration:self.duration moveToX:_moveToX moveToY:_moveToY shouldMoveX:_shouldMoveX shouldMoveY:_shouldMoveY];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)startWithTarget:(SKNode *)node
{
    [super startWithTarget:node];
    
    _startPosition = node.position;
}

-(void)update:(CGFloat)time
{
    CGFloat newX = _shouldMoveX ? _startPosition.x + time * (_moveToX - _startPosition.x) : _target.position.x;
    CGFloat newY = _shouldMoveY ? _startPosition.y + time * (_moveToY - _startPosition.y) : _target.position.y;
    
    _target.position = CGPointMake(newX, newY);
}

@end
