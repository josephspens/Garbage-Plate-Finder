//
//  RestaurantsViewController.h
//  GPF-4
//
//  Created by Joseph P Spens on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	NSMutableDictionary *restaurantDictionary;
}

@property (nonatomic, retain) NSMutableDictionary *restaurantDictionary;

@end
