//
//  SKUtilities.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/12/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKUtilities.h"
#import <WatchKit/WatchKit.h>

CGFloat const framesPerSecond = 30.0;

@implementation SKUtilities

+ (CGFloat)screenScale
{
    return [[WKInterfaceDevice currentDevice] screenScale];
}

@end
