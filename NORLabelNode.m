#import "NORLabelNode.h"


@interface NORLabelNode ()
@property (nonatomic, strong) NSArray *subNodes;
@property (nonatomic, strong) SKLabelNode *propertyStateholderNode; 
@end


@implementation NORLabelNode

const CGFloat kLineSpaceMultiplier    = 1.5;
const CGFloat kDefaultFontSize    = 32.0;
@synthesize text    = _text;
@synthesize position    = _position;
@synthesize fontColor    = _fontColor;
@synthesize fontSize    = _fontSize;
@synthesize color    = _color;
@synthesize colorBlendFactor    = _colorBlendFactor;
@synthesize blendMode    = _blendMode;

+ (NORLabelNode *)labelNodeWithFontNamed:(NSString *)fontName{
    NORLabelNode *node    = [[[self class] alloc] initWithFontNamed:fontName];
    return node;
}


- (instancetype)initWithFontNamed:(NSString *)fontName{
	self    = [super initWithFontNamed:fontName];
	if (self) {
		self.lineSpacing    = kLineSpaceMultiplier;
		self.fontSize    = kDefaultFontSize;
		[self setupStateholderNode];
	}
	return self;
}


- (instancetype)init{
	self    = [super init];
	if (self) {
		self.lineSpacing    = kLineSpaceMultiplier;
		self.fontSize    = kDefaultFontSize;
		[self setupStateholderNode];
	}
	return self;
}


- (void)setupStateholderNode{
	self.propertyStateholderNode    = [SKLabelNode node];
	self.propertyStateholderNode.fontName    = self.fontName;
}


- (NSArray *)labelNodesFromText:(NSString *)text{
	NSArray *substrings    = [text componentsSeparatedByString:@"\n"];
	NSMutableArray *labelNodes    = [[NSMutableArray alloc] initWithCapacity:[substrings count]];

	NSUInteger labelNumber    = 0;
	for (NSString *substring in substrings) {
		SKLabelNode *labelNode    = [SKLabelNode labelNodeWithFontNamed:self.fontName];
		labelNode.text    = substring;
		SKColor *fontColor    = self.fontColor;
		if (nil == self.fontColor) {
			fontColor    = [SKColor whiteColor];
		}
		labelNode.fontColor    = fontColor;
		labelNode.fontSize    = self.fontSize;
		labelNode.horizontalAlignmentMode    = self.horizontalAlignmentMode;
		labelNode.verticalAlignmentMode    = self.verticalAlignmentMode;
		CGFloat y    = self.position.y - (labelNumber * self.fontSize * self.lineSpacing);
		labelNode.position    = CGPointMake(self.position.x, y);
		labelNode.color    = self.color;
		labelNode.colorBlendFactor    = self.colorBlendFactor;
		labelNode.blendMode    = self.blendMode;
		labelNumber++;
		[labelNodes addObject:labelNode];
	}
	
	return [labelNodes copy];
}


#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone{
	NORLabelNode *copy    = [[NORLabelNode alloc] initWithFontNamed:nil];
	if (copy) {
		copy.fontName    = [self.fontName copyWithZone:zone];
		copy.fontColor    = [self.fontColor copyWithZone:zone];
		copy.fontSize    = self.fontSize;
		copy.text    = [self.text copyWithZone:zone];
		copy.color   = [self.color copyWithZone:zone];
		copy.colorBlendFactor    = self.colorBlendFactor;
		copy.blendMode    = self.blendMode;
		copy.horizontalAlignmentMode    = self.horizontalAlignmentMode;
		copy.verticalAlignmentMode    = self.verticalAlignmentMode;
		
		copy.propertyStateholderNode    = [self.propertyStateholderNode copyWithZone:zone];
		copy.subNodes    = [self.subNodes copyWithZone:zone];
		for (SKLabelNode *labelNode in self.children) {
			[copy addChild:[labelNode copyWithZone:zone]];
		}
	}
	return copy;
}


#pragma mark - setterOverriders

- (void)setText:(NSString *)text{
	self.propertyStateholderNode.text    = text;
	self.subNodes    = [self labelNodesFromText:text];
	[self removeAllChildren];
	for (SKLabelNode *childNode in self.subNodes) {
		[self addChild:childNode];
	}
	_text    = @"";
	[self repositionSubNodesBasedOnParentPosition:self.position];
}


