//
//  highScores.m
//  TestHighScores
//
//  Created by Julian Moorhouse on 27/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "highScores.h"


@implementation highScores

int score;
NSString *scoreNameEntry;
NSString *strDate;
int iTableScore;

int i, ii = -1; 



struct high_score_entry structArray[10]; 

NSUserDefaults *userPreferences; 

-(void)initialize {
	NSLog(@"highScores.initialize start");
	userPreferences = [NSUserDefaults standardUserDefaults]; 
	NSLog(@"highScores.initialize end");
}
-(void)load {
	
	i = -1;
	ii = -1;
	
	NSLog(@"highScores.load start");
	//this block retreives
	for (i = 0; i < 10; i++) { 
		if ([userPreferences stringForKey:[NSString stringWithFormat:@"highScoreNameEntry%d", i]] != nil && 
				[userPreferences stringForKey:[NSString stringWithFormat:@"highScoreEntry%d", i]] != nil) { 
			
			structArray[i].name = [userPreferences stringForKey:[NSString stringWithFormat:@"highScoreNameEntry%d", i]]; 
			structArray[i].highScore = [userPreferences integerForKey:[NSString stringWithFormat:@"highScoreEntry%d", i]]; 
			structArray[i].testDateString = [userPreferences stringForKey:[NSString stringWithFormat:@"highTestDateStringEntry%d", i]]; 
			structArray[i].tableScore = [userPreferences integerForKey:[NSString stringWithFormat:@"highTableScoreEntry%d", i]]; 

			
			ii = i; 
		} 
	} 
	//this block retreives
	
	[self sort];
	NSLog(@"highScores.load end");
}

-(void)debug{
	NSLog(@"highScores.debug");
	for (i = 0; i <= ii; i++) { 
		NSLog(@"Score=%@ %i", structArray[i].name, structArray[i].highScore);
	}
}

-(NSString*)GetNameByIdx:(int)idx
{
	NSLog(@"highScores.GetNameByIdx");
	return structArray[idx].name;
}

-(NSString*)GetScoreByIdx:(int)idx
{
	NSLog(@"highScores.GetScoreByIdx");
	return [NSString stringWithFormat:@"%i", structArray[idx].highScore];
}

-(NSString*)GetTestDateByIdx:(int)idx
{
	NSLog(@"highScores.GetTestDateByIdx");
	return structArray[idx].testDateString;
}

-(NSString*)GetTableScoreByIdx:(int)idx
{
	NSLog(@"highScores.GetTableScoreByIdx");
	return [NSString stringWithFormat:@"%i", structArray[idx].tableScore];
}

-(void)save:(int)iscore name:(NSString *)name tableScore:(int)tableScore{
	NSLog(@"highScores.save start");
	score = iscore;
	scoreNameEntry = name;
	
	/*
	//NSDate *nowDate = [NSDate date]; //Gives you the exact time and date you called it at
	//NSString *theString = [NSString stringWithFormat:@"%@",nowDate]; //Put it into string form
	
	NSDate *date = [NSDate date];
	//Create the dateformatter object
	NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
	//Set the required date format
	[formatter setDateFormat:@"yyyy-MM-dd"];
	//Get the string date
	NSString *str = [formatter stringFromDate:date];
	//Display on the console
	NSLog(@"%@",str);
	
*/
	
	
	strDate = @"freddy";//str;
	iTableScore = tableScore;


	//[self load];
	
	//saves
	for (i = 0; i <= ii; i++) { 
		[userPreferences setObject:structArray[i].name forKey:[NSString stringWithFormat:@"highScoreNameEntry%d", i]]; 
		[userPreferences setInteger:structArray[i].highScore forKey:[NSString stringWithFormat:@"highScoreEntry%d", i]]; 
		[userPreferences setObject:structArray[i].testDateString forKey:[NSString stringWithFormat:@"highTestDateStringEntry%d", i]]; 
		[userPreferences setInteger:structArray[i].tableScore forKey:[NSString stringWithFormat:@"highTableScoreEntry%d", i]]; 
	}	
	//saves
	NSLog(@"highScores.save end");
}
-(void)sort{
	NSLog(@"highScores.sort start");
	//sorting
	if (score > 0) { 
		for (i = ii; i >= 0; i--) 
		{ 
			if (score > structArray[i].highScore) { 
				if (i < 9) 
					structArray[i + 1] = structArray[i]; 
				structArray[i].name = scoreNameEntry; 
				structArray[i].highScore = score; 
				structArray[i].testDateString = strDate; 
				structArray[i].tableScore = iTableScore; 
				if (i == ii && ii < 9) 
					ii = i + 1; 
			} else 
				if (i == ii && i < 9) { 
					structArray[i + 1].name = scoreNameEntry; 
					structArray[i + 1].highScore = score; 
					structArray[i + 1].testDateString = strDate; 
					structArray[i + 1].tableScore = iTableScore;
					ii = i + 1; 
				} 
		} 
	} 
	if (ii == -1 && score > 0) { 
		structArray[0].name = scoreNameEntry; 
		structArray[0].highScore = score; 
		structArray[0].testDateString = strDate; 
		structArray[0].tableScore = iTableScore;
		ii = 0; 
	} 
	//sorting
	NSLog(@"highScores.sort end");
}

/*
- (void)dealloc {
	[userPreferences release];	
    [super dealloc];
}

*/

@end
