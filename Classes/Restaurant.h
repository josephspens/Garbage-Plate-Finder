//
//  Restaurant.h
//  GPF-1
//
//  Created by Joe Spens on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Restaurant : NSObject <MKAnnotation>{
	int restaurantID;
	NSString *name;
	NSString *address;
	NSString *url;
	float rating;
	CLLocation *location;
	NSString *plateName;
	NSString *phoneNumber;
	NSDate *lastUpdate;
	NSString *title;
	CLLocationCoordinate2D coordinate;
}
+ (id)restaurant;
- (id)initWithID:(int)r_ID
			name:(NSString *)r_name
		 address:(NSString *)r_address
			 url:(NSString *)r_url
		  rating:(float)r_rating
		location:(CLLocation *)r_location
		   title:(NSString *)r_title
	   plateName:(NSString *)r_plateName
	 phoneNumber:(NSString *)r_phoneNumber
	  lastUpdate:(NSDate *)r_lastUpdate;
- (NSInteger)compareName:(char)restaurantName;

@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,assign)int restaurantID;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,assign)float rating;
@property(nonatomic,retain)CLLocation *location;
@property(nonatomic,copy)NSString *plateName;
@property(nonatomic,copy)NSString *phoneNumber;
@property(nonatomic,retain)NSDate *lastUpdate;

@end
