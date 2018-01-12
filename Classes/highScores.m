//
//  highScores.m
//  TestHighScores
//
//  Created by Julian Moorhouse on 27/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "highScores.h"
#import "Constants.h"

@implementation highScores

struct high_score_entry structArray[20]; 

-(id)init
{
	if (self = [super init])
    {
		userPreferences = [NSUserDefaults standardUserDefaults]; 
        ii = -1; 
	}
	return self;
}
-(void)load
{
	for (i = 0; i < 20; i++) { 
        if ([userPreferences stringForKey:[NSString stringWithFormat:@"highScoreNameEntry%ld", (long)i]] != nil && [userPreferences stringForKey:[NSString stringWithFormat:@"highScoreEntry%ld", (long)i]] != nil) { 
            structArray[i].name = [userPreferences stringForKey:[NSString stringWithFormat:@"highScoreNameEntry%ld", (long)i]]; 
            structArray[i].highScore = [userPreferences integerForKey:[NSString stringWithFormat:@"highScoreEntry%ld", (long)i]]; 
            structArray[i].testDateString = [userPreferences stringForKey:[NSString stringWithFormat:@"highTestDateStringEntry%ld", (long)i]]; 
            structArray[i].tableScore = [userPreferences stringForKey:[NSString stringWithFormat:@"highTableScoreEntry%ld", (long)i]]; 
            structArray[i].mark = [userPreferences integerForKey:[NSString stringWithFormat:@"highTableMarkEntry%ld", (long)i]]; 
			
			ii = i; 
		} 
	}
}

-(void)debug
{
	for (i = 0; i <= ii; i++)
    {
        DLog(@"Score=%@ %li", structArray[i].name, (long)structArray[i].highScore);
	}
}

-(NSString*)GetNameByIdx:(NSInteger)idx
{
	return structArray[idx].name;
}

-(NSString*)GetMarkByIdx:(NSInteger)idx
{
    return [NSString stringWithFormat:@"%li/12", (long)structArray[idx].mark];
}

-(NSString*)GetTestDateByIdx:(NSInteger)idx
{
	return structArray[idx].testDateString;
}

-(NSString*)GetTableScoreByIdx:(NSInteger)idx
{
	return structArray[idx].tableScore;
}

-(void)save:(NSInteger)iscore name:(NSString *)name tableScore:(NSString *)tableScore mark:(NSInteger)iMark
{
	score = iscore;
	scoreNameEntry = name;
	mark = iMark;
	NSDate *date = [NSDate date];
	//Create the dateformatter object
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	//Set the required date format
	[formatter setDateFormat:@"yyyy-MM-dd"];
	//Get the string date
	NSString *str = [formatter stringFromDate:date];

	strDate = str;
	sTableScore = tableScore;
	
	[self load];
	[self sort]; //- removed as your no longer sorting

    //saves
	for (i = 0; i <= ii; i++)
    {
        [userPreferences setObject:structArray[i].name forKey:[NSString stringWithFormat:@"highScoreNameEntry%ld", (long)i]]; 
        [userPreferences setInteger:structArray[i].highScore forKey:[NSString stringWithFormat:@"highScoreEntry%ld", (long)i]]; 
        [userPreferences setObject:structArray[i].testDateString forKey:[NSString stringWithFormat:@"highTestDateStringEntry%ld", (long)i]]; 
        [userPreferences setObject:structArray[i].tableScore forKey:[NSString stringWithFormat:@"highTableScoreEntry%ld", (long)i]]; 
        [userPreferences setInteger:structArray[i].mark forKey:[NSString stringWithFormat:@"highTableMarkEntry%ld", (long)i]]; 
	}	
	//saves
}

-(void)sort
{
	//sorting
	if (score > 0)
    {
		for (i = ii; i >= 0; i--) 
		{ 
			if (score > structArray[i].highScore)
            {
				if (i < 19) 
					structArray[i + 1] = structArray[i]; 
				structArray[i].name = scoreNameEntry; 
				structArray[i].highScore = score; 
				structArray[i].testDateString = strDate; 
				structArray[i].tableScore = sTableScore; 
				structArray[i].mark = mark;
				if (i == ii && ii < 19) 
					ii = i + 1; 
			}
            else
				if (i == ii && i < 19)
                {
					structArray[i + 1].name = scoreNameEntry; 
					structArray[i + 1].highScore = score; 
					structArray[i + 1].testDateString = strDate; 
					structArray[i + 1].tableScore = sTableScore;
					structArray[i + 1].mark = mark;
					ii = i + 1; 
				} 
		} 
	} 
	if (ii == -1 && score > 0)
    {
		structArray[0].name = scoreNameEntry; 
		structArray[0].highScore = score; 
		structArray[0].testDateString = strDate; 
		structArray[0].tableScore = sTableScore;
		structArray[0].mark = mark;

		ii = 0; 
	} 
	//sorting
}

@end
