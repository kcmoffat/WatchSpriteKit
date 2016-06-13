//
//  SKNode.m
//  Watchi
//
//  Created by KASEY MOFFAT on 3/29/16.
//  Copyright © 2016 KASEY MOFFAT. All rights reserved.
//

#import "SKNode.h"
#import "SKNodePrivate.h"
#import "SKAction.h"
#import "SKActionPrivate.h"

@interface SKNode()

@property(nonatomic) SKNode *parent;
@property(nonatomic) NSMutableArray <SKNode *> *mutableChildren;

@property(nonatomic) NSMutableArray <SKAction *> *unnamedActions;
@property(nonatomic) NSMutableDictionary <NSString *, SKAction *> *namedActions;

@end

@implementation SKNode

#pragma mark Creating a New Node
+ (instancetype)node
{
    return [[self alloc] init];
}

-(instancetype)init
{
    if (self = [super init]) {
        
        _position = CGPointMake(0.0, 0.0);
        _zPosition = 0.0;
        
        _xScale = 1.0;
        _yScale = 1.0;
        _zRotation = 0.0;
        
        _hidden = NO;
        
        _mutableChildren = [[NSMutableArray alloc] init];
        
        _speed = 1.0;
        _paused = NO;
        
        _unnamedActions = [[NSMutableArray alloc] init];
        _namedActions = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

#pragma mark Setting a Node's Scaling and Rotation
- (void)setScale:(CGFloat)scale
{
    _xScale = scale;
    _yScale = scale;
}

#pragma mark Working with Node Trees
- (void)addChild:(SKNode *)node
{
    // Can't add node if node already has parent
    if (node.parent) [NSException raise:@"SKNodeAlreadyHasParentException" format:@"Node must not already have a parent."];
    
    [_mutableChildren addObject:node];
    node.parent = self;
}

- (void)insertChild:(SKNode *)node
            atIndex:(NSInteger)index
{
    // Can't add node if node already has parent
    if (node.parent) [NSException raise:@"SKNodeAlreadyHasParentException" format:@"Node must not already have a parent."];
    
    [_mutableChildren insertObject:node atIndex:index];
    node.parent = self;
}

- (BOOL)isEqualToNode:(SKNode *)node
{
    return [self isEqual:node];
}

- (void)moveToParent:(SKNode *)parent
{
    // TODO maintain node coordinates in scene when moving
    [self removeFromParent];
    [parent addChild:self];
}

- (void)removeFromParent
{
    [_parent.mutableChildren removeObject:self];
    _parent = nil;
}

- (void)removeAllChildren
{
    for (SKNode *node in _mutableChildren) {
        node.parent = nil;
    }
    [_mutableChildren removeAllObjects];
}

- (void)removeChildrenInArray:(NSArray<SKNode *> *)nodes
{
    for (SKNode *node in nodes) {
        node.parent = nil;
    }
    [_mutableChildren removeObjectsInArray:nodes];
}

- (BOOL)inParentHierarchy:(SKNode *)parent
{
    // TODO: implement
    return NO;
}

-(NSArray<SKNode *> *)children
{
    return _mutableChildren;
}

#pragma mark Naming Nodes
- (SKNode *)childNodeWithName:(NSString *)name
{
    for (SKNode *node in _mutableChildren) {
        if ([node.name isEqualToString:name]) return node;
    }
    return nil;
}

#pragma mark Running Actions
- (void)runAction:(SKAction *)action
{
    [self runAction:action withKey:nil completion:nil];
}

- (void)runAction:(SKAction *)action
       completion:(void (^)(void))block
{
    [self runAction:action withKey:nil completion:block];
}

- (void)runAction:(SKAction *)action
          withKey:(NSString *)key
{
    [self runAction:action withKey:key completion:nil];
}

- (SKAction *)actionForKey:(NSString *)key
{
    return _namedActions[key];
}

- (BOOL)hasActions
{
    return [_unnamedActions count] > 0 || [[_namedActions allValues] count] > 0;
}

- (void)removeAllActions
{
    // TODO Determine what actions will run one last update after removal (as noted in SpriteKit API docs)
    [_unnamedActions removeAllObjects];
    [_namedActions removeAllObjects];
}

- (void)removeActionForKey:(NSString *)key
{
    [_namedActions removeObjectForKey:key];
}

-(void)runAction:(SKAction *)action withKey:(NSString *)key completion:(void (^)(void))block
{
    [self runAction:action withKey:key startTime:[[NSDate date] timeIntervalSince1970] completion:block];
}

-(void)runAction:(SKAction *)action withKey:(NSString *)key startTime:(NSTimeInterval)startTime completion:(void (^)(void))block
{
    SKAction *actionCopy = [action copy];
    
    actionCopy.completion = block;
    [actionCopy startWithTarget:self];
        
    key ? _namedActions[key] = actionCopy : [_unnamedActions addObject:actionCopy];
}

#pragma mark Private Methods - Action Evaluation
-(void)evaluateActions:(NSTimeInterval)dt
{
    // Evaluate named actions and remove completed actions
    for (NSString *actionKey in [_namedActions allKeys]) { // allows mutations
        SKAction *action = _namedActions[actionKey];
        if ([action isDone]) {
            [action stop];
            if (action.completion) action.completion();
            [_namedActions removeObjectForKey:actionKey];
        } else {
            [action step:dt];
        }
    }
    
    // Evaluate unnamed actions and remove completed actions
    NSMutableArray *unnamedActionsNew = [[NSMutableArray alloc] initWithCapacity:[_unnamedActions count]];
    for (SKAction *action in [_unnamedActions copy]) {
        if ([action isDone]) {
            [action stop];
            if (action.completion) action.completion();
        } else {
            [unnamedActionsNew addObject:action];
            [action step:dt];
        }
    }
    _unnamedActions = unnamedActionsNew;
    
    // Evaluate actions of child nodes
    for (SKNode *node in [self.children copy]) {
        [node evaluateActions:dt];
    }
}

#pragma mark Private Methods - Rendering
+(NSArray *)flattenTreeForRendering:(SKNode *)root
{
    NSArray *flattenedTree = [self flattenTree:root block:^(SKNode *node) {
        if (node.parent) {
            node.absoluteXScale = node.parent.absoluteXScale * node.xScale;
            node.absoluteYScale = node.parent.absoluteYScale * node.yScale;
            node.absolutePosition = CGPointMake(node.parent.absolutePosition.x + node.parent.absoluteXScale * node.position.x, node.parent.absolutePosition.y + node.parent.absoluteYScale * node.position.y);
            node.absoluteZRotation = node.parent.absoluteZRotation + node.zRotation;
            node.absoluteZPosition = node.parent.absoluteZPosition + node.zPosition;
            node.absoluteHidden = node.parent.absoluteHidden || node.hidden;
        } else {
            node.absolutePosition = node.position;
            node.absoluteZRotation = node.zRotation;
            node.absoluteZPosition = node.zPosition;
            node.absoluteXScale = node.xScale;
            node.absoluteYScale = node.yScale;
            node.absoluteHidden = node.hidden;
        }
    }];
    
    // Sort by zPosition
    flattenedTree = [flattenedTree sortedArrayUsingComparator:^NSComparisonResult(SKNode *_Nonnull node1, SKNode *_Nonnull node2) {
        
        if (node1.zPosition > node2.zPosition) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if (node1.zPosition < node2.zPosition) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return flattenedTree;
}

+(NSArray *)flattenTree:(SKNode *)root block:(void (^)(SKNode *))block;
{
    if (block) block(root);
    
    NSArray *result = [[NSArray alloc] initWithObjects:root, nil];
    for (SKNode *node in root.children) {
        result = [result arrayByAddingObjectsFromArray:[self flattenTree:node block:block]];
    }
    return result;
}

#pragma mark Description
-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, name: %@, position: (%f,%f), zRotation: %f, xScale: %f, yScale: %f, zPosition: %f>", [self class], self, _name, _absolutePosition.x, _absolutePosition.y, _absoluteZRotation, _absoluteXScale, _absoluteYScale, _absoluteZPosition];
}

@end
