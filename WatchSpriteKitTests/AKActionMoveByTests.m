//
//  SKActionMoveByTests.m
//  WatchSpriteKit
//
//  Created by KASEY MOFFAT on 4/15/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SKActionMoveBy.h"
#import "SKNodePrivate.h"

@interface SKActionMoveByTests : XCTestCase

@end

@implementation SKActionMoveByTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSingleMoveBy
{
    SKAction *action = [SKAction moveByX:3 y:6 duration:3];
    SKNode *node = [SKNode node];
    node.position = CGPointZero;
    
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    [node runAction:action withKey:nil startTime:startTime completion:nil];
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+1];
    
    XCTAssertEqualWithAccuracy(node.position.x, 1, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 2, .001);
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+2];
    
    XCTAssertEqualWithAccuracy(node.position.x, 2, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 4, .001);
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+3];
    
    XCTAssertEqualWithAccuracy(node.position.x, 3, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 6, .001);
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+4];
    
    XCTAssertEqualWithAccuracy(node.position.x, 3, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 6, .001);
    // Not checking hasActions until one more cycle since
    // rounding errors could return an incorrect result.
    
    [node evaluateActions:startTime+5];
    
    XCTAssertEqualWithAccuracy(node.position.x, 3, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 6, .001);
    XCTAssertFalse([node hasActions]);
}

- (void)testThatSimultaneousMoveByActionsAccumulate
{
    SKAction *action1 = [SKAction moveByX:3 y:6 duration:3];
    SKAction *action2 = [SKAction moveByX:-6 y:-12 duration:3];
    SKNode *node = [SKNode node];
    node.position = CGPointZero;
    
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    [node runAction:action1 withKey:nil startTime:startTime completion:nil];
    [node runAction:action2 withKey:nil startTime:startTime completion:nil];
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+1];
    
    XCTAssertEqualWithAccuracy(node.position.x, -1, .001);
    XCTAssertEqualWithAccuracy(node.position.y, -2, .001);
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+2];
    
    XCTAssertEqualWithAccuracy(node.position.x, -2, .001);
    XCTAssertEqualWithAccuracy(node.position.y, -4, .001);
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+3];
    
    XCTAssertEqualWithAccuracy(node.position.x, -3, .001);
    XCTAssertEqualWithAccuracy(node.position.y, -6, .001);
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+4];
    
    XCTAssertEqualWithAccuracy(node.position.x, -3, .001);
    XCTAssertEqualWithAccuracy(node.position.y, -6, .001);
    // Not checking hasActions until one more cycle since
    // rounding errors could return an incorrect result.
    
    [node evaluateActions:startTime+5];
    
    XCTAssertEqualWithAccuracy(node.position.x, -3, .001);
    XCTAssertEqualWithAccuracy(node.position.y, -6, .001);
    XCTAssertFalse([node hasActions]);
}

- (void)testThatMoveByObjectCanBeRunTwiceAndAccumulates
{
    SKAction *action = [SKAction moveByX:3 y:6 duration:3];
    SKNode *node = [SKNode node];
    node.position = CGPointZero;
    
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    [node runAction:action withKey:nil startTime:startTime completion:nil];
    [node runAction:action withKey:nil startTime:startTime completion:nil];
    
    [node evaluateActions:startTime+1];
    
    XCTAssertEqualWithAccuracy(node.position.x, 2, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 4, .001);
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+2];
    
    XCTAssertEqualWithAccuracy(node.position.x, 4, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 8, .001);
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+3];
    
    XCTAssertEqualWithAccuracy(node.position.x, 6, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 12, .001);
    XCTAssertTrue([node hasActions]);
    
    [node evaluateActions:startTime+4];
    
    XCTAssertEqualWithAccuracy(node.position.x, 6, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 12, .001);
    // Not checking hasActions until one more cycle since
    // rounding errors could return an incorrect result.
    
    [node evaluateActions:startTime+5];
    
    XCTAssertEqualWithAccuracy(node.position.x, 6, .001);
    XCTAssertEqualWithAccuracy(node.position.y, 12, .001);
    XCTAssertFalse([node hasActions]);
    
}

@end
