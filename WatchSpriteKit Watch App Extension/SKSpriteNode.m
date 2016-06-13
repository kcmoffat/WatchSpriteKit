//
//  SKSpriteNode.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/8/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKSpriteNode.h"

@implementation SKSpriteNode

#pragma mark Initializing a New Sprite
+ (instancetype)spriteNodeWithColor:(UIColor *)color
                               size:(CGSize)size
{
    return [[self alloc] initWithColor:color size:size];
}

+ (instancetype)spriteNodeWithImageNamed:(NSString *)name
{
    return [[self alloc] initWithImageNamed:name];
}

+ (instancetype)spriteNodeWithTexture:(SKTexture *)texture
{
    return [[self alloc] initWithTexture:texture];
}

- (instancetype)initWithColor:(UIColor *)color
                         size:(CGSize)size
{
    return [[[self class] alloc] initWithTexture:nil color:color size:size];
}

- (instancetype)initWithImageNamed:(NSString *)name
{
    SKTexture *texture = [SKTexture textureWithImageNamed:name];
    return [[[self class] alloc] initWithTexture:texture color:nil size:texture.size];
}

- (instancetype)initWithTexture:(SKTexture *)texture
{
    return [[[self class] alloc] initWithTexture:texture color:nil size:texture.size];
}

- (instancetype)initWithTexture:(SKTexture *)texture
                          color:(UIColor *)color
                           size:(CGSize)size
{
    if (self = [super init]) {
        _texture = texture;
        _color = color;
        _size = size;
        
        _anchorPoint = CGPointMake(0.5, 0.5);
    }
    return self;
}

-(CGSize)size
{
    return CGSizeMake(_size.width * self.xScale, _size.height * self.yScale);
}

@end
