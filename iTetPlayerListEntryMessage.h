//
//  iTetPlayerListEntryMessage.h
//  iTetrinet
//
//  Created by Alex Heinz on 4/13/10.
//

#import <Cocoa/Cocoa.h>
#import "iTetMessage.h"

@interface iTetPlayerListEntryMessage : iTetMessage <iTetIncomingMessage>
{
	NSString* nickname;
	NSString* teamName;
	NSString* version;
	NSInteger playerNumber;
	NSInteger state;
	NSInteger authLevel;
	NSString* channelName;
}

@property (readonly) NSString* nickname;
@property (readonly) NSString* teamName;
@property (readonly) NSString* version;
@property (readonly) NSInteger playerNumber;
@property (readonly) NSInteger state;
@property (readonly) NSInteger authLevel;
@property (readonly) NSString* channelName;

@end
