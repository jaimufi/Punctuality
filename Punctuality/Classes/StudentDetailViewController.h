//
//  StudentDetailViewController.h
//  Punctuality
//
//  Created by Raunaq Sawhney on 11-01-12.
//  Copyright 2011 North Park Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h> 
#import <MessageUI/MessageUI.h>
@class Student;

@interface StudentDetailViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, ABPeoplePickerNavigationControllerDelegate, MFMailComposeViewControllerDelegate> {
	IBOutlet UITextField *studentNameField;
	IBOutlet UITextField *studentAttendanceField;
	IBOutlet UITextField *periodNumberField;
	IBOutlet UILabel *dateLabel;
	Student *editingStudent;
	UIImagePickerController *imagePickerController;
	IBOutlet UIImageView *imageView;
	NSMutableDictionary *imageCache;
    IBOutlet UILabel *parentNameField; 
    IBOutlet UILabel *parentNumberField; 
    ABPeoplePickerNavigationController *peoplePicker; 
} 
- (IBAction)chooseInheritor:(id)sender; 
- (void)setEditingStudent:(Student *)student;

@end
