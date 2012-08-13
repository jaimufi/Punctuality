//
//  StudentDetailViewController.m
//  Punctuality
//
//  Created by Raunaq Sawhney on 11-01-12.
//  Copyright 2011 North Park Secondary School. All rights reserved.
//

#import "StudentDetailViewController.h"
#import "Student.h"
#import "FileHelpers.h"


@implementation StudentDetailViewController

- (id)init
{
	self = [super initWithNibName:@"StudentDetailViewController" bundle:nil];
	imageCache = [[NSMutableDictionary alloc] init];
	
	// Create a UIBarButtonItem with a camera icon, which will send a takePicture command and put the picture in the view
	UIBarButtonItem *cameraBarButtonItem = 
	[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera 
												  target:self 
												  action:@selector(takePicture:)];	
	
	// Place this image on the navigation bar
	[[self navigationItem] setRightBarButtonItem:cameraBarButtonItem];
	
	// cameraBarButton is released by the navigation item
	[cameraBarButtonItem release];
	
	return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
	return [self init];
}
- (void)chooseInheritor:(id)sender 
{ 
    // Allocate a people picker object to allow users to insert parent Information about a student to the student profile
    if (!peoplePicker) { 
        peoplePicker = [[ABPeoplePickerNavigationController alloc] init]; 
		[peoplePicker setPeoplePickerDelegate:self];
    } 
    
    // Put that people picker  object on the screen using modal views
	peoplePicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:peoplePicker animated:YES]; 
} 
- (void)peoplePickerNavigationControllerDidCancel: 
(ABPeoplePickerNavigationController *)aPeoplePicker 
{ 
    // Remove people picker off the screen 
    [self dismissModalViewControllerAnimated:YES]; 
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)aPeoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
{ 
    // Get the first and last name for the selected person from the iOS device's Address Book or contacts.app
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty); 
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty); 
    
    // Get the phone numbers for this selected person as well from the adress book or contacts app
    ABMultiValueRef numbers = ABRecordCopyValue(person, kABPersonPhoneProperty); 
	
    // Make sure there is atleast one phone number for this person 
    if (ABMultiValueGetCount(numbers) > 0) { 
        // Get the first phone number available and use it towards the parent information section
        CFStringRef number = ABMultiValueCopyValueAtIndex(numbers, 0); 
        // Add that phone number to the student currently being edited
        [editingStudent setParentNumber:(NSString *)number]; 
        // Set the on screen UILabel to this phone number 
        [parentNumberField setText:(NSString *)number]; 
        
        // Release the copy method to free up memory
        CFRelease(number); 
    } 
	
    // Create a string with first and last name together - full name in the UILabel 
    NSString *name = [NSString stringWithFormat:@"%@ %@", 
					  (NSString *)firstName, (NSString *)lastName]; 
    [editingStudent setParentName:name]; 
	
    // Release all copied objects to free up memory
    CFRelease(firstName); 
    CFRelease(lastName); 
    CFRelease(numbers); 
	
    // Update onscreen UILabel to show relevant parenttInformation 
    [parentNameField setText:name]; 
	
    // Dismiss the people picker object off the screen modally and with animations
    [self dismissModalViewControllerAnimated:YES]; 
    
    // Do not perform default functionality (which is go to detailed page) 
    return YES; 
} 
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)aPeoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
                                property:(ABPropertyID)property 
                              identifier:(ABMultiValueIdentifier)identifier 
{ 
    return YES; 
} 

- (void)viewDidLoad
{
	// Show an alert view to teh user telling them where to tap to bring the the parent information selection 
	// Modal popup window
	[[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	[self setEditingStudent:editingStudent];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Punctuality"
													message:@"To add Parent Information, tap in the 'Parent Information' area"
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)takePicture:(id)sender
{
	// Allocate imagePicker controller
	if (!imagePickerController) {
		imagePickerController = [[UIImagePickerController alloc] init];
		
		// If the device has a camera,  make it take a picture, otherwise,  just pick from photo library
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
			[imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
		else
			[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
		
			[imagePickerController setDelegate:self];
	}
	// Place imagePicker item on the screen
	[self presentModalViewController:imagePickerController animated:YES];
}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
	for (UIView* view in self.view.subviews) {
		if ([view isKindOfClass:[UITextField class]])
			[view resignFirstResponder];
	}
}

- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info
{	
	// Get picked image from info dictionary
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	[editingStudent setThumbnailFromImage:image];
	
	// Create a unique identifier object to attach it to a spceific student
	CFUUIDRef newUniqueID = CFUUIDCreate (kCFAllocatorDefault);
	
	// Create a string from unique identifier
	CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
	
	// Use that unique ID to set the students imageKey which will attach that specific image to the student being edited
	[editingStudent setImageKey:(NSString *)newUniqueIDString];
	
	CFRelease(newUniqueIDString);
	CFRelease(newUniqueID);
	
	// Store image in to imageCache with this key
	[imageCache setObject:image forKey:[editingStudent imageKey]];
	
	// Put that image on to the screen in our image view
	[imageView setImage:image];	
	
	// Take image picker off the screen
	[self dismissModalViewControllerAnimated:YES];
	
	// Create a  path for the image
	NSString *imagePath = pathInDocumentDirectory([editingStudent imageKey]);
	
	// Turn image into JPEG data,
	NSData *d = UIImageJPEGRepresentation(image, 1.0);
	
	// Write it to full path
	[d writeToFile:imagePath atomically:YES];
}

- (void)setEditingStudent:(Student *)student
{
	editingStudent = student;
	
} 
- (void)viewWillAppear:(BOOL)animated
{
	// Use properties of incoming student to change user interface
	[studentNameField setText:[editingStudent studentName]];
	[studentAttendanceField setText:[editingStudent studentAttendance]];
	[periodNumberField setText:[NSString stringWithFormat:@"%d", 
								[editingStudent periodNumber]]];
	
	// Create a NSDateFormatter
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] 
									  autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setLocale:[NSLocale currentLocale]];
	
	// Use filtered NSDate object to return string to set dateLabel contents
	[dateLabel setText:
	 [dateFormatter stringFromDate:[editingStudent dateCreated]]];
	// Change the navigation item to display name of student
	[[self navigationItem] setTitle:[editingStudent studentName]];
	
	NSString *imageKey = [editingStudent imageKey];
	
	// Get image for image key from image cache
	UIImage *imageToDisplay = [imageCache objectForKey:imageKey];
	
	// If image doesn't exist, load it from file
	if (!imageToDisplay) {
		
		// Create UIImage object from file
		imageToDisplay = [UIImage imageWithContentsOfFile:pathInDocumentDirectory(imageKey)];
		
		// If an image is found in the file system, place it in to the imageCache
		if (imageToDisplay)
			[imageCache setObject:imageToDisplay forKey:imageKey];
	}
	
	// Use that image to put on the screen in imageView
	[imageView setImage:imageToDisplay];
    [parentNameField setText:[editingStudent parentName]]; 
    [parentNumberField setText:[editingStudent parentNumber]]; 
    [[self navigationItem] setTitle:[editingStudent studentName]]; 
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];	
	// "Save" changes to editingStudent
	[editingStudent setStudentName:[studentNameField text]];
	[editingStudent setStudentAttendance:[studentAttendanceField text]];
	[editingStudent setPeriodNumber:[[periodNumberField text] intValue]];	
}


- (void)didReceiveMemoryWarning
{
	NSLog(@"didReceiveMemoryWarning");
	
	[super didReceiveMemoryWarning];
	[imageCache removeAllObjects];
		if (editingStudent)
		[self setEditingStudent:editingStudent];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}


@end