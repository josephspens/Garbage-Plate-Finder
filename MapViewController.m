//
//  MapViewController.m
//  GPF-4
//
//  Created by Joseph P Spens on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "Restaurant.h"

@implementation MapViewController

@synthesize restaurants, restaurantDictionary;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

#pragma mark -
#pragma mark MKMapViewDelegate Methods


// This delegate method is called once for every annotation that is created.
// If no view is returned by this method, then only the default pin is seen by the user
- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation{
	MKAnnotationView *view = nil;
	if(annotation != map.userLocation) {
		// if it's NOT the user's current location pin, create the annotation
		Restaurant *restaurantAnnotation = (Restaurant*)annotation;
		// Look for an existing view to reuse
		view = [mv dequeueReusableAnnotationViewWithIdentifier:@"restaurantAnnotation"];
		// If an existing view is not found, create a new one
		if(view == nil) {
			view = [[[MKPinAnnotationView alloc] initWithAnnotation:restaurantAnnotation
													reuseIdentifier:@"restaurantAnnotation"] autorelease];
		}
		
		// Now we have a view for the annotation, so let's set some properties
		[(MKPinAnnotationView *)view setPinColor:MKPinAnnotationColorRed];
		[(MKPinAnnotationView *)view setAnimatesDrop:YES];
		[view setCanShowCallout:YES];
		
		// Now create buttons for the annotation view
		// The 'tag' properties are set so that we can identify which button was tapped later
		UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
		leftButton.tag = 0;
		UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		rightButton.tag = 1;
		
		// Add buttons to annotation view
		[view setLeftCalloutAccessoryView:leftButton];
		[view setRightCalloutAccessoryView:rightButton];
	}
	
	// send this annotation view back to MKMapView so it can add it to the pin 
	return view;
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views{
	MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate],20000,20000);
	[mv setRegion:region animated:YES];
}

// This method is called when one of the two buttons added to the annotation view is tapped
- (void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	Restaurant *restaurantAnnotation = (Restaurant *)[view annotation];
	switch ([control tag]) {
		case 0: // left button
		{
			NSURL *url = [NSURL URLWithString:restaurantAnnotation.url];
			[[UIApplication sharedApplication] openURL:url];
		}
			break;
			
		case 1: // right button
		{
			//NSString *latlong = [NSString stringWithFormat:@"%f,%f",restaurantAnnotation.coordinate.latitude,restaurantAnnotation.coordinate.longitude];
			//NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?ll=%@", [latlong stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			// build a maps url. This will launch the Maps app on the hardware, and the google maps website in the simulator
			NSString *url2 = [NSString stringWithFormat: @"http://maps.google.com/maps?daddr=%@", [restaurantAnnotation.address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url2]];
		}
			break;
		default:
			NSLog(@"Should not be here in calloutAccessoryControlTapped, tag=%d!",[control tag]);
			break;
	}
	// Reference
	// http://developer.apple.com/library/ios/#featuredarticles/iPhoneURLScheme_Reference/Articles/MapLinks.html
	// http://stackoverflow.com/questions/30058/how-can-i-launch-the-google-maps-iphone-application-from-within-my-own-native-app
}

- (IBAction)reloadMe {
	NSLog(@"reloadMe");
	//NSLog(@"%@",[tabBarController.viewControllers objectAtIndex:0]);
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([map.userLocation coordinate],20000,20000);
	[map setRegion:region animated:YES];
}

- (void)reloadYou:(CLLocation *)location {
	NSLog(@"reloadMe");
	//NSLog(@"%@",[tabBarController.viewControllers objectAtIndex:0]);
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([location coordinate],2500,2500);
	[map setRegion:region animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
	NSLog(@"%@",newLocation);
	NSLog(@"Heading: %@",[locationManager heading]);
	NSLog(@"Heading: %@",[manager heading]);
	
	// How many seconds ago was this new location created?
	NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
	// CLLocation Managers will return the last found location of the
	// device first, you don't want that data in this case.
	// If this location was made more than 3 minutes ago, ignore it.
	if(t<-180){
		// This is cached data, you don't want it, keep looking
		return;
	}	
	
	[self foundLocation];
}

- (void)findLocation{
	[locationManager startUpdatingHeading];
	[indicator startAnimating];
}

- (void)foundLocation{
	[indicator stopAnimating];
	[locationManager stopUpdatingLocation];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	for (int i=0; i<[[restaurantDictionary objectForKey:@"restaurants"] count]; i++) {
		[map addAnnotation:[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:i]];
	}
		
	locationManager = [[CLLocationManager alloc] init];
	[locationManager setDelegate:self];
	[locationManager setDistanceFilter:kCLDistanceFilterNone];
	[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	[map setShowsUserLocation:YES];
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
    [super dealloc];
}


@end
