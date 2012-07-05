//
//  RestaurantDetailViewController.h
//  GPF-4
//
//  Created by Joseph P Spens on 10/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RestaurantDetailViewController : UIViewController {
	IBOutlet UILabel *name;
	IBOutlet UILabel *address;
	IBOutlet UILabel *phone;
	IBOutlet UILabel *url;
	IBOutlet UILabel *distance;
	NSString *nameText;
	NSString *addressText;
	NSString *phoneText;
	NSString *urlText;
	NSString *distanceText;
}
@property (nonatomic,copy) NSString *nameText;
@property (nonatomic,copy) NSString *addressText;
@property (nonatomic,copy) NSString *phoneText;
@property (nonatomic,copy) NSString *urlText;
@property (nonatomic,copy) NSString *distanceText;
@end