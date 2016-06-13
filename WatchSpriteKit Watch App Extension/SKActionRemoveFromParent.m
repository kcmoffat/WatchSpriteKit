//
//  SKActionRemoveFromParent.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/27/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKActionRemoveFromParent.h"
#import "SKActionPrivate.h"
#import "SKNode.h"

@implementation SKActionRemoveFromParent

#pragma mark Removing Nodes from the Scene
+ (SKAction *)removeFromParent
{
    return [[self alloc] init];
}

#pragma mark <NSCopying>
-(id)copyWithZone:(NSZone *)zone
{
    SKActionRemoveFromParent *copy = [[[self class] alloc] init];
    
    copy.speed = _speed;
    copy.timingMode = _timingMode;
    copy.timingFunction = _timingFunction;
    
    return copy;
}

-(void)update:(CGFloat)time
{
    [_target removeFromParent];
    self.complete = YES;
}


@end
