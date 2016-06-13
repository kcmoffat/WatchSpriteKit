//
//  SKActionGroup.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/22/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInterval.h"

@interface SKActionGroup : SKActionInterval

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)group:(NSArray<SKAction *> *)actions;

@end
