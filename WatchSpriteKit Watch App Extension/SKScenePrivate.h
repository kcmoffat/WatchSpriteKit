//
//  SKScenePrivate.h
//  Watchi
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKScene()

#pragma mark Presenting a Scene
@property(nonatomic, weak) SKView *view;

- (void)executeAnimationLoop:(NSTimer *)timer;

@end
