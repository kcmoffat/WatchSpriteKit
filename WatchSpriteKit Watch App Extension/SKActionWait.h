//
//  SKActionWait.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/22/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInterval.h"

@interface SKActionWait : SKActionInterval

#pragma mark Creating an Action to Introduce a Delay into a Sequence
+ (SKAction *)waitForDuration:(NSTimeInterval)sec;
+ (SKAction *)waitForDuration:(NSTimeInterval)sec
                    withRange:(NSTimeInterval)durationRange;

@end
