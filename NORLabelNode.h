//
//  NORLabelNode.h
//  TotalGreed
//
//  Created by Benjamin Larsen on 14.03.14.
//  Copyright (c) 2014 Benjamin Larsen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
/** A subclass of SKLabelNode adding multiline functionality through using the regular "\n" nextline character. */
@interface NORLabelNode : SKLabelNode

/// The nubmer of text-lines in the node.
@property (nonatomic, readonly, assign) NSUInteger numberOfLines;
/// The strings for all the different text-lines in the node.
@property (nonatomic, readonly, strong) NSArray *textLines;

@end
