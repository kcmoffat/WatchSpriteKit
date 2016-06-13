//
//  SKActionRunBlock.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/22/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionInstant.h"

@interface SKActionRunBlock : SKActionInstant

#pragma mark Creating Custom Actions
+ (SKAction *)runBlock:(dispatch_block_t)block;
+ (SKAction *)runBlock:(dispatch_block_t)block
                 queue:(dispatch_queue_t)queue;
@end
