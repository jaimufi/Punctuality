//
//  PunctualityAppDelegate.m
//  Punctuality
//
//  Created by Raunaq Sawhney on 11-01-10.
//  Copyright 2011 North Park Secondary School. All rights reserved.
//

#import "PunctualityAppDelegate.h"
#import "StudentsViewController.h"
#import "FileHelpers.h"

@implementation PunctualityAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Get the full path of the students data file, where the data for students will be stored
	NSString *studentPath = [self studentArrayPath];
	
	// Unarchive it in to an array
	NSMutableArray *studentArray = 
	[NSKeyedUnarchiver unarchiveObjectWithFile:studentPath];
	
	// If the file does not exist in the studentPath, the students array will not either
	// Make the app create one, if it is not present
	if (!studentArray)
		studentArray = [[NSMutableArray alloc] init];
	
	// Create an instance of StudentsViewController
	studentViewController = [[StudentsViewController alloc] init];
	
	// Give it the studentsArray, to display a list of students in the tableView
	[studentViewController setStudents:studentArray];
	
	// Create an instance of a UINavigationController, to navigate through the punctuality app
	UINavigationController *navController = [[UINavigationController alloc] 
											 initWithRootViewController:studentViewController];
	
	// Place navigation controller's view into window hierarchy
	[window setRootViewController:navController];
	[navController release];
	
	[window makeKeyAndVisible];
	
	return YES;
}

- (NSString *)studentArrayPath
{
	// Look for the students array file with the name "Students.data"
	return pathInDocumentDirectory(@"Students.data");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Get full path of the students archive
	NSString *studentPath = [self studentArrayPath];
	
	// Get the student list from the filePath
	NSMutableArray *studentArray = [studentViewController students];
	
	// Archive student list to file and save to disk
	[NSKeyedArchiver archiveRootObject:studentArray toFile:studentPath];
}

- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
