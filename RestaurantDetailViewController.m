//
//  RestaurantDetailViewController.m
//  GPF-4
//
//  Created by Joseph P Spens on 10/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RestaurantDetailViewController.h"


@implementation RestaurantDetailViewController

@synthesize nameText, phoneText, addressText, urlText, distanceText;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	name.text = nameText;
	phone.text = phoneText;
	address.text = addressText;
	url.text = urlText;
	distance.text = distanceText;
    [super viewDidLoad];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[nameText release];
	[phoneText release];
	[addressText release];
	[urlText release];
	[distanceText release];
    [super dealloc];
}


@end
