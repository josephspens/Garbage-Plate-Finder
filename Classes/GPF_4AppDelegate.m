//
//  GPF_4AppDelegate.m
//  GPF-4
//
//  Created by Joseph P Spens on 10/18/10.
//  Assisted by Tony Jefferson on 10/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GPF_4AppDelegate.h"
#import "Restaurant.h"
#import "MapViewController.h"
#import "RestaurantsTableViewController.h"
#import "FavoritesTableViewController.h"
#import "AboutViewController.h"

@implementation GPF_4AppDelegate

@synthesize window,restaurantDictionary;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	//NSLog(@"didFinishLaunchingWithOptions");
	
	// load data
	[self loadData];
	
	// Create TabBar
	tabBarController = [[UITabBarController alloc] init];
	
	// Create ViewControllers
	// Map
	MapViewController *mapVC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
	mapVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map" image:[UIImage imageNamed:@"73-radar.png"] tag:0];
	mapVC.restaurantDictionary = self.restaurantDictionary;
	
	// Restaurant View
	RestaurantsTableViewController *restaurantVC = [[RestaurantsTableViewController alloc] initWithStyle:UITableViewStylePlain];
	restaurantVC.restaurantDictionary = self.restaurantDictionary;
	restaurantVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Restaurants" image:[UIImage imageNamed:@"48-fork-and-knife.png"] tag:1];
	UINavigationController *restaurantNavController = [[UINavigationController alloc] initWithRootViewController:restaurantVC];
	
	// Favorites View
	FavoritesTableViewController *favoritesVC = [[FavoritesTableViewController alloc] initWithStyle:UITableViewStylePlain];
	favoritesVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Favorites" image:[UIImage imageNamed:@"28-star.png"] tag:2];
	UINavigationController *favoritesNavController = [[UINavigationController alloc] initWithRootViewController:favoritesVC];
	
	// About Table View
	AboutViewController *aboutVC = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
	aboutVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"About" image:[UIImage imageNamed:@"06-magnifying-glass.png"] tag:3];
	
	tabBarController.viewControllers = [NSArray arrayWithObjects:mapVC,restaurantNavController,favoritesNavController,aboutVC,nil];
	
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
    
    return YES;
}

#pragma mark -
#pragma mark Helper Methods
-(void)loadData{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
	NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:path];
	//NSString *path = [[NSBundle bundleWithURL:@"http://people.rit.edu/~acjvks/plates/plates.php?format=plist"] pathForResource:@"data" ofType:@"plist"];
	//NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:@"http://people.rit.edu/~acjvks/plates/plates.php?format=plist"];
	
	NSMutableArray *restaurants = [[NSMutableArray alloc] init];
	for (NSDictionary *dict in [data objectForKey:@"restaurants"]) {
		NSArray *splitArray = [[dict objectForKey:@"location"] componentsSeparatedByString:@","];
		float latitude = [[splitArray objectAtIndex:0] floatValue];
		float longitude = [[splitArray objectAtIndex:1] floatValue];
		
		CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
		Restaurant *restaurant = [[Restaurant alloc] initWithID:[[dict objectForKey:@"restaurantID"] integerValue] 
														   name:[dict objectForKey:@"name"] 
														address:[dict objectForKey:@"address"]  
															url:[dict objectForKey:@"url"] 
														 rating:[[dict objectForKey:@"rating"] floatValue]
													   location:location
														  title:[dict objectForKey:@"name"]
													  plateName:[dict objectForKey:@"plateName"]  
													phoneNumber:[dict objectForKey:@"phoneNumber"]  
													 lastUpdate:[dict objectForKey:@"lastUpdate"]];
		// MKAnnotation Stuff
		restaurant.coordinate = location.coordinate;
		
		//Add to array
		[restaurants addObject:restaurant];
		
		// clean up
		[restaurant release];
		[location release];
	}
	
	for (int i=0; i<[restaurants count]-1; i++) {
		[[restaurants objectAtIndex:i] compareName:[[[restaurants objectAtIndex:i+1] name] characterAtIndex:0]];
	}
	
	self.restaurantDictionary = [NSMutableDictionary dictionary];
	[self.restaurantDictionary setObject:restaurants forKey:@"restaurants"];
	//[self.restaurantDictionary setObject:date forKey:@"lastModified"];
	//NSLog(@"self.restaurantDictionary=%@",self.restaurantDictionary);
	
	[data release];
	[restaurants release];
}

#pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application {
	NSLog(@"applicationWillResignActive");
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	NSLog(@"applicationDidEnterBackground");
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	NSLog(@"applicationWillEnterForeground");
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	NSLog(@"applicationDidBecomeActive");
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
	NSLog(@"applicationWillTerminate");
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	NSLog(@"applicationDidReceiveMemoryWarning");
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
	[restaurantDictionary release];
    [super dealloc];
}


@end
