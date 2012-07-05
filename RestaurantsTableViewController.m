//
//  RestaurantsTableViewController.m
//  GPF-4
//
//  Created by Joseph P Spens on 10/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RestaurantsTableViewController.h"
#import "RestaurantDetailViewController.h"
#import "DetailViewController.h"

@implementation RestaurantsTableViewController

@synthesize restaurantDictionary, array, segmentedControl;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/
-(void) segmentedControlTapped:(UISegmentedControl *) segControl
{
	NSLog(@"SegmentedController%i",segControl.selectedSegmentIndex);
	NSMutableArray *array = [self.restaurantDictionary objectForKey:@"restaurants"];
	
	if(segControl.selectedSegmentIndex == 0){
		NSSortDescriptor* nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
		
		NSArray* sortedArray = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameSortDescriptor]];
		[nameSortDescriptor release];
		
		[self.restaurantDictionary setObject:[NSMutableArray arrayWithArray:sortedArray] forKey:@"restaurants"];
	}else if(segControl.selectedSegmentIndex == 1){
		NSSortDescriptor* nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
		
		NSArray* sortedArray = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameSortDescriptor]];
		[nameSortDescriptor release];
		
		[self.restaurantDictionary setObject:[NSMutableArray arrayWithArray:sortedArray] forKey:@"restaurants"];
	}else{
		NSLog(@"Not gonna happen.");
		//NSSortDescriptor* nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
		
		//NSArray* sortedArray = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameSortDescriptor]];
		//[nameSortDescriptor release];
		
		//[self.restaurantDictionary setObject:[NSMutableArray arrayWithArray:sortedArray] forKey:@"restaurants"];
	}	
	[self.tableView reloadData];
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"A-Z",@"Z-A",@"Distance",nil]];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.selectedSegmentIndex = 0;
	[segmentedControl addTarget:self action:@selector(segmentedControlTapped:) forControlEvents:UIControlEventValueChanged];
	self.navigationItem.titleView = segmentedControl;
	[self segmentedControlTapped:segmentedControl];
	[segmentedControl release];
	
	// Add a "Reload" button
//	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonTapped)] autorelease];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	//NSLog(@"array = %@",array);
	//NSLog(@"restaurants = %@",[restaurantDictionary objectForKey:@"restaurants"]);
	array = [restaurantDictionary allValues];
	//[array setArray:[restaurantDictionary objectForKey:@"restaurants"]];
	//NSLog(@"array = %@",array);
	//NSLog(@"restaurants2 = %@",[restaurantDictionary objectForKey:@"restaurants"]);
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog(@"restaurant = %@",[restaurantDictionary objectForKey:@"restaurants"]);
	//NSLog(@"restaurant count = %d",[[restaurantDictionary objectForKey:@"restaurants"] count]);
    return [[restaurantDictionary objectForKey:@"restaurants"] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSUInteger row = [indexPath row];
	//NSLog(@"configuring object for key = %@",[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row]);
	//NSLog(@"configuring object for key = %@",[[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row] name]);
	cell.textLabel.text = [[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row] name];
	cell.showsReorderControl = YES;
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	//cell.detailTextLabel.text = [[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row] distanceFromLocation:[map userLocation]];
	//NSLog(@"got this far");
	
    return cell;
}

- (void)createDetailView:(int)row{
	DetailViewController *detailVC = [[DetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
	detailVC.restaurant = [[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row];
	
	[self.navigationController pushViewController:detailVC animated:YES];
	[detailVC release];
	
	//RestaurantDetailViewController *rdvc = [[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
	
	//rdvc.nameText = [[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row] name];
	//rdvc.addressText = [[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row] address];
	//rdvc.phoneText = [[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row] phoneNumber];
	//rdvc.urlText = [[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row] url];
	//rdvc.distanceText = [[[restaurantDictionary objectForKey:@"restaurants"] objectAtIndex:row] url];
	//NSLog(@"view controller = %@",[self.tabBarController.viewControllers objectAtIndex:1]);
	//[[self.tabBarController.viewControllers objectAtIndex:1] pushViewController:rdvc animated:YES];
	///[rdvc release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
	[self createDetailView:indexPath.row];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self createDetailView:row];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

