//
//  MapViewController.h
//  GPF-4
//
//  Created by Joseph P Spens on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<UIApplicationDelegate, MKMapViewDelegate, CLLocationManagerDelegate> {
	IBOutlet MKMapView *map;
	IBOutlet UIActivityIndicatorView *indicator;
	IBOutlet UIToolbar *toolbar;
		
	CLLocationManager *locationManager;
	NSMutableArray *restaurants;
	NSMutableDictionary *restaurantDictionary;
}

@property (nonatomic, retain) NSMutableArray *restaurants;
@property (nonatomic, retain) NSMutableDictionary *restaurantDictionary;

- (IBAction)reloadMe;
- (void)reloadYou:(CLLocation *)location;
- (void)findLocation;
- (void)foundLocation;

@end
