//
//  SKView.m
//  Watchi
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKView.h"
#import "SKScenePrivate.h"
#import "SKUtilities.h"

@import ImageIO;

@interface SKView()

- (void)startUpdateLoop;
- (void)stopUpdateLoop;

@property(nonatomic, strong) NSTimer *timer;

@end

@implementation SKView

@synthesize paused = _paused;

#pragma mark Initialization
- (instancetype)initWithWKInterfaceImage:(WKInterfaceImage *)image size:(CGSize)size
{
    if (self = [self initWithSize:size]) {
        _image = image;
    }
    return self;
}

- (instancetype)initWithWKInterfaceGroup:(WKInterfaceGroup *)group size:(CGSize)size
{
    if (self = [self initWithSize:size]) {
        _group = group;
    }
    return self;
}

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super init]) {
        _size = size;
        _framesPerSecond = framesPerSecond;
        [self beginBitmapContextWithSize:_size];
    }
    return self;
}

#pragma mark Presenting Scenes
- (void)presentScene:(SKScene *)scene
{
    [self stopUpdateLoop];
    if (_scene) [_scene willMoveFromView:_scene.view];
    _scene = scene;
    _scene.view = self;
    [_scene didMoveToView:self];
    [self startUpdateLoop];
}

#pragma mark Pausing the Scene’s Simulation
-(BOOL)isPaused
{
    return _paused;
}

-(void)setPaused:(BOOL)paused
{
    if (paused) {
        [self stopUpdateLoop];
    } else {
        [self startUpdateLoop];
    }
    _paused = paused;
}

#pragma mark Updating Display
- (void)beginBitmapContextWithSize:(CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    size_t bitsPerComponent = 8;
    size_t byteAlignment = 16;
    size_t componentsPerPixel = 4;
    size_t bytesPerRow = size.width * componentsPerPixel;
    bytesPerRow = bytesPerRow + byteAlignment - bytesPerRow % byteAlignment;
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, bitsPerComponent, bytesPerRow, colorSpace, kCGBitmapByteOrder32Host | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    CGContextSetInterpolationQuality(context, kCGInterpolationLow);
    
    UIGraphicsPushContext(context);
    CGContextRelease(context);
}

- (void)updateDisplayImage:(UIImage *)image
{
    if (_image) {
        [_image setImage:image];
    } else if (_group) {
        [_group setBackgroundImage:image];
    }
}

- (void)updateDisplayImageData:(UIImage *)image
{
    if (_image) {
        [_image setImageData:UIImagePNGRepresentation(image)];
    } else if (_group) {
        [_group setBackgroundImageData:UIImagePNGRepresentation(image)];
    }
}

- (void)fastUpdateDisplayImage:(UIImage *)image
{
    float compression = 1.0; // Lossless compression if available.
    int orientation = 4; // Origin is at bottom, left.
    CFStringRef myKeys[3];
    CFTypeRef   myValues[3];
    CFDictionaryRef myOptions = NULL;
    myKeys[0] = kCGImagePropertyOrientation;
    myValues[0] = CFNumberCreate(NULL, kCFNumberIntType, &orientation);
    myKeys[1] = kCGImagePropertyHasAlpha;
    myValues[1] = kCFBooleanTrue;
    myKeys[2] = kCGImageDestinationLossyCompressionQuality;
    myValues[2] = CFNumberCreate(NULL, kCFNumberFloatType, &compression);
    myOptions = CFDictionaryCreate( NULL, (const void **)myKeys, (const void **)myValues, 3,
                                   &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    // Release the CFNumber and CFDictionary objects when you no longer need them.

}

- (void) writeCGImage: (CGImageRef) image toDataRef: (CFMutableDataRef) dataRef withType: (CFStringRef) imageType andOptions: (CFDictionaryRef) options
{
    CGImageDestinationRef myImageDest = CGImageDestinationCreateWithData(dataRef, imageType, 1, NULL);
    CGImageDestinationAddImage(myImageDest, image, options);
    CGImageDestinationFinalize(myImageDest);
    CFRelease(myImageDest);
}

#pragma mark Private Methods
- (void)startUpdateLoop
{
    if (!_timer || ![_timer isValid]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1/_framesPerSecond target:_scene selector:@selector(executeAnimationLoop:) userInfo:nil repeats:YES];
    }
}

- (void)stopUpdateLoop
{
    if (_timer) [_timer invalidate];
}

-(void)dealloc
{
    UIGraphicsPopContext();
}

@end
