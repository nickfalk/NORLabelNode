#import "NORLabelNode.h"


@interface NORLabelNode ()
@property (nonatomic, strong) NSArray *subNodes;
@property (nonatomic, strong) SKLabelNode *propertyStateholderNode; 
@end


@implementation NORLabelNode

const CGFloat kLineSpaceMultiplier    = 1.5;
@synthesize text    = _text;
@synthesize position    = _position;
@synthesize fontColor    = _fontColor;


+ (NORLabelNode *)labelNodeWithFontNamed:(NSString *)fontName{
    NORLabelNode *node = [[[self class] alloc] initWithFontNamed:fontName];
    return node;
}


- (instancetype)initWithFontNamed:(NSString *)fontName{
	self    = [super initWithFontNamed:fontName];
	if (self) {
        [self setDefaultValues];
		[self updateStateholderNode];
		self.propertyStateholderNode.fontName    = self.fontName;
	}
	return self;
}


- (void)setDefaultValues{
    self.fontColor = [super fontColor];
    self.position = [super position];
    self.verticalAlignmentMode = [super verticalAlignmentMode];
    self.horizontalAlignmentMode = [super horizontalAlignmentMode];
}


- (void)updateStateholderNode{
	if (!self.propertyStateholderNode) {
		self.propertyStateholderNode    = [SKLabelNode node];
	}
}


- (NSArray *)labelNodesFromText:(NSString *)text{
	NSArray *substrings    = [text componentsSeparatedByString:@"\n"];
	NSMutableArray *labelNodes    = [[NSMutableArray alloc] initWithCapacity:[substrings count]];

	NSUInteger labelNumber    = 0;
	for (NSString *substring in substrings) {
		SKLabelNode *labelNode    = [SKLabelNode labelNodeWithFontNamed:self.fontName];
		labelNode.text    = substring;
		labelNode.fontColor    = self.fontColor;
		labelNode.fontSize    = self.fontSize;
		labelNode.horizontalAlignmentMode    = self.horizontalAlignmentMode;
		labelNode.verticalAlignmentMode    = self.verticalAlignmentMode;
		CGFloat y    = self.position.y - (labelNumber * self.fontSize * kLineSpaceMultiplier);
		labelNode.position    = CGPointMake(self.position.x, y);
		labelNumber++;
		[labelNodes addObject:labelNode];
	}
	
	return [labelNodes copy];
}


#pragma mark setterOverriders

- (void)setText:(NSString *)text{
	[self updateStateholderNode];
	self.propertyStateholderNode.text    = text;
	self.subNodes    = [self labelNodesFromText:text];
	[self removeAllChildren];
	for (SKLabelNode *childNode in self.subNodes) {
		[self addChild:childNode];
	}
	_text    = @"";
}


- (void)setPosition:(CGPoint)position{
	[super setPosition:position];
    self.propertyStateholderNode.position    = position;
    
    if (self.verticalAlignmentMode == SKLabelVerticalAlignmentModeCenter) {
        position.y    -= position.y;
    }
    NSLog(@"position.y:%f",position.y);

	_position    = position;

	[self updateStateholderNode];
	[self repositionSubNodesBasedOnParentPosition:position];
}


- (void)setHorizontalAlignmentMode:(SKLabelHorizontalAlignmentMode)horizontalAlignmentMode{
	[super setHorizontalAlignmentMode:horizontalAlignmentMode];
	[self updateStateholderNode];
	self.propertyStateholderNode.horizontalAlignmentMode    = horizontalAlignmentMode;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.horizontalAlignmentMode    = horizontalAlignmentMode;
	}
}


- (void)setVerticalAlignmentMode:(SKLabelVerticalAlignmentMode)verticalAlignmentMode{
	[super setVerticalAlignmentMode:verticalAlignmentMode];
	[self updateStateholderNode];
	self.propertyStateholderNode.verticalAlignmentMode    = verticalAlignmentMode;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.verticalAlignmentMode    = verticalAlignmentMode;
	}
}


- (void)setFontSize:(CGFloat)fontSize{
	[super setFontSize:fontSize];
	[self updateStateholderNode];
	self.propertyStateholderNode.fontSize    = fontSize;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.fontSize    = fontSize;
	}
	[self repositionSubNodesBasedOnParentPosition:self.position];
}


- (void)setFontName:(NSString *)fontName{
	[super setFontName:fontName];
	[self updateStateholderNode];
	self.propertyStateholderNode.fontName    = fontName;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.fontName    = fontName;
	}
	
}


- (void)setFontColor:(UIColor *)fontColor{
	[super setFontColor: fontColor];
	[self updateStateholderNode];
	self.propertyStateholderNode.fontColor    = fontColor;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.fontColor    = fontColor;
	}
	_fontColor    = fontColor;
}


#pragma mark -

- (void)repositionSubNodesBasedOnParentPosition:(CGPoint)position {
	NSUInteger subnodeNumber    = 0;
	for (SKLabelNode *subNode in self.subNodes) {
		CGFloat x    =  0;
		CGFloat y    = position.y - (self.fontSize * kLineSpaceMultiplier * subnodeNumber);
		subNode.position    = CGPointMake(x, y);
		subnodeNumber++;
	}
}


#pragma mark - frame

- (CGRect)frame{
	SKLabelNode *widestNode    = nil;
	CGFloat largestWidth    = 0;
	for (SKLabelNode *childNode in self.subNodes) {
		if (childNode.frame.size.width > largestWidth) {
			largestWidth    = childNode.frame.size.width;
			widestNode    = childNode;
		}
	}
	CGRect frame    = self.propertyStateholderNode.frame;
	frame.size.width    = largestWidth;
	SKLabelNode *topNode    = [self.subNodes firstObject];
	CGFloat top    = CGRectGetMaxY(topNode.frame);
	SKLabelNode *bottomNode    = [self.subNodes lastObject];
	CGFloat bottom    = CGRectGetMinY(bottomNode.frame);
	CGFloat height    = bottom - top;
	if (height < 0) {
		height    *= -1;
	}
	frame.size.height    = height;
	return frame;
}



#pragma mark - property getters

-(NSUInteger)numberOfLines{
	return [self.subNodes count];
}


- (NSString *)text{
	return self.propertyStateholderNode.text;
}


- (CGPoint)position{
    return self.propertyStateholderNode.position;
}

#pragma mark - description

- (NSString *)description{
	NSString *positionString    = [NSString stringWithFormat:@"%@", NSStringFromCGPoint(self.position)];
	NSString *descriptionString    = [NSString stringWithFormat:@"<%@> name:'%@' text:'%@' fontName:'%@' position:%@", [self class], self.name, self.propertyStateholderNode.text, self.fontName, positionString];
	return descriptionString;
}


@end
