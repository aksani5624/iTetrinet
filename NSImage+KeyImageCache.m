//
//  NSImage+KeyImageCache.m
//  iTetrinet
//
//  Created by Alex Heinz on 11/21/09.
//

#import "NSImage+KeyImageCache.h"
#import "NSMutableDictionary+CacheDictionary.h"

NSMutableDictionary* keyImageCache = nil;

@interface NSImage (KeyImageCachePrivate)

+ (NSMutableDictionary*)keyImageChache;

@end

@implementation NSImage (KeyImageCache)

+ (void)setImage:(NSImage*)image
		  forKey:(iTetKeyNamePair*)key
{
	[[self keyImageChache] setObject:image
							  forKey:key];
}

+ (NSImage*)imageForKey:(iTetKeyNamePair*)key
{
	return [[self keyImageChache] objectForKey:key];
}

+ (NSMutableDictionary*)keyImageChache
{
	@synchronized(self)
	{
		if (keyImageCache == nil)
		{
			keyImageCache = [NSMutableDictionary cacheDictionary];
		}
	}
	
	return keyImageCache;
}

@end
