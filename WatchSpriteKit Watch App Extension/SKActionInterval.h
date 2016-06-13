//
//  SKActionInterval.h
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/20/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKAction.h"

@interface SKActionInterval : SKAction <NSCopying>

@property (nonatomic,readonly) NSTimeInterval elapsed;

-(instancetype)initWithDuration:(NSTimeInterval)sec;

@end