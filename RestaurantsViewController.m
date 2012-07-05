//
//  RestaurantsViewController.m
//  GPF-4
//
//  Created by Joseph P Spens on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RestaurantsViewController.h"


@implementation RestaurantsViewController

@synthesize restaurantDictionary;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	// self.tableView.delegate = self; // already done in nib
	// self.tableView.dataSource = self; // already done in nib
	NSString *filePath;
	if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
		filePath = [self dataFilePath];
	}
	else {
		filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
	}
	smurfArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
}

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
    return [smurfArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [[smurfArray objectAtIndex:row] objectForKey:@"name"];
	cell.textLabel.font = [UIFont italicSystemFontOfSize:20];
	cell.showsReorderControl = YES;
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row == 1) {
		// Dont' delete Smurfette!
		return NO;
	}
	return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source
		[smurfArray removeObjectAtIndex:indexPath.row];
		
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSDictionary *smurf = [[smurfArray objectAtIndex:[fromIndexPath row]] retain];
	[smurfArray removeObjectAtIndex:[fromIndexPath row]];
	[smurfArray insertObject:smurf atIndex:[toIndexPath row]];
	[smurf release];
}

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
