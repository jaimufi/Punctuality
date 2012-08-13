//
//  PunctualityItemCell.m
//  Punctuality
//
//  Created by Raunaq Sawhney on 11-01-11.
//  Copyright 2011 North Park Secondary School. All rights reserved.
//

#import "PunctualityItemCell.h"
#import "Student.h"

@implementation PunctualityItemCell

- (id)initWithStyle:(UITableViewCellStyle)style 
    reuseIdentifier:(NSString *)reuseIdentifier 
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		// Create the subviews which are to be displayed in the tableView cell
		periodNumberLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		studentNameLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		imageView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
		
		// Make the imageiView scale down to a size that fits the tableView cell
		[imageView setContentMode:UIViewContentModeScaleAspectFit];
		
		// Place these subviews in the in the tableView
		[[self contentView] addSubview:periodNumberLabel];
		[[self contentView] addSubview:studentNameLabel];
		[[self contentView] addSubview:imageView];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	float inset = 5;
	CGRect bounds = [[self contentView] bounds];
	float h = bounds.size.height;
	float w = bounds.size.width;
	float valueWidth = 40;
	
	// Make a rectangle that is square and fits in the tableView cell
	CGRect innerFrame = CGRectMake(inset, inset, h, h - inset * 2.0);
	[imageView setFrame:innerFrame];
	
	// Move that rectangle over to the left side of the cell 
	// And resize the width for the studentNameLabel
	innerFrame.origin.x += innerFrame.size.width + inset;
	innerFrame.size.width = w - (h + valueWidth + inset * 4);
	[studentNameLabel setFrame:CGRectMake(inset * 2 + h, inset, w - (h + valueWidth + inset * 4), 30)];
	
	// Move that rectangle over again and resize the width for studentAttendanceLabel
	innerFrame.origin.x += innerFrame.size.width + inset;
	innerFrame.size.width = valueWidth;
	[periodNumberLabel setFrame:innerFrame];
}

- (void)setStudent:(Student *)student
{
	[studentNameLabel setText:[student studentName]];
	[imageView setImage:[student thumbnail]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

}


- (void)dealloc {
    [super dealloc];
}


@end
