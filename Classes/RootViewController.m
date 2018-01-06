//
//  RootViewController.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright Mindwarp Consultancy Ltd 2010. All rights reserved.
//

#import "RootViewController.h"
#import "LearnViewController.h"
#import "TestViewController.h"
#import "ResultsViewController.h"
#import "SpeakTimesTableAppDelegate.h"
#import "Constants.h"
#import "AppBasic.h"
#import "highScores.h"
#import "InfoViewController.h"
#import "Preloader.h"

@implementation RootViewController
@synthesize learnViewController;
@synthesize testViewController;
@synthesize resultsViewController;
@synthesize tableSelectViewController;
@synthesize btnLearn;
@synthesize btnTest;
@synthesize btnHighScores;
@synthesize resLoaderRef;
@synthesize segVoiceChoice;

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/




-(void)viewDidLoad {
	[super viewDidLoad];
	
	/*
    [btnLearn setBackgroundImage:[AppBasic setButtonImageNormal] forState:UIControlStateNormal];
	[btnLearn setBackgroundImage:[AppBasic setButtonImagePressed] forState:UIControlStateHighlighted];
    [btnTest setBackgroundImage:[AppBasic setButtonImageNormal] forState:UIControlStateNormal];
	[btnTest setBackgroundImage:[AppBasic setButtonImagePressed] forState:UIControlStateHighlighted];
    [btnHighScores setBackgroundImage:[AppBasic setButtonImageNormal] forState:UIControlStateNormal];
	[btnHighScores setBackgroundImage:[AppBasic setButtonImagePressed] forState:UIControlStateHighlighted];
*/
	[AppBasic setButton:btnLearn str:@"red"];
	[AppBasic setButton:btnTest str:@"blue"];
	[AppBasic setButton:btnHighScores str:@"green"];

	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSInteger theSelectedIndex = [prefs integerForKey:@"VoiceSegIdx"];
	segVoiceChoice.selectedSegmentIndex = theSelectedIndex;
	if (theSelectedIndex == 0) {
		//Male
		sVoice = @"male";
	}else if (theSelectedIndex == 1) {
		//Female
		sVoice = @"female";
	}
	
	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.frame = CGRectMake(290.0, 10.0, 15.0, 15.0); // puts it top-right
    [infoButton addTarget:self action:@selector(toggleCreditsOpen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
}

- (IBAction) toggleCreditsOpen:(id)inSender
{	
    InfoViewController *theController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self.navigationController presentViewController:theController animated:YES completion:nil];
    /*
    SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.navigationController pushViewController:theController animated:YES];	
    [theController release];
     */
    
}

- (IBAction) toggleCreditsClosed:(id)inSender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)switchVoice:(id)sender
{
	UISegmentedControl *seg = (UISegmentedControl *)sender;
	NSInteger segment = seg.selectedSegmentIndex;
	
	if (segment == 0) {
		//Male
		sVoice = @"male";
	}else if (segment == 1) {
		//Female
		sVoice = @"female";
	}
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setInteger:segment forKey:@"VoiceSegIdx"];
	[prefs synchronize];
	
}
- (IBAction)switchToLearnView:(id)sender
{
	
	//[UIView beginAnimations:nil context:nil];
	//[UIView setAnimationDuration: 0.50];

	LearnViewController *nextController = [LearnViewController alloc];
	nextController.title = @"Learn";	
	SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:nextController animated:YES];	
    
	//[UIView setAnimationTransition:UIViewAnimationCurveLinear 
	//					   forView:delegate.navigationController.view cache:YES];
	//[UIView commitAnimations];

}
- (IBAction)switchToTestView:(id)sender
{
	TestViewController *nextController = [TestViewController alloc];
	nextController.title = @"Test";	
	[nextController setLoader:resLoaderRef];
	
	SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:nextController animated:YES];	
    
	 }
-(IBAction)switchToResultsView:(id)sender
{
	ResultsViewController *nextController = [ResultsViewController alloc];
	nextController.title = @"High Scores";	
	SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:nextController animated:YES];	
    
}

- (void)viewDidAppear:(BOOL)animated {
	
	//needed to stop speak on return from learn screen
	sTimerStatusGuid = [AppBasic GUIDString];
	
    [super viewDidAppear:animated];
	

}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}



@end

