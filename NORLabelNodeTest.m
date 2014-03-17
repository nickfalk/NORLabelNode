//
//  NORLabelNodeTest.m
//  TotalGreed
//
//  Created by Benjamin Larsen on 14.03.14.
//  Copyright (c) 2014 Benjamin Larsen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NORLabelNode.h"

@interface NORLabelNode ()
@property (nonatomic, strong) NSArray *subNodes;
@property (nonatomic, strong) SKLabelNode *propertyStateholderNode;
- (NSArray *)labelNodesFromText:(NSString *)text;

@end

@interface NORLabelNodeTest : XCTestCase

@end

@implementation NORLabelNodeTest

- (void)setUp{
    [super setUp];
}


- (void)testInitWithFontCreatesTheAppropriateControllerNode{
	NORLabelNode *labelNode    = [NORLabelNode labelNodeWithFontNamed:@"Avenir"];
	XCTAssertEqual(labelNode.fontName, labelNode.controllerNode.fontName, @"The controllerNode should have the same fontName as the node itself");
	XCTAssertNotNil(labelNode.controllerNode, @"The node should have a controllerNode after initWithFontName");
}


- (void)testThatLabelNodesFromTextReturnsTheCorrectNumberOfLabelNodes{
	NORLabelNode *labelNode    = [NORLabelNode node];
	NSString *stringWithBreaks    = @"There was an old lady\nwho swallowed a fly\nI don't know why...";
	NSArray *labelNodes    = [labelNode labelNodesFromText:stringWithBreaks];
	XCTAssertEqual(3, [labelNodes count], @"There should be 3 nodes in the returned array.");
}


- (void)testThatSettingTextWithLinebreaksCreatesSubNodes{
	NORLabelNode *labelNode    = [NORLabelNode node];
	labelNode.text    = @"There was an old lady\nwho swallowed a fly\nI don't know why...";
	XCTAssertEqual([labelNode.subNodes count], 3, @"The subNodes array of the labelNode should have three nodes after setting the text");
}


- (void)testThatTextMethodReturnsTheOriginalText{
	NORLabelNode *labelNode    = [NORLabelNode node];
	NSString *textString    = @"There was an old lady\nwho swallowed a fly\nI don't know why...";
	labelNode.text    = textString;
	XCTAssertEqualObjects(labelNode.text, textString, @"The text returned from the text method should be the same as the string passed into the property.");
}


- (void)testThatSubnodesInheritsPropertiesFromParent{
	NORLabelNode *threeLineNode    = [self nodeWithThreeSubNodes];
	threeLineNode.fontColor    = [SKColor greenColor];
	threeLineNode.fontName    = @"Avenir";
	threeLineNode.fontSize    = 100;
	threeLineNode.horizontalAlignmentMode    = SKLabelHorizontalAlignmentModeRight;
	threeLineNode.verticalAlignmentMode    = SKLabelVerticalAlignmentModeTop;
	threeLineNode.position    = CGPointMake(42, 0);
	for (SKLabelNode *subNode in threeLineNode.subNodes) {
		XCTAssertEqualObjects(threeLineNode.fontColor, subNode.fontColor, @"The subnodes should have the same fontColor as the parent.");
		XCTAssertEqualObjects(threeLineNode.fontName, subNode.fontName, @"The subnodes should have the same fontName as the parent.");
		XCTAssertEqual(threeLineNode.fontSize, subNode.fontSize, @"The subnodes should have teh same fontSize as the parent.");
		XCTAssertEqual(threeLineNode.horizontalAlignmentMode, subNode.horizontalAlignmentMode, @"The subnodes should have the same horizontalAligmentMode as the parent.");
		XCTAssertEqual(threeLineNode.verticalAlignmentMode, subNode.verticalAlignmentMode, @"The subnodes should have the same verticalAlignmentMode as the parent.");
	}
}


- (NORLabelNode *)nodeWithThreeSubNodes{
	NORLabelNode *labelNode    = [NORLabelNode node];
	labelNode.text    = @"There was an old lady\nwho swallowed a fly\nI don't know why...";
	return labelNode;
}




@end
