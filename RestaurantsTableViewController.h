//
//  RestaurantsTableViewController.h
//  GPF-4
//
//  Created by Joseph P Spens on 10/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RestaurantsTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource> {
	NSMutableDictionary *restaurantDictionary;
	NSMutableArray *array;
	UISegmentedControl *segmentedControl;
}

- (void)createDetailView:(int)row;

@property (nonatomic, retain) NSMutableDictionary *restaurantDictionary;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentedControl;

- (void)segmentedControlTapped:(UISegmentedControl *)segControl;

@end
