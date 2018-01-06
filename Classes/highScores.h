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
	int score;
	NSString *scoreNameEntry;
	NSString *strDate;
	NSString *sTableScore;
	int mark;
	NSUserDefaults *userPreferences; 
	int i;
	int ii;	
}

struct high_score_entry { 
	__unsafe_unretained NSString *name;
	NSInteger highScore;
	__unsafe_unretained NSString *testDateString;
	__unsafe_unretained NSString *tableScore; 
	NSInteger mark;
}; 


-(void)load;
-(void)save:(int)iscore name:(NSString *)name tableScore:(NSString *)tableScore mark:(int)iMark;
-(void)sort;
-(void)debug;
-(NSString*)GetNameByIdx:(int)idx;
-(NSString*)GetMarkByIdx:(int)idx;
-(NSString*)GetTestDateByIdx:(int)idx;
-(NSString*)GetTableScoreByIdx:(int)idx;
@end
