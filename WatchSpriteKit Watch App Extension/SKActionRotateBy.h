//
//  SKActionRotateBy.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/13/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInterval.h"

@interface SKActionRotateBy : SKActionInterval

#pragma mark Creating Actions That Rotate Nodes
+ (SKAction *)rotateByAngle:(CGFloat)radians
                   duration:(NSTimeInterval)sec;

@end
