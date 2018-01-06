//
//  SpeakTimesTableAppDelegate.h
//  SpeakTimesTableApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright Mindwarp Consultancy Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define kInfoSize 721

@class Preloader;
@class myApplicationAppDelegate; 

@interface SpeakTimesTableAppDelegate : NSObject <UIApplicationDelegate> {
	Preloader *resLoader;    	
    UIWindow *window;
    UINavigationController *navigationController;
	myApplicationAppDelegate *appDelegate;
}

extern NSString *strTableSelected;

extern NSString *sTimerStatusGuid;

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;
@property (nonatomic, strong) Preloader *resLoader;

@end

