//
//  GPF_4AppDelegate.h
//  GPF-4
//
//  Created by Joseph P Spens on 10/18/10.
//  Assisted by Tony Jefferson on 10/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GPF_4AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	NSMutableDictionary *restaurantDictionary;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSMutableDictionary *restaurantDictionary;

-(void)loadData;

@end

