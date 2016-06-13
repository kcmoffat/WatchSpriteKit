//
//  SKActionMoveBy.h
//  Watchi
//
//  Created by KASEY MOFFAT on 4/5/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInterval.h"

@interface SKActionMoveBy : SKActionInterval

#pragma mark Creating Actions That Move Nodes
+ (SKAction *)moveByX:(CGFloat)deltaX
                    y:(CGFloat)deltaY
             duration:(NSTimeInterval)sec;

+ (SKAction *)moveBy:(CGVector)delta
            duration:(NSTimeInterval)sec;

@end
