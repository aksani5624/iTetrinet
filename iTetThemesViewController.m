//
//  iTetThemesViewController.m
//  iTetrinet
//
//  Created by Alex Heinz on 7/4/09.
//

#import "iTetThemesViewController.h"
#import "iTetThemesArrayController.h"
#import "iTetTheme.h"

#import "iTetUserDefaults.h"
#import "NSUserDefaults+AdditionalTypes.h"

@interface iTetThemesViewController (Private)

- (void)addThemeToThemesArrayController:(iTetTheme*)theme;

@end

@implementation iTetThemesViewController

- (id)init
{
	if (![super initWithNibName:@"ThemesPrefsView" bundle:nil])
		return nil;
	
	[self setTitle:@"Themes"];
	
	// Make note of the currently selected index in user defaults
	initialThemeSelection = [[NSUserDefaults standardUserDefaults] unarchivedObjectForKey:iTetThemesSelectionPrefKey];
	if ([initialThemeSelection count] == 1)
		[initialThemeSelection retain];
	else
		initialThemeSelection = [[NSIndexSet alloc] initWithIndex:0];
	
	return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	// Re-select the saved selection indexes
	[themesTableView selectRowIndexes:initialThemeSelection
				 byExtendingSelection:NO];
	
	// Scroll the tableview to show the selection
	[themesTableView scrollRowToVisible:[initialThemeSelection firstIndex]];
}

- (void)dealloc
{
	[initialThemeSelection release];
	
	[super dealloc];
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
	if ((id)newTheme == [NSNull null])
	{
		// Create an alert
		NSAlert* alert = [[NSAlert alloc] init];
		
		// Configure with the error message
		[alert setMessageText:@"Could not load theme"];
		[alert setInformativeText:[NSString stringWithFormat:@"Unable to load a theme from the file '%@'. Check that the file is a valid theme file, and that the image specified by 'Blocks=' in the theme file is in the same directory as the file.", themeFile]];
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
	if ([[iTetTheme defaultThemes] containsObject:newTheme])
	{
		// Create an alert
		NSAlert* alert = [[NSAlert alloc] init];
		
		// Configure with the error message
		[alert setMessageText:@"Duplicate theme"];
		[alert setInformativeText:[NSString stringWithFormat:@"The theme '%@' appears to be a duplicate of one of the default iTetrinet themes. If you would like to use this theme, try changing its name. (To change the theme's name, open the theme file using your text editor of choice, and change the text after 'Name=')", [newTheme themeName]]];
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
	NSArray* themeList = [themesArrayController content];
	if ([themeList containsObject:newTheme])
	{
		// Create an alert
		NSAlert* alert = [[NSAlert alloc] init];
		
		// Configure with the error message
		[alert setMessageText:@"Duplicate theme"];
		[alert setInformativeText:[NSString stringWithFormat:@"A theme named '%@' is already installed. Would you like the replace the existing theme with the new one?", [newTheme themeName]]];
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
	
	// Add the new theme
	[self addThemeToThemesArrayController:newTheme];
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
		return;
	
	// If the user chose to replace the existing theme, remove it
	// (Themes are compared by name, so this will remove the old theme)
	[themesArrayController removeObject:newTheme];
	
	// Add the new theme
	[self addThemeToThemesArrayController:newTheme];
}

#pragma mark -
#pragma mark Adding Themes

- (void)addThemeToThemesArrayController:(iTetTheme*)theme
{
	// Add theme to list
	[themesArrayController addObject:theme];
	
	// Select and show the new theme
	NSUInteger index = [[themesArrayController arrangedObjects] indexOfObject:theme];
	[themesTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:index]
				 byExtendingSelection:NO];
	[themesTableView scrollRowToVisible:index];
}

@end
