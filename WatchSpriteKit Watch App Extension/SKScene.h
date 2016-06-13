//
//  SKScene.h
//  Watchi
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKNode.h"

@class SKView;

@interface SKScene : SKNode

#pragma mark Initialize a Scene
+ (instancetype)sceneWithSize:(CGSize)size;
- (instancetype)initWithSize:(CGSize)size;

#pragma mark Determining What Portion of the Scene Is Visible in the View
@property(nonatomic) CGSize size;

#pragma mark Setting the Background Color of a Scene
@property(nonatomic, retain) UIColor *backgroundColor;

#pragma mark Presenting a Scene
- (void)willMoveFromView:(SKView *)view;
- (void)didMoveToView:(SKView *)view;
@property(nonatomic, weak, readonly) SKView *view;

#pragma mark Executing the Animation Loop
- (void)update:(NSTimeInterval)currentTime;
- (void)didEvaluateActions;
- (void)didFinishUpdate;

@end
