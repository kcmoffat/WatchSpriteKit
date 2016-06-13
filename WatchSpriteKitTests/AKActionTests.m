//
//  SKActionTests.m
//  Watchi
//
//  Created by KASEY MOFFAT on 4/5/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SKAction.h"

@interface SKActionTests : XCTestCase

@end

@implementation SKActionTests


float (^linearTimingFunction)(float time) = ^float(float time) {
    return time;
};

float (^quadraticTimingFunction)(float time) = ^float(float time) {
    return time * time;
};

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testCopy
{
    SKAction *action1 = [[SKAction alloc] init];
    action1.speed = 1.0;
    action1.duration = 2.0;
    action1.timingMode = SKActionTimingLinear;
    action1.timingFunction = linearTimingFunction;
    XCTAssertEqual(action1.speed, 1.0);
    XCTAssertEqual(action1.duration, 2.0);
    XCTAssertEqual(action1.timingMode, SKActionTimingLinear);
    XCTAssertEqual(action1.timingFunction, linearTimingFunction);
    
    SKAction *action2 = [action1 copy];
    action1.speed = 2.0;
    action1.duration = 3.0;
    action1.timingMode = SKActionTimingEaseIn;
    action1.timingFunction = quadraticTimingFunction;
    XCTAssertEqual(action1.speed, 2.0);
    XCTAssertEqual(action1.duration, 3.0);
    XCTAssertEqual(action1.timingMode, SKActionTimingEaseIn);
    XCTAssertEqual(action1.timingFunction, quadraticTimingFunction);
    
    XCTAssertEqual(action2.speed, 1.0);
    XCTAssertEqual(action2.duration, 2.0);
    XCTAssertEqual(action2.timingMode, SKActionTimingLinear);
    XCTAssertEqual(action2.timingFunction, linearTimingFunction);
}

@end
