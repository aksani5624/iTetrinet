//
//  iTetThemesViewController.m
//  iTetrinet
//
//  Created by Alex Heinz on 7/4/09.
//

#import "iTetThemesViewController.h"
#import "iTetThemesArrayController.h"
#import "iTetTheme.h"

@implementation iTetThemesViewController

- (id)init
{
	if (![super initWithNibName:@"ThemesPrefsView" bundle:nil])
		return nil;
	
	[self setTitle:@"Themes"];
	
	return self;
}

#pragma mark -
#pragma mark Interface Actions

- (IBAction)addTheme:(id)sender
{
	// Open an "open file" sheet
	NSOpenPanel* openSheet = [NSOpenPanel openPanel];
	
	// Configure the panel
	[openSheet setCanChooseFiles:YES];
	[openSheet setCanChooseDirectories:NO];
	[openSheet setResolvesAliases:YES];
	[openSheet setAllowsMultipleSelection:NO];
	[openSheet setAllowsOtherFileTypes:NO];
	
	// Run the panel
	[openSheet beginSheetForDirectory:nil
								 file:nil
								types:[NSArray arrayWithObject:@"cfg"]
					   modalForWindow:[[self view] window]
						modalDelegate:self
					   didEndSelector:@selector(openSheetDidEnd:returnCode:contextInfo:)
						  contextInfo:NULL];
}

- (void)openSheetDidEnd:(NSOpenPanel*)openSheet
			 returnCode:(NSInteger)returnCode
			contextInfo:(void*)contextInfo
{
	if (returnCode != NSOKButton)
		return;
	
	// Get the selected theme file path
	NSString* themeFile = [[openSheet filenames] objectAtIndex:0];
	
	// Attempt to create the theme from the selected file
	iTetTheme* newTheme = [iTetTheme themeFromThemeFile:themeFile];
	if (newTheme == nil)
	{
		// Create an alert
		NSAlert* alert = [[NSAlert alloc] init];
		
		// Configure with the error message
		[alert setMessageText:@"Could not load theme"];
		[alert setInformativeText:[NSString stringWithFormat:@"Unable to load a theme from the file %@. Check that the file is a valid theme file, and that the image specified by \'Blocks=\' in the theme file is in the same directory as the file.", themeFile]];
		[alert addButtonWithTitle:@"Okay"];
		
		// Dismiss the old sheet
		[openSheet orderOut:self];
		
		// Run the alert
		[alert beginSheetModalForWindow:[[self view] window]
						  modalDelegate:self
						 didEndSelector:@selector(themeErrorAlertEnded:returnCode:contextInfo:)
							contextInfo:NULL];
		return;
	}
	
	// Check if the theme is a duplicate of the default theme
	if ([newTheme isEqual:[iTetTheme defaultTheme]])
	{
		// Create an alert
		NSAlert* alert = [[NSAlert alloc] init];
		
		// Configure with the error message
		[alert setMessageText:@"Duplicate theme"];
		[alert setInformativeText:[NSString stringWithFormat:@"The theme \'%@\' appears to be a duplicate of the default iTetrinet theme. If you would like to use this theme, try changing its name. (To change the theme's name, open the theme file using your text editor of choice, and change the text after \'Name=\'.)", [newTheme name]]];
		[alert addButtonWithTitle:@"Okay"];
		
		// Dismiss the old sheet
		[openSheet orderOut:self];
		
		// Run the alert
		[alert beginSheetModalForWindow:[[self view] window]
						  modalDelegate:self
						 didEndSelector:@selector(themeErrorAlertEnded:returnCode:contextInfo:)
							contextInfo:NULL];
		return;
	}
	
	// Check for other duplicate themes
	NSArray* themeList = [[iTetPreferencesController preferencesController] themeList];
	if ([themeList containsObject:newTheme])
	{
		// Create an alert
		NSAlert* alert = [[NSAlert alloc] init];
		
		// Configure with the error message
		[alert setMessageText:@"Duplicate theme"];
		[alert setInformativeText:[NSString stringWithFormat:@"A theme named \'%@\' is already installed. Would you like the replace the existing theme with the new one?", [newTheme name]]];
		[alert addButtonWithTitle:@"Replace"];
		[alert addButtonWithTitle:@"Cancel"];
		
		// Dismiss the old sheet
		[openSheet orderOut:self];
		
		// Run the alert
		[alert beginSheetModalForWindow:[[self view] window]
						  modalDelegate:self
						 didEndSelector:@selector(duplicateThemeAlertEnded:returnCode:theme:)
							contextInfo:[newTheme retain]];
		return;
	}
	
	// Add the new theme to the list
	[themesArrayController addObject:newTheme];
	
	// FIXME: copy theme to Application Support directory
}

- (IBAction)chooseTheme:(id)sender
{
	// Change the current theme
	[PREFS setCurrentTheme:[themesArrayController selectedTheme]];
}

#pragma mark -
#pragma mark Error Sheet Callbacks

- (void)themeErrorAlertEnded:(NSAlert*)alert
				  returnCode:(NSInteger)returnCode
				 contextInfo:(void*)contextInfo
{
	// Does nothing
}

- (void)duplicateThemeAlertEnded:(NSAlert*)alert
					  returnCode:(NSInteger)returnCode
						   theme:(iTetTheme*)newTheme
{
	// Balance the retain used to hold onto the theme
	[newTheme autorelease];
	
	// If the user pressed "cancel", do nothing
	if (returnCode == NSAlertSecondButtonReturn)
	{
		return;
	}
	
	// If the user chose to replace the existing theme, remove it
	// (Themes are compared by name, so this will remove the old theme)
	[themesArrayController removeObject:newTheme];
	
	// Add the new theme
	[themesArrayController addObject:newTheme];
}

@end
