//
//  SpeakTimesTableAppDelegate.m
//  SpeakTimesTableApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright Mindwarp Consultancy Ltd 2010. All rights reserved.
//

#import "SpeakTimesTableAppDelegate.h"
#import "RootViewController.h"
#import "Constants.h"
#import	"RootViewController.h"
#import "Preloader.h"
#import "AppBasic.h"

NSString *strTableSelected = @"";
NSString *sTimerStatusGuid = @"";

@implementation SpeakTimesTableAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize resLoader;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	strTableSelected = @"";
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *sRet = [prefs objectForKey:@"VoiceSegIdx"];
    
    if (sRet == nil) {
        [prefs setInteger:1 forKey:@"VoiceSegIdx"];
        [prefs synchronize];
    }

	self.resLoader = [[Preloader alloc] init];
	
	// the actual loading (and time consuming) happens here:
	[resLoader load];
	RootViewController* rootViewController = (RootViewController*)[navigationController topViewController];
	[rootViewController setLoader:resLoader];
	
    UINavigationController *navController1 = [[UINavigationController alloc]
                                              initWithRootViewController:rootViewController];
    
	//[window addSubview:[navigationController view]];
    [self.window setRootViewController:navController1];

    [window makeKeyAndVisible];
	
	return YES;
}

- (void) applicationDidEnterBackground:(UIApplication *)application
{

	sTimerStatusGuid = [AppBasic GUIDString];
	
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


@end

