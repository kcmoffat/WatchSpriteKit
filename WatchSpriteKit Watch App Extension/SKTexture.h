//
//  SKTexture.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/12/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKTexture : NSObject

#pragma mark Creating New Textures from Images
+ (instancetype)textureWithImageNamed:(NSString *)name;
+ (instancetype)textureWithImage:(UIImage *)image;
+ (instancetype)textureWithCGImage:(CGImageRef)image;

- (CGImageRef)CGImage;

#pragma mark Inspecting a Texture’s Properties
- (CGSize)size;

@end
