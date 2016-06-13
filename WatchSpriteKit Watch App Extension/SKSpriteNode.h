//
//  SKSpriteNode.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/8/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKNode.h"
#import "SKTexture.h"

@interface SKSpriteNode : SKNode

#pragma mark Initializing a New Sprite
- (instancetype)initWithColor:(UIColor *)color
                         size:(CGSize)size;
- (instancetype)initWithImageNamed:(NSString *)name;
- (instancetype)initWithTexture:(SKTexture *)texture;
- (instancetype)initWithTexture:(SKTexture *)texture
                          color:(UIColor *)color
                           size:(CGSize)size;

+ (instancetype)spriteNodeWithColor:(UIColor *)color
                               size:(CGSize)size;
+ (instancetype)spriteNodeWithImageNamed:(NSString *)name;
+ (instancetype)spriteNodeWithTexture:(SKTexture *)texture;


#pragma mark Inspecting Physical Properties
@property(nonatomic) CGSize size;
@property(nonatomic) CGPoint anchorPoint;

#pragma mark Inspecting the Sprite's Texture
@property(nonatomic, retain) SKTexture *texture;
@property(nonatomic, retain) UIImage *image;

#pragma mark Inspecting Color Properties
@property(nonatomic, retain) UIColor *color;

@end
