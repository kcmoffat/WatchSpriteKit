//
//  SKActionSetTexture.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/22/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInstant.h"
#import "SKTexture.h"

@interface SKActionSetTexture : SKActionInstant

#pragma mark Creating Actions That Change a Sprite Node’s Content
+ (SKAction *)setTexture:(SKTexture *)texture;
+ (SKAction *)setTexture:(SKTexture *)texture
                  resize:(BOOL)resize;
@end
