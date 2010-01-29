//
//  iTetLocalPlayer.h
//  iTetrinet
//
//  Created by Alex Heinz on 1/28/10.
//

#import <Cocoa/Cocoa.h>
#import "iTetPlayer.h"

@class iTetBlock;
@class Queue;

@interface iTetLocalPlayer : iTetPlayer
{
	iTetBlock* currentBlock;
	iTetBlock* nextBlock;
	Queue* specialsQueue;
	
	NSInteger linesCleared;
	NSInteger linesSinceLastLevel;
	NSInteger linesSinceLastSpecials;
}

- (void)addLines:(NSInteger)lines;

@property (readwrite, retain) iTetBlock* currentBlock;
@property (readwrite, retain) iTetBlock* nextBlock;
@property (readwrite, retain) Queue* specialsQueue;
@property (readwrite, assign) NSInteger linesCleared;
@property (readwrite, assign) NSInteger linesSinceLastLevel;
@property (readwrite, assign) NSInteger linesSinceLastSpecials;

@end