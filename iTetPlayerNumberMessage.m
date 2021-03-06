//
//  iTetPlayerNumberMessage.m
//  iTetrinet
//
//  Created by Alex Heinz on 3/3/10.
//

#import "iTetPlayerNumberMessage.h"
#import "NSString+MessageData.h"

@implementation iTetPlayerNumberMessage

#pragma mark -
#pragma mark iTetIncomingMessage Protocol Initializers

+ (id)messageWithMessageData:(NSData*)messageData
{
	return [[[self alloc] initWithMessageData:messageData] autorelease];
}

- (id)initWithMessageData:(NSData*)messageData
{
	messageType = playerNumberMessage;
	
	// Convert the message data to a string
	NSString* rawMessage = [NSString stringWithMessageData:messageData];
	
	// Read the player number as an integer
	playerNumber = [rawMessage integerValue];
	
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize playerNumber;

@end
