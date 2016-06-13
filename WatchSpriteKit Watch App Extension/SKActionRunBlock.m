//
//  SKActionRunBlock.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/22/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionRunBlock.h"
#import "SKActionPrivate.h"

@interface SKActionRunBlock()

@property (nonatomic) dispatch_block_t block;
@property (nonatomic) dispatch_queue_t queue;

@end

@implementation SKActionRunBlock

#pragma mark Creating Custom Actions
+ (SKAction *)runBlock:(dispatch_block_t)block
{
    return [[self alloc] initWithBlock:block queue:dispatch_get_main_queue()];
}

+ (SKAction *)runBlock:(dispatch_block_t)block
                 queue:(dispatch_queue_t)queue
{
    return [[self alloc] initWithBlock:block queue:queue];
}

-(instancetype)initWithBlock:(dispatch_block_t)block
                       queue:(dispatch_queue_t)queue
{
    if (self = [super init]) {
        _block = [block copy];
        _queue = queue;
        
    }
    return self;
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionRunBlock *copy = [[[self class] alloc] initWithBlock:_block queue:_queue];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)update:(CGFloat)time
{
    if (_block) dispatch_async(_queue, _block);
    self.complete = YES;
}

@end
