//
//	Student.m
//  Punctuality
//
//  Created by Irvanjit Gill on 11-01-11.
//  Copyright 2011 North Park Secondary School. All rights reserved.
//

#import "Student.h"


@implementation Student

@synthesize studentName, studentAttendance, periodNumber, dateCreated, imageKey, thumbnail, parentName, parentNumber;

+ (id)randomStudent {
	NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"New Student", nil];
	NSArray *randomNounList = [NSArray arrayWithObjects:@"", nil];
	
	int adjectiveIndex = random() % [randomAdjectiveList count];
	int nounIndex = random() % [randomNounList count];
	NSString *randomName = [NSString stringWithFormat:@"%@ %@",
								[randomAdjectiveList objectAtIndex:adjectiveIndex],
								[randomNounList objectAtIndex:nounIndex]];
	
	Student *newStudent = [[self alloc] initWithStudentName:randomName];
	return [newStudent autorelease];
}

- (id)initWithStudentName:(NSString *)name 
							periodNumber:(int)period
								studentAttendance:(NSString *)sAttendance
{
	// Initialize the superclass 
	self = [super init];
	
	// Check to see if the superclass' initialization failed 
	if (!self)
		return nil;
	
	// Give the variables an initial value to start 
	[self setStudentName:name]; 
	[self setStudentAttendance:sAttendance]; 
	[self setPeriodNumber:period];
	dateCreated = [[NSDate alloc] init];
	
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
	// Decode the variables (studentName, studentAttendance and periodNumber, imageKey) and pass it to the setters
	// Where it is retained
	[self setStudentName:[decoder decodeObjectForKey:@"studentName"]];
	[self setStudentAttendance:[decoder decodeObjectForKey:@"sAttendance"]];
	[self setPeriodNumber:[decoder decodeIntForKey:@"period"]];
	[self setImageKey:[decoder decodeObjectForKey:@"imageKey"]];
	
	// dateCreated is read only, the teacher would not edit it.
	dateCreated = [[decoder decodeObjectForKey:@"dateCreated"] retain];
	
	NSData *thumbnailData = [decoder decodeObjectForKey:@"Thumbnail"];
	if (thumbnailData)
		thumbnail = [[UIImage alloc] initWithData:thumbnailData];
	
    [self setParentName:[decoder decodeObjectForKey:@"parentName"]]; 
    [self setParentNumber:[decoder decodeObjectForKey:@"parentNumber"]]; 
    return self; 
} 

- (id)initWithStudentName:(NSString *)name {
	return [self initWithStudentName:name 
						periodNumber:0
				   studentAttendance:@""];
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	// For each  variable, archive it under its variable name
	[encoder encodeObject:studentName forKey:@"studentName"];
	[encoder encodeObject:studentAttendance forKey:@"sAttendance"];
	[encoder encodeInt:periodNumber forKey:@"period"];
	[encoder encodeObject:dateCreated forKey:@"dateCreated"];
	[encoder encodeObject:imageKey forKey:@"imageKey"];
	NSData *thumbnailData = UIImageJPEGRepresentation(thumbnail, 1.0);
	[encoder encodeObject:thumbnailData forKey:@"Thumbnail"];
    // Put parentInformation data into an archive 
    [encoder encodeObject:parentName forKey:@"parentName"]; 
    [encoder encodeObject:parentNumber forKey:@"parentNumber"]; 
} 

- (void)setThumbnailFromImage:(UIImage *)image
{
	// Create a 70 x 70 empty image for the tableView
	UIGraphicsBeginImageContext(CGSizeMake(70, 70));
	
	// Get a pointer to the context of the image
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGContextTranslateCTM(ctx, 0, 70);
	CGContextScaleCTM(ctx, 1, -1);
	
	// Draw image in to a 70 x 70 rectangle which is scaled down to fit as a thumbnail
	CGContextDrawImage(ctx, CGRectMake(0, 0, 70, 70), [image CGImage]);
	
	// Get the image from the image context, retain it as a thumbnail to be shown in the tableView
	thumbnail = [UIGraphicsGetImageFromCurrentImageContext() retain];
	
	// Release memory after creating the image object
	UIGraphicsEndImageContext();
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ (%@): Worth %d, Recorded on %@",
				studentName, studentAttendance, periodNumber, dateCreated];
}

- (void)dealloc {
	[thumbnail release];
	[studentName release]; 
	[studentAttendance release];
	[dateCreated release];
	[imageKey release];
    [parentName release]; 
    [parentNumber release]; 
    [super dealloc]; 
} 

@end