- (void)setPosition:(CGPoint)position{
	[super setPosition:position];
    self.propertyStateholderNode.position    = position;
	position.y    -= position.y;
	_position    = position;
	[self repositionSubNodesBasedOnParentPosition:position];
}


- (void)setHorizontalAlignmentMode:(SKLabelHorizontalAlignmentMode)horizontalAlignmentMode{
	[super setHorizontalAlignmentMode:horizontalAlignmentMode];
	self.propertyStateholderNode.horizontalAlignmentMode    = horizontalAlignmentMode;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.horizontalAlignmentMode    = horizontalAlignmentMode;
	}
}


- (void)setVerticalAlignmentMode:(SKLabelVerticalAlignmentMode)verticalAlignmentMode{
	[super setVerticalAlignmentMode:verticalAlignmentMode];
	self.propertyStateholderNode.verticalAlignmentMode    = verticalAlignmentMode;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.verticalAlignmentMode    = verticalAlignmentMode;
	}
	
	[self repositionSubNodesBasedOnParentPosition:self.position];
}


- (void)setFontSize:(CGFloat)fontSize{
	self.propertyStateholderNode.fontSize    = fontSize;
	_fontSize    = fontSize;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.fontSize    = fontSize;
	}
	[self repositionSubNodesBasedOnParentPosition:self.position];
}


- (void)setFontName:(NSString *)fontName{
	[super setFontName:fontName];
	self.propertyStateholderNode.fontName    = fontName;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.fontName    = fontName;
	}
	
}


- (void)setFontColor:(SKColor *)fontColor{
	self.propertyStateholderNode.fontColor    = fontColor;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.fontColor    = fontColor;
	}
	_fontColor    = fontColor;
}


- (void)setColor:(SKColor *)color{
	self.propertyStateholderNode.color = color;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.color    = color;
	}
	_color    = color;
}


- (void)setColorBlendFactor:(CGFloat)colorBlendFactor{
	[super setColorBlendFactor:colorBlendFactor];
	self.propertyStateholderNode.colorBlendFactor = colorBlendFactor;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.colorBlendFactor    = colorBlendFactor;
	}
	_colorBlendFactor    = colorBlendFactor;
}


- (void)setBlendMode:(SKBlendMode)blendMode{
	self.propertyStateholderNode.blendMode    = blendMode;
	for (SKLabelNode *subNode in self.subNodes) {
		subNode.blendMode    = blendMode;
	}
	_blendMode    = blendMode;
}


- (void)setLineSpacing:(CGFloat)lineSpacing{
	_lineSpacing    = lineSpacing;
	[self repositionSubNodesBasedOnParentPosition:self.position];
}


#pragma mark - Repositioning subnodes

- (void)repositionSubNodesBasedOnParentPosition:(CGPoint)position {
	CGFloat lineSpacingAdjustment    = self.fontSize * self.lineSpacing;
	CGFloat numberOfPositionsLabelsShouldMoveUp    = 0.0f;
	CGFloat y    = 0.0f;
	
	switch (self.verticalAlignmentMode) {
		case SKLabelVerticalAlignmentModeBaseline:
		case SKLabelVerticalAlignmentModeCenter:
			numberOfPositionsLabelsShouldMoveUp    = (CGFloat)(self.numberOfLines - 1) / 2;
			break;
		case SKLabelVerticalAlignmentModeBottom:
			numberOfPositionsLabelsShouldMoveUp    = self.numberOfLines - 1;
			break;
		case SKLabelVerticalAlignmentModeTop:
		default:
			break;
	}
	
	y    += numberOfPositionsLabelsShouldMoveUp * lineSpacingAdjustment;
	
	for (SKLabelNode *subNode in self.subNodes) {
		CGFloat x    = 0;
		subNode.position    = CGPointMake(x, y);
		y    -= lineSpacingAdjustment;
	}
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
	NSString *positionString    = nil;
#if TARGET_OS_IPHONE
	positionString    = [NSString stringWithFormat:@"%@", NSStringFromCGPoint(self.position)];
#elif TARGET_OS_MAC
	NSPoint position    = self.position;
	positionString    = [NSString stringWithFormat:@"%@", NSStringFromPoint(position)];
#endif
	NSString *descriptionString    = [NSString stringWithFormat:@"<%@> name:'%@' text:'%@' fontName:'%@' position:%@", [self class], self.name, self.propertyStateholderNode.text, self.fontName, positionString];
	return descriptionString;
}


@end
