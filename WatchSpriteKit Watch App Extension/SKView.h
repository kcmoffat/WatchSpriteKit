//
//  SKView.h
//  Watchi
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import "SKScene.h"

@interface SKView : NSObject

#pragma mark Initialization
- (instancetype)initWithWKInterfaceImage:(WKInterfaceImage *)image size:(CGSize)size;
- (instancetype)initWithWKInterfaceGroup:(WKInterfaceGroup *)group size:(CGSize)size;

#pragma mark Accessing WKInterfaceObject to which Scene is Drawn
@property(nonatomic, readonly) WKInterfaceImage *image;
@property(nonatomic, readonly) WKInterfaceGroup *group;

#pragma mark Presenting Scenes
- (void)presentScene:(SKScene *)scene;
@property(nonatomic, readonly) SKScene *scene;

#pragma mark Pausing the Scene’s Simulation
@property(nonatomic, getter=isPaused) BOOL paused;

#pragma mark Inspecting Properties
@property(nonatomic) CGFloat framesPerSecond;
@property (nonatomic, readonly) CGSize size;

@end
