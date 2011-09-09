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
    UIViewController *theController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self.navigationController presentModalViewController:theController animated:TRUE];
}

- (IBAction) toggleCreditsClosed:(id)inSender
{
    [self.navigationController dismissModalViewControllerAnimated:TRUE];
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
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
	
	//needed to stop speak on return from learn screen
	sTimerStatusGuid = [[AppBasic GUIDString] retain];
	
    [super viewDidAppear:animated];
	

}

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}



- (void)dealloc {
	[learnViewController release];
	[testViewController release];
	[resultsViewController release];
	[tableSelectViewController release];
	[btnLearn release];
	[btnTest release];
	[btnHighScores release];
	[resLoaderRef release];
	//[segVoiceChoice release];
    [super dealloc];
}


@end

