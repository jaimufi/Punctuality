//
//  StudentsViewController
//  Punctuality
//
//  Created by Raunaq Sawhney on 11-01-10.
//  Copyright 2011 North Park Secondary School. All rights reserved.
//

#import "StudentsViewController.h"
#import "Student.h"
#import "StudentDetailViewController.h"
#import "PunctualityItemCell.h"

@implementation StudentsViewController

@synthesize students;

- (id)init {
	self = [super initWithStyle:UITableViewStylePlain];
	
	// Make the navigation bar have an Edit button show up when the app is launched
	[[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
	
	// Set the title of the navigation bar to Punctuality when the app is launched
	[[self navigationItem] setTitle:@"Punctuality"];

	return self;
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[self tableView] reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


#pragma mark Table view methods

// Create the number of sections needed to view teh data in the tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

// Customize the number of rows in the table view depending on the number of items to be listed.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int numberOfRows = [students count];
	// If the app is in  editing mode, there will be one more row than the number of students 
	if ([self isEditing])
		numberOfRows++;
	
	return numberOfRows;
}


// Customize the appearance of tableView cells.
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
	if ([indexPath row] >= [students count]) {
		
		UITableViewCell *basicCell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
		
		if (!basicCell)
			basicCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
												reuseIdentifier:@"UITableViewCell"] autorelease];
		[[basicCell textLabel] setText:NSLocalizedString(@"New Student", @"Text for adding a new student")];
		
		return basicCell;	
	}
	// Get an instance of a PunctualityItemCell - either an unused one or a new one
	PunctualityItemCell *cell = (PunctualityItemCell *)[tableView 
												dequeueReusableCellWithIdentifier:@"PunctualityItemCell"];
	if (!cell)
		cell = [[[PunctualityItemCell alloc] initWithStyle:UITableViewCellStyleDefault 
										 reuseIdentifier:@"PunctualityItemCell"] autorelease];
	
	[cell setStudent:[students objectAtIndex:[indexPath row]]];
	
	return cell;
}

- (void)tableView:(UITableView *)aTableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (!detailViewController) {
		detailViewController = [[StudentDetailViewController alloc] init];
	}
	
	// Give the studentDetailViewController a pointer to the student object in the studentViewController view
	[detailViewController setEditingStudent:
	 [students objectAtIndex:[indexPath row]]];
	// Make it visible to the user
	[[self navigationController] pushViewController:detailViewController 
										   animated:YES];
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{		
	if ([self isEditing] && [indexPath row] == [students count]) {
		return UITableViewCellEditingStyleInsert;
	}
	return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// If the user wants to delete an item
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Ask the app to remove the row as well as remove it from the students array
		[students removeObjectAtIndex:[indexPath row]];
		// Also remove it from the tableView, basically delete the item
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
										 withRowAnimation:YES];
	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// If the user wants to add an item, add the item into the tableView as well as the students array
		[students addObject:[Student randomStudent]];
		[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
										 withRowAnimation:UITableViewRowAnimationFade];
	}
}
// To move items in the tableView up or down
- (void)tableView:(UITableView *)tableView 
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath 
			toIndexPath:(NSIndexPath *)toIndexPath 
{
	// Get pointer to object being moved in the tableView
	Student * p = [students objectAtIndex:[fromIndexPath row]];
	
	[p retain];
	
	[students removeObjectAtIndex:[fromIndexPath row]];
	
	[students insertObject:p atIndex:[toIndexPath row]];
	
	[p release];
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
	[super setEditing:flag animated:animated];
	//Editing mode, showing the user "Add New Student"
	if (flag) {
		// If entering edit mode,  add another row to the table view
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[students count] 
																inSection:0];
		[[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
														withRowAnimation:UITableViewRowAnimationFade];	
	} else {
		// If leaving edit mode,  remove last row from the tabel view
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[students count] 
																inSection:0];
		[[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
														withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (BOOL)tableView:(UITableView *)tableView 
canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// Only allow rows showing students to move, otherwise dont allow movement
	if ([indexPath row] < [students count])
		return YES;
	return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView 
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath 
			 toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	if ([proposedDestinationIndexPath row] < [students count]) {
		return proposedDestinationIndexPath;
	}
	NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:[students count] - 1 
													  inSection:0];
	return betterIndexPath;
}


- (void)dealloc {
    [super dealloc];
}


@end

