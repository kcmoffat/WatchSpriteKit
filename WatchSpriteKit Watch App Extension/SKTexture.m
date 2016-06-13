//
//  SKTexture.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/12/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKTexture.h"
#import "SKTexturePrivate.h"
#import "SKUtilities.h"

@implementation SKTexture

#pragma mark Creating New Textures from Images
+ (instancetype)textureWithImageNamed:(NSString *)name
{
    return [[self alloc] initWithCGImage:[UIImage imageNamed:name].CGImage];
}

+ (instancetype)textureWithImage:(UIImage *)image
{
    return [[self alloc] initWithCGImage:image.CGImage];
}

+ (instancetype)textureWithCGImage:(CGImageRef)image
{
    return [[self alloc] initWithCGImage:image];
}

- (instancetype)initWithCGImage:(CGImageRef)image
{
    if (self = [super init]) {
        [self setCGLayerWithCGImage:image];
    }
    return self;
}

- (CGImageRef)CGImage
{
    // TODO implement
    return nil;
}

-(CGSize)size
{
    return CGLayerGetSize(_layer);
}

#pragma mark Private Methods
- (void)setCGLayerWithCGImage:(CGImageRef)image
{
    // normalize and write to layer
    CGFloat screenScale = [SKUtilities screenScale];
    CGSize imageSize = CGSizeMake(CGImageGetWidth(image) / screenScale, CGImageGetHeight(image) / screenScale);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t byteAlignment = 16;
    size_t bytesPerRow = CGImageGetBytesPerRow(image);
    bytesPerRow = bytesPerRow + byteAlignment - bytesPerRow % byteAlignment;
    CGContextRef context = CGBitmapContextCreate(NULL, imageSize.width, imageSize.height, CGImageGetBitsPerComponent(image), bytesPerRow, colorSpace, kCGBitmapByteOrder32Host | kCGImageAlphaPremultipliedFirst);
    
    CGColorSpaceRelease(colorSpace);
    CGRect destinationRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    _layer = CGLayerCreateWithContext(context, destinationRect.size, NULL);
    CGContextRelease(context);
    
    CGContextRef layerContext = CGLayerGetContext(_layer);
    CGContextDrawImage(layerContext, destinationRect, image);
}

@end
