# WatchSpriteKit
SpriteKit implementation for watchOS 2

This framework implements the action evaluation and rendering aspects of SpriteKit on watchOS 2.
It supports the following actions:

#### Instantaneous:
* removeFromParent
* setTexture
* runBlock

#### Non-instantaneous
* moveBy
* moveTo
* rotateBy
* wait
* repeat
* sequence
* group

It makes use of CoreGraphics for rendering, since other relevant graphics frameworks (OpenGL, CoreAnimation) are not available on watchOS 2.

#### NOTE:  SpriteKit and SceneKit are now available on watchOS 3.
