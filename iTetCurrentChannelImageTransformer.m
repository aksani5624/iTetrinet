//
//  iTetCurrentChannelImageTransformer.m
//  iTetrinet
//
//  Created by Alex Heinz on 4/14/10.
//

#import "iTetCurrentChannelImageTransformer.h"

NSString* const iTetCurrentChannelImageTransformerName = @"TetrinetCurrentChannelTransformer";

@implementation iTetCurrentChannelImageTransformer

+ (Class)transformedValueClass
{
	return [NSImage class];
}

+ (BOOL)allowsReverseTransformation
{
	return NO;
}

NSString* const iTetCurrentChannelImageName =		@"Current Channel Icon";

- (id)transformedValue:(id)value
{
	// Check that the value to transform is an NSNumber or subclass thereof
	if (![value isKindOfClass:[NSNumber class]])
		return nil;
	
	// If the value is "true", return the image; otherwise, return nothing
	if ([value boolValue])
		return [NSImage imageNamed:iTetCurrentChannelImageName];
	
	return nil;
}

@end
