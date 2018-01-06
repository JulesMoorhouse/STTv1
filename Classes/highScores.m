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

-(id)init{
	//DLog(@"highScores.init start");
    //if (self == [super init])
	if (self = [super init])
    {
		userPreferences = [NSUserDefaults standardUserDefaults]; 
        ii = -1; 
	}
	//DLog(@"highScores.init end");
	
	//ii = -1; 
	
	
	return self;
}
-(void)load {
	//DLog(@"highScores.load start");
	//this block retreives
	for (i = 0; i < 20; i++) { 
		if ([userPreferences stringForKey:[NSString stringWithFormat:@"highScoreNameEntry%d", i]] != nil && [userPreferences stringForKey:[NSString stringWithFormat:@"highScoreEntry%d", i]] != nil) { 
			structArray[i].name = [userPreferences stringForKey:[NSString stringWithFormat:@"highScoreNameEntry%d", i]]; 
			structArray[i].highScore = [userPreferences integerForKey:[NSString stringWithFormat:@"highScoreEntry%d", i]]; 
			structArray[i].testDateString = [userPreferences stringForKey:[NSString stringWithFormat:@"highTestDateStringEntry%d", i]]; 
			structArray[i].tableScore = [userPreferences stringForKey:[NSString stringWithFormat:@"highTableScoreEntry%d", i]]; 
			structArray[i].mark = [userPreferences integerForKey:[NSString stringWithFormat:@"highTableMarkEntry%d", i]]; 
			
			ii = i; 
		} 
	} 
	//this block retreives
	//[self debug];
	//[self sort];
	//DLog(@"highScores.load end");
}
-(void)debug{
	//DLog(@"highScores.debug");
	for (i = 0; i <= ii; i++) { 
        DLog(@"Score=%@ %li", structArray[i].name, (long)structArray[i].highScore);
	}
}

-(NSString*)GetNameByIdx:(int)idx
{
	//DLog(@"highScores.GetNameByIdx");
	return structArray[idx].name;
}

-(NSString*)GetMarkByIdx:(int)idx
{
	//DLog(@"highScores.GetScoreByIdx");
	//return [NSString stringWithFormat:@"%i", structArray[idx].highScore];
    return [NSString stringWithFormat:@"%li/12", (long)structArray[idx].mark];
}

-(NSString*)GetTestDateByIdx:(int)idx
{
	//DLog(@"highScores.GetTestDateByIdx");
	return structArray[idx].testDateString;	
}

-(NSString*)GetTableScoreByIdx:(int)idx
{
	//DLog(@"highScores.GetTableScoreByIdx");
	return structArray[idx].tableScore;
}

-(void)save:(int)iscore name:(NSString *)name tableScore:(NSString *)tableScore mark:(int)iMark{
	
	//DLog(@"highScores.save start");
	
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
	//Display on the console
	//DLog(@"%@",str);
	
	
	//strDate = @"freddy";
	strDate = str;
	sTableScore = tableScore;
	
	[self load];
	[self sort]; //- removed as your no longer sorting
	//DLog(@"highScores.save middle");
	//saves
	for (i = 0; i <= ii; i++) { 
		[userPreferences setObject:structArray[i].name forKey:[NSString stringWithFormat:@"highScoreNameEntry%d", i]]; 
		[userPreferences setInteger:structArray[i].highScore forKey:[NSString stringWithFormat:@"highScoreEntry%d", i]]; 
		[userPreferences setObject:structArray[i].testDateString forKey:[NSString stringWithFormat:@"highTestDateStringEntry%d", i]]; 
		[userPreferences setObject:structArray[i].tableScore forKey:[NSString stringWithFormat:@"highTableScoreEntry%d", i]]; 
		[userPreferences setInteger:structArray[i].mark forKey:[NSString stringWithFormat:@"highTableMarkEntry%d", i]]; 
	}	
	//saves
	
	
	//[structArray release];
	//[userPreferences release];
	//DLog(@"highScores.save end");
}
-(void)sort{
	//DLog(@"highScores.sort start");
	//sorting
	if (score > 0) { 
		for (i = ii; i >= 0; i--) 
		{ 
			if (score > structArray[i].highScore) { 
				if (i < 19) 
					structArray[i + 1] = structArray[i]; 
				structArray[i].name = scoreNameEntry; 
				structArray[i].highScore = score; 
				structArray[i].testDateString = strDate; 
				structArray[i].tableScore = sTableScore; 
				structArray[i].mark = mark;
				if (i == ii && ii < 19) 
					ii = i + 1; 
			} else 
				if (i == ii && i < 19) { 
					structArray[i + 1].name = scoreNameEntry; 
					structArray[i + 1].highScore = score; 
					structArray[i + 1].testDateString = strDate; 
					structArray[i + 1].tableScore = sTableScore;
					structArray[i + 1].mark = mark;
					ii = i + 1; 
				} 
		} 
	} 
	if (ii == -1 && score > 0) { 
		structArray[0].name = scoreNameEntry; 
		structArray[0].highScore = score; 
		structArray[0].testDateString = strDate; 
		structArray[0].tableScore = sTableScore;
		structArray[0].mark = mark;

		ii = 0; 
	} 
	//sorting
	//DLog(@"highScores.sort end");
}


@end
