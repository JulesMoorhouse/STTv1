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
	NSInteger score;
	NSString *scoreNameEntry;
	NSString *strDate;
	NSString *sTableScore;
	NSInteger mark;
	NSUserDefaults *userPreferences; 
	NSInteger i;
	NSInteger ii;	
}

struct high_score_entry { 
	__unsafe_unretained NSString *name;
	NSInteger highScore;
	__unsafe_unretained NSString *testDateString;
	__unsafe_unretained NSString *tableScore; 
	NSInteger mark;
}; 


-(void)load;
-(void)save:(NSInteger)iscore name:(NSString *)name tableScore:(NSString *)tableScore mark:(NSInteger)iMark;
-(void)sort;
-(void)debug;
-(NSString*)GetNameByIdx:(NSInteger)idx;
-(NSString*)GetMarkByIdx:(NSInteger)idx;
-(NSString*)GetTestDateByIdx:(NSInteger)idx;
-(NSString*)GetTableScoreByIdx:(NSInteger)idx;
@end
