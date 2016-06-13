//
//  SKActionRepeat.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/14/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInterval.h"

@interface SKActionRepeat : SKActionInterval

#pragma mark Creating Actions That Combine or Repeat Other Actions
+ (SKAction *)repeatAction:(SKAction *)action
                     count:(NSUInteger)count;

@end
