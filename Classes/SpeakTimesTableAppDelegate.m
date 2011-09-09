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
#import "Appirater.h"
//#import "GANTracker.h"
#import	"RootViewController.h"
#import "Preloader.h"
#import "AppBasic.h"

@implementation SpeakTimesTableAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize resLoader;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	strTableSelected = @"";
	booNumericKeyboard = YES;
	
#ifndef NDEBUG
    
#else
    //
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    
	//BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:(@"%@/_CodeSignature", bundlePath)];
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[bundlePath stringByAppendingPathComponent:keyboardFix]];
	
	if (!fileExists) {
		//pirated
		close(0);
		UIWebView *a = [UIWebView alloc];
		UIWindow *b = [UIWindow alloc];
		UIView *c = [UIView alloc];
		UILabel *d = [UILabel alloc];
		UITextField *e = [UITextField alloc];
		UIImageView *f = [UIImageView alloc];
		UIImage *g = [UIImage alloc];
		UISwitch *h = [UISwitch alloc];
		UISegmentedControl *i = [UISegmentedControl alloc];
		UITabBar *j = [UITabBar alloc];
		[a alloc];
		[b alloc];
		[c alloc];
		[d alloc];
		[e alloc];
		[f alloc];
		[g alloc];
		[h alloc];
		[i alloc];
		[j alloc];
		system("killall SpringBoard");
	}
	
	//BOOL fileExists2 = [[NSFileManager defaultManager] fileExistsAtPath:(@"%@/CodeResources", bundlePath)];
	BOOL fileExists2 = [[NSFileManager defaultManager] fileExistsAtPath:[bundlePath stringByAppendingPathComponent:viesService]];
    
	if (!fileExists2) {
		//pirated
		close(0);
		UIWebView *a = [UIWebView alloc];
		UIWindow *b = [UIWindow alloc];
		UIView *c = [UIView alloc];
		UILabel *d = [UILabel alloc];
		UITextField *e = [UITextField alloc];
		UIImageView *f = [UIImageView alloc];
		UIImage *g = [UIImage alloc];
		UISwitch *h = [UISwitch alloc];
		UISegmentedControl *i = [UISegmentedControl alloc];
		UITabBar *j = [UITabBar alloc];
		[a alloc];
		[b alloc];
		[c alloc];
		[d alloc];
		[e alloc];
		[f alloc];
		[g alloc];
		[h alloc];
		[i alloc];
		[j alloc];
		system("killall SpringBoard");
	}
	
	//BOOL fileExists3 = [[NSFileManager defaultManager] fileExistsAtPath:(@"%@/ResourceRules.plist", bundlePath)];
	BOOL fileExists3 = [[NSFileManager defaultManager] fileExistsAtPath:[bundlePath stringByAppendingPathComponent:vatCheck]];
	if (!fileExists3) {
		close(0);
		UIWebView *a = [UIWebView alloc];
		UIWindow *b = [UIWindow alloc];
		UIView *c = [UIView alloc];
		UILabel *d = [UILabel alloc];
		UITextField *e = [UITextField alloc];
		UIImageView *f = [UIImageView alloc];
		UIImage *g = [UIImage alloc];
		UISwitch *h = [UISwitch alloc];
		UISegmentedControl *i = [UISegmentedControl alloc];
		UITabBar *j = [UITabBar alloc];
		[a alloc];
		[b alloc];
		[c alloc];
		[d alloc];
		[e alloc];
		[f alloc];
		[g alloc];
		[h alloc];
		[i alloc];
		[j alloc];
		system("killall SpringBoard");
	}
	
	
#endif

	self.resLoader = [[[Preloader alloc] init] autorelease];
	
	// the actual loading (and time consuming) happens here:
	[resLoader load];
	RootViewController* rootViewController = (RootViewController*)[navigationController topViewController];
	[rootViewController setLoader:resLoader];
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	
	// call the Appirater class
    //[Appirater appLaunched];
	//put back in and change the APPIRATER_APP_ID in the h file when you have 
	//your app id when your app is published on itunes
	
	/*
	[[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-4176161-11"
										   dispatchPeriod:10
												 delegate:nil];
	
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/app_launched"
										 withError:&error]) {
		// Handle error here
	}
	*/
	
	return YES;
}

- (void) applicationDidEnterBackground:(UIApplication *)application
{

	sTimerStatusGuid = [[AppBasic GUIDString] retain];
	
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[resLoader release];
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

