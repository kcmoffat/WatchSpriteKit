//
//  MainScene.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/12/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "MainScene.h"
#import "SKSpriteNode.h"

@implementation MainScene

-(void)didMoveToView:(SKView *)view
{
    // Configure scene objects here
}

-(void)addSpaceship
{
    SKSpriteNode *spaceship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    spaceship.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:spaceship];
    
    SKAction *rotate = [SKAction rotateByAngle:2*M_PI duration:1];
    SKAction *repeatRotateForever = [SKAction repeatActionForever:rotate];
    [spaceship runAction:repeatRotateForever];
}

@end
