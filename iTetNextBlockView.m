//
//  iTetNextBlockView.m
//  iTetrinet
//
//  Created by Alex Heinz on 6/5/09.
//

#import "iTetNextBlockView.h"
#import "iTetBlock.h"
#import "iTetBlock+Drawing.h"

@implementation iTetNextBlockView

+ (void)initialize
{
	[self exposeBinding:@"block"];
}

- (void)dealloc
{
	[block release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(NSRect)rect
{
	// Check that there is a block to draw
	if ([self block] == nil)
		return;
	
	// Ask the block to draw itself to an NSImage
	NSImage* blockImage = [[self block] previewImageWithTheme:[self theme]];
	
	// Center the image in the view
	NSSize viewSize = [self bounds].size;
	NSSize imageSize = [blockImage size];
	NSPoint drawPoint = NSMakePoint(((viewSize.width - imageSize.width) / 2), ((viewSize.height - imageSize.height) / 2));
	
	// Draw the image
	[blockImage drawAtPoint:drawPoint
				   fromRect:NSZeroRect
				  operation:NSCompositeSourceOver
				   fraction:1.0];
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isOpaque
{
	return NO;
}

- (void)setBlock:(iTetBlock*)newBlock
{
	[self willChangeValueForKey:@"block"];
	[block autorelease];
	block = [newBlock copy];
	[self didChangeValueForKey:@"block"];
	
	[self setNeedsDisplay:YES];
}
@synthesize block;

@end
