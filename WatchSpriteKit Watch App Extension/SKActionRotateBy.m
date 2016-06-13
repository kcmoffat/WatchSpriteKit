//
//  SKActionRotateBy.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/13/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionRotateBy.h"
#import "SKActionPrivate.h"
#import "SKUtilities.h"
#import "SKNode.h"

@interface SKActionRotateBy()

@property (nonatomic) CGFloat rotateBy;

@property (nonatomic) CGFloat startZRotation;
@property (nonatomic) CGFloat previousZRotation;

@end

@implementation SKActionRotateBy

#pragma mark Creating Actions That Rotate Nodes
+ (SKAction *)rotateByAngle:(CGFloat)radians
                   duration:(NSTimeInterval)sec
{
    return [[self alloc] initWithDuration:sec rotateBy:radians];
}

#pragma mark Initialization
-(instancetype)initWithDuration:(NSTimeInterval)sec rotateBy:(CGFloat)radians
{
    if (self = [super initWithDuration:sec]) {
        _rotateBy = radians;
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionRotateBy *copy = [[[self class] allocWithZone:zone] initWithDuration:_duration rotateBy:_rotateBy];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

#pragma mark <SKActionSubclass>
-(void)startWithTarget:(SKNode *)node
{
    [super startWithTarget:node];
    _previousZRotation = _startZRotation = node.zRotation;
}

// based on https://github.com/cocos2d/cocos2d-objc/blob/v3.5.0/cocos2d/CCActionInterval.m#L758
-(void)update:(CGFloat)time
{
    if (self.target) {
        CGFloat currentZRotation = self.target.zRotation;
        CGFloat diff = currentZRotation - _previousZRotation;
        _startZRotation += diff;
        CGFloat newZRotation = _startZRotation + (_rotateBy * time);
        self.target.zRotation = newZRotation;
        _previousZRotation = newZRotation;
    }
}

@end
