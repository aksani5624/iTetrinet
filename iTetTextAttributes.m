//
//  iTetTextAttributes.m
//  iTetrinet
//
//  Created by Alex Heinz on 3/3/10.
//

#import "iTetTextAttributes.h"
#import "NSColor+Comparisons.h"

#define iTetSilverTextColor		[NSColor colorWithCalibratedRed:0.75 green:0.75 blue:0.75 alpha:1.0]
#define iTetGreenTextColor		[NSColor colorWithCalibratedRed:0.0 green:0.5 blue:0.0 alpha:1.0]
#define iTetOliveTextColor		[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.0 alpha:1.0]
#define iTetTealTextColor		[NSColor colorWithCalibratedRed:0.0 green:0.5 blue:0.5 alpha:1.0]
#define iTetDarkBlueTextColor	[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.5 alpha:1.0]
#define iTetMaroonTextColor		[NSColor colorWithCalibratedRed:0.5 green:0.0 blue:0.0 alpha:1.0]

NSCharacterSet* iTetTextAttributeCharacterSet = nil;

@interface iTetTextAttributes (Private)

+ (NSString*)chatTextAttributeCharactersString;

@end

@implementation iTetTextAttributes

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	[self release];
	return nil;
}

+ (NSDictionary*)defaultChatTextAttributes
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[self defaultTextColor], NSForegroundColorAttributeName,
			[self plainChatTextFont], NSFontAttributeName,
			[NSNumber numberWithInt:NSUnderlineStyleNone], NSUnderlineStyleAttributeName,
			nil];
}

+ (NSDictionary*)localPlayerNameTextColorAttributes
{
	return [NSDictionary dictionaryWithObject:[self localPlayerNameTextColor]
									   forKey:NSForegroundColorAttributeName];
}

+ (NSDictionary*)defaultGameActionsTextAttributes
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[self defaultTextColor], NSForegroundColorAttributeName,
			[self gameActionsTextFont], NSFontAttributeName,
			[NSNumber numberWithInt:NSUnderlineStyleNone], NSUnderlineStyleAttributeName,
			nil];
}

+ (NSDictionary*)defaultChannelsListTextAttributes
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[self defaultTextColor], NSForegroundColorAttributeName,
			[self channelsListTextFont], NSFontAttributeName,
			[NSNumber numberWithInt:NSUnderlineStyleNone], NSUnderlineStyleAttributeName,
			nil];
}

#pragma mark -
#pragma mark Attribute/Code Conversions

+ (NSDictionary*)chatTextAttributeForCode:(uint8_t)attributeCode
{
	// Check if the code represents a color
	NSColor* color = [self chatTextColorForCode:attributeCode];
	if (color != nil)
	{
		return [NSDictionary dictionaryWithObject:color
										   forKey:NSForegroundColorAttributeName];
	}
	
	// Determine what the code represents
	switch (attributeCode)
	{
		case boldText:
			return [NSDictionary dictionaryWithObject:[self boldChatTextFont]
											   forKey:NSFontAttributeName];
		case italicText:
			return [NSDictionary dictionaryWithObject:[self italicChatTextFont]
											   forKey:NSFontAttributeName];
		case underlineText:
			return [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:(NSUnderlineStyleSingle | NSUnderlinePatternSolid)]
											   forKey:NSUnderlineStyleAttributeName];
	}
	
	NSLog(@"WARNING: invalid attribute code in iTetTextAttributes +textAttributeForCode: '%d'", attributeCode);
	
	return nil;
}

#pragma mark -
#pragma mark Colors

+ (NSColor*)defaultTextColor
{
	return [NSColor blackColor];
}

+ (NSColor*)localPlayerNameTextColor
{
	return [[NSColor purpleColor] blendedColorWithFraction:0.5 ofColor:[NSColor blackColor]];
}

+ (NSColor*)goodSpecialDescriptionTextColor
{
	return [[NSColor greenColor] blendedColorWithFraction:0.3 ofColor:[NSColor blackColor]];
}

+ (NSColor*)badSpecialDescriptionTextColor
{
	return [NSColor redColor];
}

+ (NSColor*)linesAddedDescriptionTextColor
{
	return [NSColor blueColor];
}

+ (NSColor*)chatTextColorForCode:(uint8_t)attributeCode
{
	switch (attributeCode)
	{
		case blackTextColor:
			return [NSColor blackColor];
			
		case whiteTextColor:
			return [NSColor whiteColor];
			
		case grayTextColor:
			return [NSColor grayColor];
			
		case silverTextColor:
			return iTetSilverTextColor;
			
		case redTextColor:
			return [NSColor redColor];
			
		case yellowTextColor:
			return [NSColor yellowColor];
			
		case limeTextColor:
			return [NSColor greenColor];
			
		case greenTextColor:
			return iTetGreenTextColor;
			
		case oliveTextColor:
			return iTetOliveTextColor;
			
		case tealTextColor:
			return iTetTealTextColor;
			
		case cyanTextColor:
			return [NSColor cyanColor];
			
		case blueTextColor:
			return [NSColor blueColor];
			
		case darkBlueTextColor:
			return iTetDarkBlueTextColor;
			
		case purpleTextColor:
			return [NSColor purpleColor];
			
		case maroonTextColor:
			return iTetMaroonTextColor;
			
		case magentaTextColor:
			return [NSColor magentaColor];
			
		default:
			break;
	}
	
	return nil;
}

