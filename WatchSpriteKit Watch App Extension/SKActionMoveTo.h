//
//  SKActionMove.h
//  Watchi
//
//  Created by KASEY MOFFAT on 3/31/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionMoveBy.h"
#import "SKActionInterval.h"

@interface SKActionMoveTo : SKActionInterval

#pragma mark Creating Actions That Move Nodes
+ (SKAction *)moveTo:(CGPoint)location
            duration:(NSTimeInterval)sec;

+ (SKAction *)moveToX:(CGFloat)x
             duration:(NSTimeInterval)sec;

+ (SKAction *)moveToY:(CGFloat)y
             duration:(NSTimeInterval)sec;

@end
