//
//  SpeakTimesTableAppDelegate.h
//  SpeakTimesTableApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright Mindwarp Consultancy Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kInfoSize 721

@class Preloader;
@class myApplicationAppDelegate; 

@interface SpeakTimesTableAppDelegate : NSObject <UIApplicationDelegate> {
	Preloader *resLoader;    	
    UIWindow *window;
    UINavigationController *navigationController;
	myApplicationAppDelegate *appDelegate;
}


NSMutableString *sTimesTableUsed;	//GLOBAL VARIABLE
int iTableScore;					//GLOBAL VARIABLE
int iRankScore;						//GLOBAL VARIABLE
bool booNumericKeyboard;			//GLOBAL VARIABLE
NSString *strTableSelected;			//GLOBAL VARIABLE
//NSMutableString *strTableSelected;

NSString *sTimerStatusGuid;			//GLOBAL VARIABLE. this is the guid we want to be 
									//running now, so we would set to something differenty to stop it

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) Preloader *resLoader;

@end