+ (iTetTextColorAttribute)codeForChatTextColor:(NSColor*)color
{
	if ([color hasSameRGBValuesAsColor:[NSColor blackColor]])
		return blackTextColor;
	
	if ([color hasSameRGBValuesAsColor:[NSColor whiteColor]])
		return whiteTextColor;
	
	if ([color hasSameRGBValuesAsColor:[NSColor grayColor]])
		return grayTextColor;
	
	if ([color hasSameRGBValuesAsColor:iTetSilverTextColor])
		return silverTextColor;
	
	if ([color hasSameRGBValuesAsColor:[NSColor redColor]])
		return redTextColor;
	
	if ([color hasSameRGBValuesAsColor:[NSColor yellowColor]])
		return yellowTextColor;
	
	if ([color hasSameRGBValuesAsColor:[NSColor greenColor]])
		return limeTextColor;
	
	if ([color hasSameRGBValuesAsColor:iTetGreenTextColor])
		return greenTextColor;
	
	if ([color hasSameRGBValuesAsColor:iTetOliveTextColor])
		return oliveTextColor;
	
	if ([color hasSameRGBValuesAsColor:iTetTealTextColor])
		return tealTextColor;
	
	if ([color hasSameRGBValuesAsColor:[NSColor cyanColor]])
		return cyanTextColor;
	
	if ([color hasSameRGBValuesAsColor:[NSColor blueColor]])
		return blueTextColor;
	
	if ([color hasSameRGBValuesAsColor:iTetDarkBlueTextColor])
		return darkBlueTextColor;
	
	if ([color hasSameRGBValuesAsColor:[NSColor purpleColor]])
		return purpleTextColor;
	
	if ([color hasSameRGBValuesAsColor:iTetMaroonTextColor])
		return maroonTextColor;
	
	if ([color hasSameRGBValuesAsColor:[NSColor magentaColor]])
		return magentaTextColor;
	
	return noColor;
}

#pragma mark -
#pragma mark Fonts

NSString* const iTetChatTextFontName =	@"Helvetica";
#define iTetChatTextFontSize			(12.0)

+ (NSFont*)chatTextFontWithTraits:(NSFontTraitMask)fontTraits
{
	if (fontTraits & NSBoldFontMask)
	{
		if (fontTraits & NSItalicFontMask)
			return [self boldItalicChatTextFont];
		
		return [self boldChatTextFont];
	}
	
	if (fontTraits & NSItalicFontMask)
		return [self italicChatTextFont];
	
	return [self plainChatTextFont];
}

+ (NSFont*)plainChatTextFont
{
	return [NSFont fontWithName:iTetChatTextFontName
						   size:iTetChatTextFontSize];
}

+ (NSFont*)boldChatTextFont
{
	return [[NSFontManager sharedFontManager] convertFont:[self plainChatTextFont]
											  toHaveTrait:NSBoldFontMask];
}

+ (NSFont*)italicChatTextFont
{
	return [[NSFontManager sharedFontManager] convertFont:[self plainChatTextFont]
											  toHaveTrait:NSItalicFontMask];
}

+ (NSFont*)boldItalicChatTextFont
{
	return [[NSFontManager sharedFontManager] convertFont:[self plainChatTextFont]
											  toHaveTrait:(NSBoldFontMask | NSItalicFontMask)];
}

NSString* const iTetGameActionsTextFontName =	@"Lucida Grande";
#define iTetGameActionsTextFontSize				(12.0)

+ (NSFont*)gameActionsTextFont
{
	return [NSFont fontWithName:iTetGameActionsTextFontName
						   size:iTetGameActionsTextFontSize];
}

NSString* const iTetChannelsListTextFontName =	@"Lucida Grande";
#define iTetChannelsListTextFontSize			(13.0)

+ (NSFont*)channelsListTextFont
{
	return [NSFont fontWithName:iTetChannelsListTextFontName
						   size:iTetChannelsListTextFontSize];
}

#pragma mark -
#pragma mark Text Attribute Character Set

+ (NSCharacterSet*)chatTextAttributeCharacterSet
{
	@synchronized(self)
	{
		if (iTetTextAttributeCharacterSet == nil)
		{
			iTetTextAttributeCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:[self chatTextAttributeCharactersString]] retain];
		}
	}
	
	return iTetTextAttributeCharacterSet;
}

+ (NSString*)chatTextAttributeCharactersString
{
	NSMutableString* attributeChars = [NSMutableString string];
	
	for (char c = 0; c <= ITET_HIGHEST_ATTR_CODE; c++)
	{
		switch (c)
		{
			case blackTextColor:
			case whiteTextColor:
			case grayTextColor:
			case silverTextColor:
			case redTextColor:
			case yellowTextColor:
			case limeTextColor:
			case greenTextColor:
			case oliveTextColor:
			case tealTextColor:
			case cyanTextColor:
			case blueTextColor:
			case darkBlueTextColor:
			case purpleTextColor:
			case maroonTextColor:
			case magentaTextColor:
			case italicText:
			case underlineText:
			case boldText:
				[attributeChars appendFormat:@"%c", c];
				break;
			
			case noColor:
				break;
		}
	}
	
	return [NSString stringWithString:attributeChars];
}

@end
