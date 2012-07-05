//
//  Restaurant.m
//  GPF-1
//
//  Created by Joe Spens on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Restaurant.h"


@implementation Restaurant

+ (id)restaurant{
	Restaurant *newRestaurant = [[self alloc] init];
	return [newRestaurant autorelease];
}

@synthesize restaurantID, name, address, url, rating, location, plateName, phoneNumber, lastUpdate, coordinate, title;

- (id)init{
	return [self initWithID:-1
					   name:@"TBD"
					address:@"TBD"
						url:@"TBD"
					 rating:-1.0
				   location:nil
					  title:@"TBD"
				  plateName:@"Unknown plate name"
				phoneNumber:@"Unknown phone number"
				 lastUpdate:nil];
}

- (id)initWithID:(int)r_ID
			name:(NSString *)r_name
		 address:(NSString *)r_address
			 url:(NSString *)r_url
		  rating:(float)r_rating
		location:(CLLocation *)r_location
		   title:(NSString *)r_title
	   plateName:(NSString *)r_plateName
	 phoneNumber:(NSString *)r_phoneNumber
	  lastUpdate:(NSDate *)r_lastUpdate{
	// Call the superclass's designated initializer
	[super init];
	
	// Give the instance variables initial values
	[self setRestaurantID:r_ID];
	[self setName:r_name];
	[self setAddress:r_address];
	[self setUrl:r_url];
	[self setRating:r_rating];
	[self setLocation:r_location];
	[self setCoordinate:[r_location coordinate]];
	[self setTitle:r_title];
	[self setPlateName:r_plateName];
	[self setPhoneNumber:r_phoneNumber];
	[self setLastUpdate:r_lastUpdate];
	
	// Return the address of hte newly initialized object
	return self;
}

- (void)dealloc{
	[name release];
	[address release];
	[url release];
	[location release];
	[title release];
	[plateName release];
	[phoneNumber release];
	[lastUpdate release];
	[super dealloc];
	NSLog(@"dealloc called for id=%d",restaurantID);
}

- (void)setRestaurantID:(int)value{
	if (value < 0){
		restaurantID = 0;
		NSLog(@"Bad value of %d in setRestaurantID: - setting to 0",value);
	}
	else restaurantID = value;
}

- (void)setRating:(float)value{
	if(value >= 0.0 && value <= 5.0)
		rating = value;
	else{
		NSLog(@"Bad value of %f in setRating: - setting to 0.0",value);
		rating = 0.0;		
	}
}

- (NSString *)description{
	NSString *descriptionString =
	[[NSString alloc] initWithFormat:@"id=%d, name=%@, address=%@, url=%@, rating=%f, location=%@, title=%@, plateName=%@, phoneNumber=%@, lastUpdate=%@",
						restaurantID,
						name,
						address,
						url,
						rating,
						location,
						title,
						plateName,
						phoneNumber,
						lastUpdate];
	return [descriptionString autorelease];
}

- (NSInteger)compareName:(char)restaurantName {
	NSLog(@"compareName");
	NSLog(@"%d",[[self name] characterAtIndex:0]);
	NSLog(@"%d",restaurantName);
	if([[self name] characterAtIndex:0] < restaurantName)
		return NSOrderedAscending;
	else if ([[self name] characterAtIndex:0] == restaurantName)
		return NSOrderedSame;
	else
		return NSOrderedDescending;
}

@end
