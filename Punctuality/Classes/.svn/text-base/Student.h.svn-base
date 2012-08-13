//
//  Student.h
//  Punctuality
//
//  Created by Irvanjit Gill on 11-01-11.
//  Copyright 2011 North Park Secondary School. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Student: NSObject <NSCoding> {
	NSString *studentName;
	NSString *studentAttendance;
	int periodNumber;
	NSDate *dateCreated;
	NSString *imageKey;
	UIImage *thumbnail;
    NSString *parentName, *parentNumber; 
} 
@property (nonatomic, copy) NSString *parentName; 
@property (nonatomic, copy) NSString *parentNumber;
@property (nonatomic, copy) NSString *studentName;
@property (nonatomic, copy) NSString *studentAttendance;
@property (nonatomic) int periodNumber;
@property (readonly) NSDate *dateCreated;
@property (nonatomic, copy) NSString *imageKey;
@property (readonly, retain) UIImage *thumbnail;

- (void)setThumbnailFromImage:(UIImage *)image;

+ (id)randomStudent;

- (id)initWithStudentName:(NSString *)name 
							periodNumber:(int)period
								studentAttendance:(NSString *)sAttendance;

- (id)initWithStudentName:(NSString *)name;

@end
