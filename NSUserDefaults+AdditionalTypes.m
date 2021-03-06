//
//  NSUserDefaults+AdditionalTypes.m
//  iTetrinet
//
//  Created by Alex Heinz on 4/23/10.
//

#import "NSUserDefaults+AdditionalTypes.h"

@implementation NSUserDefaults (AdditionalTypes)

- (void)archiveAndSetObject:(id)object
					 forKey:(NSString*)key
{
	[self setObject:[NSKeyedArchiver archivedDataWithRootObject:object]
			 forKey:key];
}

- (id)unarchivedObjectForKey:(NSString*)key
{
	NSData* archivedData = [self objectForKey:key];
	
	if (archivedData == nil)
		return nil;
	
	return [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
}

- (void)setUnsignedInteger:(NSUInteger)value
					forKey:(NSString*)key
{
	[self setObject:[NSNumber numberWithUnsignedInteger:value]
			 forKey:key];
}

- (NSUInteger)unsignedIntegerForKey:(NSString*)key
{
	return [[self objectForKey:key] unsignedIntegerValue];
}

@end
