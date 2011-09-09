//
//  highScores.h
//  TestHighScores
//
//  Created by Julian Moorhouse on 27/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

//http://www.artandstructure.com/softwaredev/hscores.php


#import <Foundation/Foundation.h>


@interface highScores : NSObject {
	
}

int score;
NSString *scoreNameEntry;

struct high_score_entry { 
	NSString *name; 
	int highScore; 
	NSString *testDateString;
	int tableScore;
}; 

struct high_score_entry structArray[10]; 

-(void)initialize;
-(void)load;
-(NSString*)GetTestDateByIdx:(int)idx;
-(NSString*)GetTableScoreByIdx:(int)idx;
-(void)save:(int)iscore name:(NSString *)name tableScore:(int)tableScore;
-(void)sort;
-(void)debug;
-(NSString*)GetNameByIdx:(int)idx;
-(NSString*)GetScoreByIdx:(int)idx;
@end
