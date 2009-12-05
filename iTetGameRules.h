//
//  iTetGameRules.h
//  iTetrinet
//
//  Created by Alex Heinz on 9/23/09.
//

#import <Cocoa/Cocoa.h>

@interface iTetGameRules : NSObject
{
	NSUInteger startingLevel;
	NSUInteger initialStackHeight;
	NSUInteger linesPerLevel;
	NSUInteger levelIncrease;
	NSUInteger linesPerSpecial;
	NSUInteger specialsAdded;
	NSUInteger specialCapacity;
	char blockFrequencies[100];
	char specialFrequencies[100];
	BOOL averageLevels;
	BOOL classicRules;
}

+ (id)gameRulesFromArray:(NSArray*)rules;
- (id)initWithRulesFromArray:(NSArray*)rules;

@property (readonly) NSUInteger startingLevel;
@property (readonly) NSUInteger initialStackHeight;
@property (readonly) NSUInteger linesPerLevel;
@property (readonly) NSUInteger levelIncrease;
@property (readonly) NSUInteger linesPerSpecial;
@property (readonly) NSUInteger specialsAdded;
@property (readonly) NSUInteger specialCapacity;
@property (readonly) char* blockFrequencies;
@property (readonly) char* specialFrequencies;
@property (readonly) BOOL averageLevels;
@property (readonly) BOOL classicRules;

@end
