//
//  SKNode.h
//  Watchi
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SKAction.h"

@class SKScene;

@interface SKNode : NSObject

#pragma mark Creating a New Node
+ (instancetype)node;

#pragma mark Inspecting the Node's Position
@property (nonatomic) CGPoint position;
@property (nonatomic) CGFloat zPosition;

#pragma mark Setting a Node's Scaling and Rotation
- (void)setScale:(CGFloat)scale;
@property(nonatomic) CGFloat xScale;
@property(nonatomic) CGFloat yScale;
@property(nonatomic) CGFloat zRotation;

#pragma mark Inspecting a Node's Visibility
@property(nonatomic, getter=isHidden) BOOL hidden;

#pragma mark Working with Node Trees
- (void)addChild:(SKNode *)node;
- (void)insertChild:(SKNode *)node
            atIndex:(NSInteger)index;
- (BOOL)isEqualToNode:(SKNode *)node;
- (void)moveToParent:(SKNode *)parent;
- (void)removeFromParent;
- (void)removeAllChildren;
- (void)removeChildrenInArray:(NSArray<SKNode *> *)nodes;
- (BOOL)inParentHierarchy:(SKNode *)parent;
@property(nonatomic, readonly) NSArray <SKNode *> *children;
@property(nonatomic, readonly) SKNode *parent;
@property(nonatomic, readonly) SKScene *scene;

#pragma mark Naming Nodes
- (SKNode *)childNodeWithName:(NSString *)name;
@property(nonatomic, copy) NSString *name;

#pragma mark Running Actions
- (void)runAction:(SKAction *)action;
- (void)runAction:(SKAction *)action
       completion:(void (^)(void))block;
- (void)runAction:(SKAction *)action
          withKey:(NSString *)key;
- (SKAction *)actionForKey:(NSString *)key;
- (BOOL)hasActions;
- (void)removeAllActions;
- (void)removeActionForKey:(NSString *)key;
@property(nonatomic) CGFloat speed;
@property(nonatomic, getter=isPaused) BOOL paused;

@end
