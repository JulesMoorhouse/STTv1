//
//  Constants.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 01/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "Constants.h"

BOOL soundPlaying = FALSE;

NSInteger booPlayTable = 1;

NSString *sVoice = @"male";

NSString *sTrackMale[34] = {@"male-1", @"male-10", @"male-11", @"male-12", @"male-13", @"male-14", 
	@"male-15", @"male-16", @"male-17", @"male-18", @"male-19", @"male-2", @"male-20", @"male-3", 
	@"male-30", @"male-4", @"male-40", @"male-5", @"male-50", @"male-6", @"male-60", @"male-7", 
	@"male-70", @"male-8", @"male-80", @"male-9", @"male-90", @"male-and", @"male-equals", 
	@"male-hundred", @"male-table", @"male-the", @"male-thousand", @"male-times"};

NSString *sTrackFemale[34] = {@"female-1", @"female-10", @"female-11", @"female-12", @"female-13", 
	@"female-14", @"female-15", @"female-16", @"female-17", @"female-18", @"female-19", @"female-2", 
	@"female-20", @"female-3", @"female-30", @"female-4", @"female-40", @"female-5", @"female-50", 
	@"female-6", @"female-60", @"female-7", @"female-70", @"female-8", @"female-80", @"female-9", 
	@"female-90", @"female-and", @"female-equals", @"female-hundred", @"female-table", @"female-the", 
	@"female-thousand", @"female-times"};

float fTrackLengthMale[34] = {0.91, 0.44, 0.65, 0.52, 0.73, 0.78, 0.78, 0.71, 0.81, 0.68, 0.68, 0.52, 
	0.57, 0.63, 0.52, 0.47, 0.65, 0.76, 0.60, 0.68, 0.60, 0.53, 0.65, 0.45, 0.55, 0.50, 0.60, 0.52, 
	0.76, 0.63, 0.47, 0.34, 0.71, 0.63};

float fTrackLengthFemale[34] = {0.71, 0.77, 0.76, 0.85, 1.07, 1.12, 0.86, 1.18, 0.91, 0.89, 0.89, 0.64, 
	0.76, 0.67, 0.99, 0.76, 1.15, 0.88, 0.81, 0.92, 0.94, 0.94, 0.84, 0.72, 0.65, 0.73, 0.71, 0.63, 1.00, 
	0.89, 0.81, 0.52, 1.12, 0.99};

@implementation Constants

+(UIColor*)standardBackgound
{
    //return [UIColor colorWithHex: @"#FFFF7F"];
    return [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:141.0/255.0f alpha:1.0];
}
            
@end
