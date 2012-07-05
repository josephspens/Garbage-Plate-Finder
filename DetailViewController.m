//
//  DetailViewController.m
//  GPF-4
//
//  Created by Joseph P Spens on 10/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "MapViewController.h"

@implementation DetailViewController

@synthesize restaurant;


#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.title = self.restaurant.name;
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/
 
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
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
		return 2;
	}
	return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			cell.textLabel.text = self.restaurant.name;
		}
		else {
			cell.textLabel.text = self.restaurant.address;
			cell.textLabel.font = [UIFont systemFontOfSize:14];
		}
	}
	if (indexPath.section == 1) {
		cell.textLabel.text = [NSString stringWithFormat:@"Call %@",self.restaurant.phoneNumber];
		cell.textLabel.textColor = [UIColor blueColor];
		cell.textLabel.textAlignment = UITextAlignmentCenter;
	}
	if (indexPath.section == 2) {
		cell.textLabel.text = self.restaurant.url;
		cell.textLabel.textColor = [UIColor blueColor];
		cell.textLabel.textAlignment = UITextAlignmentCenter;
	}
	if (indexPath.section == 3) {
		cell.textLabel.text = @"Show On Map";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
	}
	if (indexPath.section == 4) {
		cell.textLabel.text = @"Add To Favorites";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
	}
    
    return cell;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return [NSString stringWithFormat:@"Home of the %@!", self.restaurant.plateName];
	}
	
	return nil;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section == 0) {
		
	}
	if (indexPath.section == 1) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:1%@",self.restaurant.phoneNumber]]];
	}
	if (indexPath.section == 2) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.restaurant.url]];
	}
	if (indexPath.section == 3) {
		MapViewController *mvc = [[(UITabBarController *)self.navigationController.parentViewController viewControllers] objectAtIndex:0];
		[(UITabBarController *)self.navigationController.parentViewController setSelectedIndex:0];
		[mvc reloadYou:self.restaurant.location];
	}
	if (indexPath.section == 4) {
		// Add to Favorites
	}
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1 && indexPath.row == 0) {
		return 200.0;
	}
	else {
		return 20.0;
	}
}
*/

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

