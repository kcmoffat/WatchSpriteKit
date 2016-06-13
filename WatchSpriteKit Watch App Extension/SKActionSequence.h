//
//  SKActionSequence.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/21/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInterval.h"

// TODO enforce sequence to only have finite time actions
// NOTE: Currently cannot embed repeatForever actions in a sequence -
// the repeatForever action won't run.  The workaround is to run
// the repeatForever action in a block and add to sequence.
@interface SKActionSequence : SKActionInterval

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)sequence:(NSArray<SKAction *> *)actions;

@end
