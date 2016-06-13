//
//  SKActionPrivate.h
//  Watchi
//
//  Created by KASEY MOFFAT on 3/31/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreGraphics;

@class SKNode;

@interface SKAction() <NSCopying> {
    @protected
    SKNode *_target;
    CGFloat _speed;
    SKActionTimingMode _timingMode;
    SKActionTimingFunction _timingFunction;
    NSTimeInterval _duration;
}

@property (nonatomic) void (^completion)(void);

@property (nonatomic) SKNode *target;

-(id)copyWithZone:(NSZone *)zone;

-(BOOL)isDone;

-(void)startWithTarget:(SKNode *)node;

-(void)stop;

-(void)step:(NSTimeInterval)dt;

-(void)update:(CGFloat)time;

-(CGFloat)adjustTime:(CGFloat)time; // call to apply timingMode and timingFunction transformations

@end
