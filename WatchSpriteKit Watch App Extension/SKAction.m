//
//  SKAction.m
//  Watchi
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKAction.h"
#import "SKActionPrivate.h"
#import "SKActionMoveTo.h"
#import "SKActionMoveBy.h"
#import "SKActionRotateBy.h"
#import "SKActionRepeat.h"
#import "SKActionRepeatForever.h"
#import "SKActionSequence.h"
#import "SKActionGroup.h"
#import "SKActionWait.h"
#import "SKActionRunBlock.h"
#import "SKActionSetTexture.h"
#import "SKActionRemoveFromParent.h"

#import <tgmath.h>

@interface SKAction()

@property (nonatomic) NSTimeInterval elapsed;
@property (nonatomic) BOOL firstTick;

@end

@implementation SKAction

#pragma mark Initialization
-(instancetype)init
{
    if (self = [super init]) {
        
        _target = nil;
        
        _duration = FLT_EPSILON; // prevent division by zero 
        _speed = 1.0;
        _timingMode = SKActionTimingLinear;
        _timingFunction = nil;
        
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKAction *copy = [[[self class] allocWithZone:zone] init];
    copy.duration = _duration;
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)startWithTarget:(SKNode *)node
{
    _target = node;
}

-(void)stop
{
    _target = nil;
}

-(BOOL)isDone
{
    return YES;
}

-(void)step:(NSTimeInterval)dt
{
    NSLog(@"[SKAction step]. override me");
}

-(void)update:(CGFloat)time
{
    NSLog(@"[SKAction update]. override me");
}

#pragma mark Creating Actions That Move Nodes
+ (SKAction *)moveByX:(CGFloat)deltaX
                    y:(CGFloat)deltaY
             duration:(NSTimeInterval)sec
{
    return [SKActionMoveBy moveByX:deltaX y:deltaY duration:sec];
}

+ (SKAction *)moveBy:(CGVector)delta
            duration:(NSTimeInterval)sec
{
    return [SKActionMoveBy moveBy:delta duration:sec];
}

+ (SKAction *)moveTo:(CGPoint)location
            duration:(NSTimeInterval)sec
{
    return [SKActionMoveTo moveTo:location duration:sec];
}

+ (SKAction *)moveToX:(CGFloat)x
             duration:(NSTimeInterval)sec
{
    return [SKActionMoveTo moveToX:x duration:sec];
}

+ (SKAction *)moveToY:(CGFloat)y
             duration:(NSTimeInterval)sec
{
    return [SKActionMoveTo moveToY:y duration:sec];
}

#pragma mark Creating Actions That Rotate Nodes
+ (SKAction *)rotateByAngle:(CGFloat)radians
                   duration:(NSTimeInterval)sec
{
    return [SKActionRotateBy rotateByAngle:radians duration:sec];
}

+ (SKAction *)rotateToAngle:(CGFloat)radians
                   duration:(NSTimeInterval)sec
{
    return nil;
}

+ (SKAction *)rotateToAngle:(CGFloat)radians
                   duration:(NSTimeInterval)sec
            shortestUnitArc:(BOOL)shortestUnitArc
{
    return nil;
}

#pragma mark Creating Actions That Change a Node’s Scale
+ (SKAction *)scaleBy:(CGFloat)scale
             duration:(NSTimeInterval)sec
{
    return nil;
}

+ (SKAction *)scaleTo:(CGFloat)scale
             duration:(NSTimeInterval)sec
{
    return nil;
}

+ (SKAction *)scaleXBy:(CGFloat)xScale
                     y:(CGFloat)yScale
              duration:(NSTimeInterval)sec
{
    return nil;
}

+ (SKAction *)scaleXTo:(CGFloat)xScale
                     y:(CGFloat)yScale
              duration:(NSTimeInterval)sec
{
    return nil;
}

+ (SKAction *)scaleXTo:(CGFloat)scale
              duration:(NSTimeInterval)sec
{
    return nil;
}

+ (SKAction *)scaleYTo:(CGFloat)scale
              duration:(NSTimeInterval)sec
{
    return nil;
}

#pragma mark Removing Nodes from the Scene
+ (SKAction *)removeFromParent
{
    return [SKActionRemoveFromParent removeFromParent];
}

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)group:(NSArray<SKAction *> *)actions
{
    return [SKActionGroup group:actions];
}

+ (SKAction *)sequence:(NSArray<SKAction *> *)actions
{
    return [SKActionSequence sequence:actions];
}

+ (SKAction *)repeatAction:(SKAction *)action
                     count:(NSUInteger)count
{
    return [SKActionRepeat repeatAction:action count:count];
}

+ (SKAction *)repeatActionForever:(SKAction *)action
{
    return [SKActionRepeatForever repeatActionForever:action];
}

#pragma mark Creating an Action to Introduce a Delay into a Sequence
+ (SKAction *)waitForDuration:(NSTimeInterval)sec
{
    return [SKActionWait waitForDuration:sec];
}

+ (SKAction *)waitForDuration:(NSTimeInterval)sec
                    withRange:(NSTimeInterval)durationRange
{
    return [SKActionWait waitForDuration:sec
                               withRange:durationRange];
}

#pragma mark Creating Custom Actions
+ (SKAction *)runBlock:(dispatch_block_t)block
{
    return [SKActionRunBlock runBlock:block];
}

+ (SKAction *)runBlock:(dispatch_block_t)block
                 queue:(dispatch_queue_t)queue
{
    return [SKActionRunBlock runBlock:block queue:queue];
}

#pragma mark Creating Actions That Change a Sprite Node’s Content
+ (SKAction *)setTexture:(SKTexture *)texture
{
    return [SKActionSetTexture setTexture:texture];
}

+ (SKAction *)setTexture:(SKTexture *)texture
                  resize:(BOOL)resize
{
    return [SKActionSetTexture setTexture:texture resize:resize];
}


// TODO move to SKActionFiniteTime
#pragma mark Adjusting Update Time with Timing Mode/Timing Function
-(CGFloat)adjustTime:(CGFloat)time
{
    CGFloat adjustedTime = [self adjustTime:time timingMode:_timingMode];
    adjustedTime = _timingFunction ? _timingFunction(adjustedTime) : adjustedTime;
    
    return adjustedTime;
}

-(CGFloat)adjustTime:(CGFloat)time timingMode:(SKActionTimingMode)timingMode
{
    switch (timingMode) {
        case SKActionTimingLinear:
            return actionTimingFunctionLinear(time);
            break;
        case SKActionTimingEaseIn:
            return actionTimingFunctionEaseIn(time);
            break;
        case SKActionTimingEaseOut:
            return actionTimingFunctionEaseOut(time);
            break;
        case SKActionTimingEaseInEaseOut:
            return actionTimingFunctionEaseInEaseOut(time);
            break;
        default:
            return time;
            break;
    }
}

CGFloat actionTimingFunctionLinear(CGFloat time)
{
    return time;
}

// TODO replace with cubic Bezier curves https://developer.apple.com/library/mac/documentation/Cocoa/Reference/CAMediaTimingFunction_class/#//apple_ref/occ/instm/CAMediaTimingFunction/initWithControlPoints::::
// Based on cubic functions in https://github.com/warrenm/AHEasing/blob/master/AHEasing/easing.c
CGFloat actionTimingFunctionEaseIn(CGFloat time)
{
    return pow(time, 3.0);
}

CGFloat actionTimingFunctionEaseOut(CGFloat time)
{
    return pow(time-1, 3.0) + 1.0;
}

CGFloat actionTimingFunctionEaseInEaseOut(CGFloat time)
{
    // TODO: implement
    return time;
}

@end
