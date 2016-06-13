//
//  SKActionSetTexture.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/22/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionSetTexture.h"
#import "SKActionPrivate.h"
#import "SKSpriteNode.h"

@interface SKActionSetTexture()

@property (nonatomic) SKTexture *texture;
@property (nonatomic) BOOL resize;

@end

@implementation SKActionSetTexture

#pragma mark Creating Actions That Change a Sprite Node’s Content
+ (SKAction *)setTexture:(SKTexture *)texture
{
    return [[self alloc] initWithTexture:texture resize:NO];
}

+ (SKAction *)setTexture:(SKTexture *)texture
                  resize:(BOOL)resize
{
    return [[self alloc] initWithTexture:texture resize:resize];
}

-(instancetype)initWithTexture:(SKTexture *)texture
                        resize:(BOOL)resize
{
    if (self = [super init]) {
        _texture = texture;
        _resize = resize;
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionSetTexture *copy = [[[self class] alloc] initWithTexture:_texture resize:_resize];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)update:(CGFloat)time
{
    if (![_target isKindOfClass:[SKSpriteNode class]]) {
        [NSException raise:@"SKActionInvalidTargetNode" format:@"Attempted to set the texture of a node that isn't a sprite node"];
    }
    
    ((SKSpriteNode *)_target).texture = _texture;
    if (_resize) ((SKSpriteNode *)_target).size = _texture.size;
    
    self.complete = YES;
}

@end
