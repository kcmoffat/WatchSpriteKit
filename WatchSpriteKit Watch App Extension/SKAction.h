//
//  SKAction.h
//  Watchi
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreGraphics;

@class SKTexture;

typedef float (^SKActionTimingFunction)(float time);

typedef NS_ENUM(NSInteger, SKActionTimingMode) {
    SKActionTimingLinear,
    SKActionTimingEaseIn,
    SKActionTimingEaseOut,
    SKActionTimingEaseInEaseOut,
};

@interface SKAction : NSObject <NSCopying>

#pragma mark Creating Actions That Move Nodes
+ (SKAction *)moveByX:(CGFloat)deltaX
                    y:(CGFloat)deltaY
             duration:(NSTimeInterval)sec;

+ (SKAction *)moveBy:(CGVector)delta
            duration:(NSTimeInterval)sec;

+ (SKAction *)moveTo:(CGPoint)location
            duration:(NSTimeInterval)sec;

+ (SKAction *)moveToX:(CGFloat)x
             duration:(NSTimeInterval)sec;

+ (SKAction *)moveToY:(CGFloat)y
             duration:(NSTimeInterval)sec;

#pragma mark Creating Actions That Rotate Nodes
+ (SKAction *)rotateByAngle:(CGFloat)radians
                   duration:(NSTimeInterval)sec;

+ (SKAction *)rotateToAngle:(CGFloat)radians
                   duration:(NSTimeInterval)sec;

+ (SKAction *)rotateToAngle:(CGFloat)radians
                   duration:(NSTimeInterval)sec
            shortestUnitArc:(BOOL)shortestUnitArc;

#pragma mark Creating Actions That Change a Node’s Scale
+ (SKAction *)scaleBy:(CGFloat)scale
             duration:(NSTimeInterval)sec;

+ (SKAction *)scaleTo:(CGFloat)scale
             duration:(NSTimeInterval)sec;

+ (SKAction *)scaleXBy:(CGFloat)xScale
                     y:(CGFloat)yScale
              duration:(NSTimeInterval)sec;

+ (SKAction *)scaleXTo:(CGFloat)xScale
                     y:(CGFloat)yScale
              duration:(NSTimeInterval)sec;

+ (SKAction *)scaleXTo:(CGFloat)scale
              duration:(NSTimeInterval)sec;

+ (SKAction *)scaleYTo:(CGFloat)scale
              duration:(NSTimeInterval)sec;

#pragma mark Removing Nodes from the Scene
+ (SKAction *)removeFromParent;

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)group:(NSArray<SKAction *> *)actions;

+ (SKAction *)sequence:(NSArray<SKAction *> *)actions;

+ (SKAction *)repeatAction:(SKAction *)action
                     count:(NSUInteger)count;

+ (SKAction *)repeatActionForever:(SKAction *)action;

#pragma mark Creating an Action to Introduce a Delay into a Sequence
+ (SKAction *)waitForDuration:(NSTimeInterval)sec;
+ (SKAction *)waitForDuration:(NSTimeInterval)sec
                    withRange:(NSTimeInterval)durationRange;


#pragma mark Creating Custom Actions
+ (SKAction *)runBlock:(dispatch_block_t)block;
+ (SKAction *)runBlock:(dispatch_block_t)block
                 queue:(dispatch_queue_t)queue;

#pragma mark Creating Actions That Change a Sprite Node’s Content
+ (SKAction *)setTexture:(SKTexture *)texture;
+ (SKAction *)setTexture:(SKTexture *)texture
                  resize:(BOOL)resize;

#pragma mark Inspecting an Action's Animation Properties
@property(nonatomic) CGFloat speed;
@property(nonatomic) SKActionTimingMode timingMode;
@property(nonatomic) SKActionTimingFunction timingFunction;
@property(nonatomic) NSTimeInterval duration;

@end
