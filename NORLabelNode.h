/*
 NORLabelNode.h
 
 A simple extension of SKLabelNode allowing for multiline-labes in SpriteKit through the use of nextline characters.
 
 This software is created by T. Benjamin Larsen and can be included as a part of any software-project free of charge.
 No credits are required, but extensions made to this class should aknowledge its origin in some form. The
 
 The software is provided by T. Benjamin Larsen on an "AS IS" basis. NO WARRANTIES, ARE EXPRESSED OR IMPLIED,
 INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A 
 PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
*/

#import <SpriteKit/SpriteKit.h>
/** A subclass of SKLabelNode adding multiline functionality by using the regular \"\\n\" nextline character in the text-string. */
@interface NORLabelNode : SKLabelNode <NSCopying>

/// The number of text-lines in the node.
@property (nonatomic, readonly, assign) NSUInteger numberOfLines;
/// The float value controlling the space between lines. It works by multiplying the font's pointSize. The default value is 1.5.
@property (nonatomic, assign) CGFloat lineSpacing;

@end
