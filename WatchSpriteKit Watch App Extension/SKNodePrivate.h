//
//  SKNodePrivate.h
//  Watchi
//
//  Created by KASEY MOFFAT on 4/5/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreGraphics;

@interface SKNode()

#pragma mark Initializing a New Node
-(instancetype)init;

-(void)evaluateActions:(NSTimeInterval)dt;

+(NSArray *)flattenTreeForRendering:(SKNode *)root;

@property (nonatomic) CGPoint absolutePosition;
@property (nonatomic) CGFloat absoluteZRotation;
@property (nonatomic) CGFloat absoluteXScale;
@property (nonatomic) CGFloat absoluteYScale;
@property (nonatomic) CGFloat absoluteZPosition;

@property (nonatomic) CGFloat absoluteHeight;
@property (nonatomic) CGFloat absoluteSiblingIndex;

@property (nonatomic) BOOL absoluteHidden;

/*
 Method for testing to control startTime of simulation.
*/
-(void)runAction:(SKAction *)action withKey:(NSString *)key startTime:(NSTimeInterval)startTime completion:(void (^)(void))block;

@end
