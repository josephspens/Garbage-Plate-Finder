//
//  DetailViewController.h
//  GPF-4
//
//  Created by Joseph P Spens on 10/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Restaurant.h"

@interface DetailViewController : UITableViewController {
	Restaurant *restaurant;
}

@property (nonatomic,retain) Restaurant *restaurant;

@end
