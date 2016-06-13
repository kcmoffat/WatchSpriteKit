//
//  SKActionRepeatForever.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/21/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKAction.h"

@interface SKActionRepeatForever : SKAction

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)repeatActionForever:(SKAction *)action;

@end
