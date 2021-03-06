//
//  iTetThemesSupportDirectory.m
//  iTetrinet
//
//  Created by Alex Heinz on 4/21/10.
//

#import "iTetThemesSupportDirectory.h"
#import "IPSApplicationSupportDirectory.h"

@implementation iTetThemesSupportDirectory

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	[self release];
	return nil;
}

NSString* const iTetApplicationSupportThemesSubdirectoryName =	@"Themes";

+ (NSString*)pathToSupportDirectoryForTheme:(NSString*)themeName
						  createIfNecessary:(BOOL)createDirectory
									  error:(NSError**)error
{
	// Get the path to the user's "Application Support" directory
	NSString* appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
	NSError* appSupportError;
	NSString* appSupportPath = [IPSApplicationSupportDirectory applicationSupportDirectoryPathForApp:appName
																							   error:&appSupportError];
	
	// Check that the app support path is valid
	if (appSupportPath == nil)
	{
		// If an error pointer has been provided, create an error
		if (error != NULL)
		{
			// Create a user info dictionary
			NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
									  @"Couldn't get path to Application Support directory", NSLocalizedDescriptionKey,
									  appSupportError, NSUnderlyingErrorKey,
									  nil];
			
			// Create the error
			*error = [NSError errorWithDomain:NSCocoaErrorDomain
										 code:NSFileNoSuchFileError
									 userInfo:userInfo];
		}
		
		return nil;
	}
	
	// Create the full path to the subdirectory for this theme
	NSString* fullPath = [appSupportPath stringByAppendingPathComponent:iTetApplicationSupportThemesSubdirectoryName];
	fullPath = [fullPath stringByAppendingPathComponent:themeName];
	
	// If the path exists, return immediately
	NSFileManager* fileManager = [[[NSFileManager alloc] init] autorelease];
	if ([fileManager fileExistsAtPath:fullPath])
		return fullPath;
	
	// If we have been asked not to create non-existent directories, return nil
	if (!createDirectory)
		return nil;
	
	// Attempt to create the subdirectory
	NSError* creationError;
	BOOL createdSuccessfully = [fileManager createDirectoryAtPath:fullPath
									  withIntermediateDirectories:YES
													   attributes:nil
															error:&creationError];
	
	// If the directory could not be created, return nil
	if (!createdSuccessfully)
	{
		// If an error pointer was provided, create an error
		if (error != NULL)
		{
			// Create a user info dictionary
			NSString* desc = [NSString stringWithFormat:@"Unable to create subdirectory for theme '%@'", themeName];
			NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
									  desc, NSLocalizedDescriptionKey,
									  creationError, NSUnderlyingErrorKey,
									  fullPath, NSFilePathErrorKey,
									  nil];
			
			// Create the error
			*error = [NSError errorWithDomain:NSCocoaErrorDomain
										 code:NSFileNoSuchFileError
									 userInfo:userInfo];
		}
		
		return nil;
	}
	
	// Return the path to the created directory
	return fullPath;
}

@end
