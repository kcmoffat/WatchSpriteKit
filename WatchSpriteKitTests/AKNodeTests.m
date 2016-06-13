//
//  SKNodeTests.m
//  Watchi
//
//  Created by KASEY MOFFAT on 4/6/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SKNode.h"

@interface SKNodeTests : XCTestCase

@end

@implementation SKNodeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNodeCreation
{
    SKNode *node = [SKNode node];
    XCTAssertNotNil(node);
    XCTAssertEqual(node.position.x, 0);
    XCTAssertEqual(node.position.y, 0);
    XCTAssertEqual(node.zPosition, 0);
    XCTAssertEqual(node.zRotation, 0);
    XCTAssertEqual(node.xScale, 1.0);
    XCTAssertEqual(node.yScale, 1.0);
    XCTAssertEqual(node.hidden, NO);
    XCTAssertEqual(node.paused, NO);
    XCTAssertEqual(node.speed, 1.0);
    XCTAssert([node.children isKindOfClass:[NSArray class]]);
    XCTAssert([node.children count] == 0);
}

- (void)testNodeProperties
{
    SKNode *node = [SKNode node];
    node.position = CGPointMake(25.0, -50.1);
    node.zPosition = -1.0;
    node.zRotation = M_PI_2;
    node.xScale = .42;
    node.yScale = .87;
    node.hidden = YES;
    node.paused = YES;
    node.speed = 2.0;
    node.name = @"aNode";
    
    XCTAssertEqual(node.position.x, 25.0);
    XCTAssertEqual(node.position.y, -50.1);
    XCTAssertEqual(node.zPosition, -1.0);
    XCTAssertEqual(node.zRotation, M_PI_2);
    XCTAssertEqual(node.xScale, .42);
    XCTAssertEqual(node.yScale, .87);
    XCTAssertEqual(node.hidden, YES);
    XCTAssertEqual(node.paused, YES);
    XCTAssertEqual(node.speed, 2.0);
    XCTAssertEqual(node.name, @"aNode");
}

- (void)testSetScale
{
    SKNode *node = [SKNode node];
    node.xScale = .42;
    node.yScale = .87;
    XCTAssertEqual(node.xScale, .42);
    XCTAssertEqual(node.yScale, .87);
    
    [node setScale:3.4];
    XCTAssertEqual(node.xScale, 3.4);
    XCTAssertEqual(node.yScale, 3.4);
}

- (void)testAddChild
{
    SKNode *parent = [SKNode node];
    SKNode *child = [SKNode node];
    child.name = @"aChildNode";
    
    [parent addChild:child];
    
    XCTAssertEqual(child.parent, parent);
    XCTAssertEqual([parent.children count], 1);
    XCTAssertEqual(parent.children[0], child);
    XCTAssertEqual([parent childNodeWithName:@"aChildNode"], child);
}

- (void)testInsertChildAtIndex
{
    // TODO
}

- (void)testRemoveAllChildren
{
    SKNode *parent = [SKNode node];
    SKNode *child1 = [SKNode node];
    SKNode *child2 = [SKNode node];
    child1.name = @"child1";
    child2.name = @"child2";
    
    [parent addChild:child1];
    [parent addChild:child2];
    
    XCTAssertEqual([parent.children count], 2);
    XCTAssertEqual(parent.children[0], child1);
    XCTAssertEqual(parent.children[1], child2);
    XCTAssertEqual(child1.parent, parent);
    XCTAssertEqual(child2.parent, parent);
    
    [parent removeAllChildren];
    XCTAssertEqual([parent.children count], 0);
    XCTAssertNil(child1.parent);
    XCTAssertNil(child2.parent);
    XCTAssertNil([parent childNodeWithName:@"child1"]);
    XCTAssertNil([parent childNodeWithName:@"child2"]);
}

- (void)testIsEqualToNode
{
    SKNode *node1 = [SKNode node];
    SKNode *node2 = [SKNode node];
    
    XCTAssert([node1 isEqualToNode:node1]);
    XCTAssert(![node1 isEqualToNode:node2]);
}

@end
