//
//  InterfaceController.m
//  Watchi Watch App Extension
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "InterfaceController.h"
#import "SKSpriteNode.h"
#import "SKNodePrivate.h"
#import "SKTexturePrivate.h"
#import "MainScene.h"
#import "SKView.h"
#import "SKUtilities.h"

@import UIKit;

const int k38mmWidth = 136;  // 38mm watch is 136 x 170 pts

@interface InterfaceController()

@property (assign, nonatomic) CGSize mainSize;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *backgroundGroup;

@property (nonatomic) SKView *view;
@property (nonatomic) MainScene *scene;

@property (nonatomic) SKTexture *spaceshipTexture;
@property (nonatomic) SKAction *moveRight;

@end

@implementation InterfaceController

- (IBAction)rotationButton {
    
    [_scene addSpaceship];
}

#pragma mark WKInterfaceController Delegate Methods
- (instancetype)init
{
    if (self = [super init]) {
        _view = [[SKView alloc] initWithWKInterfaceGroup:_backgroundGroup size:self.mainSize];
        _scene = [[MainScene alloc] initWithSize:self.mainSize];
    }
    return self;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    [_view presentScene:_scene];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"willActivate");
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"didDeactivate");
}

-(void)didAppear
{
    NSLog(@"didAppear");
    
    _view.paused = NO;
}

-(void)willDisappear
{
    NSLog(@"willDisappear");
    
    _view.paused = YES;
}

#pragma mark Scene Size
- (CGSize)mainSize {
    return CGSizeEqualToSize(_mainSize, CGSizeZero) ? _mainSize = mainImageSize() : _mainSize;
}

CGSize mainImageSize() {
    // Returns an image size that fills the available space under the status bar (in points)
    
    // Since we're unable to query the WKInterfaceImage for it's size, we need to
    // calculate it ourselves based on the watch's size.
    int width, height;
    CGRect rect = [[WKInterfaceDevice currentDevice] screenBounds];
    width = rect.size.width;
    
    // status bar differs slightly in height depending on size of watch
    // and we want to subtract this from the screen's height.
    if (width <= k38mmWidth) {
        // 38mm watch is 136 x 170 pts, status bar 19 pts high.
        height = rect.size.height - 19;
    }
    else {
        // 42mm watch is 156 x 195 pts, status bar 21 pts high.
        height = rect.size.height - 21;
    }
    
    return CGSizeMake(width, height);
}


@end



