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
	
    IQKeyboardManager.sharedManager.enable = YES;
    IQKeyboardManager.sharedManager.previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysShow;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
    IQKeyboardManager.sharedManager.placeholderFont = [UIFont systemFontOfSize:16];
    IQKeyboardManager.sharedManager.shouldShowToolbarPlaceholder = YES;

    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
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
    self.viewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
	[self.viewController setLoader:resLoader];
	
    //[self.viewController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];

    [self.viewController.navigationItem setTitle:@"Speaking Times Tables"];

    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: self.viewController];
    
    navController.navigationBar.translucent = NO;

    self.window.rootViewController = navController;

    [self.window makeKeyAndVisible];

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

