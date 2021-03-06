//
//  iTetThemesViewController.h
//  iTetrinet
//
//  Created by Alex Heinz on 7/4/09.
//

#import <Cocoa/Cocoa.h>
#import "iTetPreferencesViewController.h"

@class iTetThemesArrayController;

@interface iTetThemesViewController : iTetPreferencesViewController
{
	IBOutlet iTetThemesArrayController* themesArrayController;
	IBOutlet NSTableView* themesTableView;
	NSIndexSet* initialThemeSelection;
}

- (IBAction)addTheme:(id)sender;

@end
