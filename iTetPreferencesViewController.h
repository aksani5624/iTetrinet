//
//  iTetPreferencesViewController.h
//  iTetrinet
//
//  Created by Alex Heinz on 11/23/09.
//

#import <Cocoa/Cocoa.h>
#import "iTetPreferencesWindowController.h"

@interface iTetPreferencesViewController : NSViewController

+ (id)viewController;

- (BOOL)viewShouldBeSwappedForView:(iTetPreferencesViewController*)newController
				byWindowController:(iTetPreferencesWindowController*)sender;
- (BOOL)windowShouldClose:(id)window;
- (void)viewWillBeRemoved:(id)sender;
- (void)viewWasSwappedIn:(id)sender;

@end
