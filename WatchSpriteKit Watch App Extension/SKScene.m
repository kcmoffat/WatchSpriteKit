//
//  SKScene.m
//  Watchi
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKScene.h"
#import "SKView.h"
#import "SKScenePrivate.h"
#import "SKNodePrivate.h"
#import "SKSpriteNode.h"
#import "SKTexturePrivate.h"
#import "SKViewPrivate.h"

@import UIKit;

@interface SKScene()

@property (nonatomic) NSTimeInterval lastUpdate;
@property (nonatomic) BOOL firstUpdate;

@end

@implementation SKScene

#pragma mark Initialize a Scene
+ (instancetype)sceneWithSize:(CGSize)size
{
    return [[self alloc] initWithSize:size];
}

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super init]) {
        _size = size;
        _backgroundColor = [UIColor colorWithRed:.15 green:.15 blue:.15 alpha:1.0];
        
        _firstUpdate = YES;
    }
    return self;
}

#pragma mark Determining What Portion of the Scene Is Visible in the View

#pragma mark Presenting a Scene
- (void)willMoveFromView:(SKView *)view
{
    // Empty Implementation.  Override in subclasses.
}

- (void)didMoveToView:(SKView *)view;
{
    // Empty Implementation.  Override in subclasses.
}

#pragma mark Executing the Animation Loop
- (void)update:(NSTimeInterval)currentTime
{
    // Empty Implementation.  Override in subclasses.
}

- (void)didEvaluateActions
{
    // Empty Implementation.  Override in subclasses.
}

- (void)didFinishUpdate
{
    // Empty Implementation.  Override in subclasses.
}

#pragma mark Private Methods
-(void)executeAnimationLoop:(NSTimer *)timer;
{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    if (_firstUpdate) {
        _firstUpdate = NO;
        _lastUpdate = currentTime;
    }
    NSTimeInterval dt = currentTime - _lastUpdate;
    _lastUpdate = currentTime;
    
    [self update:currentTime];
    [self evaluateActions:dt];
    [self didEvaluateActions];
    [self didFinishUpdate];
    UIImage *image = [self render];
    [_view updateDisplayImage:image];
}

-(UIImage *)render
{
    /*
     Performance notes:
     -Normalizing CGImages to have same parameters as CGBitmapContext results in ~2x speedup
     -Changing Interpolation Quality to Low from Default results in ~3x speedup.
     -No noticeable difference between using CGLayer or CGImage for a single node (CGLayer should be faster due to GPU caching, may help with multiple nodes using same CGLayer in single drawing pass).
     -TODO: Try using Image I/O JPG compression instead of default PNG compression?
     */
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawBackgroundColor:_backgroundColor context:context];
    
    NSArray *flattenedNodeTree = [SKNode flattenTreeForRendering:self];
    for (SKNode *node in flattenedNodeTree) {
        
        if (node.absoluteHidden) continue; // true if node or any ancestor is hidden
        
        if ([node isKindOfClass:[SKSpriteNode class]]) {
            [self drawSpriteNode:(SKSpriteNode *)node context:context];
        }
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return image;
}

- (void)drawBackgroundColor:(UIColor *)backgroundColor context:(CGContextRef)context
{
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, (CGRect){CGPointZero, _size});
    
    CGContextRestoreGState(context);
}

- (void)drawSpriteNode:(SKSpriteNode *)node context:(CGContextRef)context
{
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, node.absolutePosition.x, node.absolutePosition.y);
    CGContextRotateCTM(context, node.absoluteZRotation);
    if (node.parent) CGContextScaleCTM(context, node.parent.absoluteXScale, node.parent.absoluteYScale);
    
    // node.size is already scaled by node.xScale and node.yScale 
    CGContextTranslateCTM(context, node.size.width*(-node.anchorPoint.x), node.size.height*(-node.anchorPoint.y));
    
    CGRect drawRect = CGRectMake(0, 0, node.size.width, node.size.height);
    
    if (node.texture && node.color) {
        // TODO implement color blend with texture.
        CGContextDrawLayerInRect(context, drawRect, node.texture.layer); // no color blending yet
        
    } else if (node.texture) {
        
        CGContextDrawLayerInRect(context, drawRect, node.texture.layer);
        
    } else if (node.color) {
        
        CGContextSetFillColorWithColor(context, node.color.CGColor);
        CGContextFillRect(context, drawRect);
    }
    
    CGContextRestoreGState(context);
}

@end