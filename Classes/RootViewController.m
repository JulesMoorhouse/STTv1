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
@synthesize panel;

-(void)viewDidLoad
{
	[super viewDidLoad];
	
    self.view.backgroundColor = [Constants standardBackgound];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"STT2PanelView"
                                                         owner:nil
                                                       options:nil];
    [self.panel addSubview: arrayOfViews[0]];
    
//    [AppBasic setButton:btnLearn str:@"red"];
//    [AppBasic setButton:btnTest str:@"blue"];
//    [AppBasic setButton:btnHighScores str:@"green"];

	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSInteger theSelectedIndex = [prefs integerForKey:@"VoiceSegIdx"];
	segVoiceChoice.selectedSegmentIndex = theSelectedIndex;
	if (theSelectedIndex == 0)
    {
		//Male
		sVoice = @"male";
	}
    else if (theSelectedIndex == 1)
    {
		//Female
		sVoice = @"female";
	}
	
	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.frame = CGRectMake(290.0, 10.0, 15.0, 15.0); // puts it top-right
    [infoButton addTarget:self action:@selector(toggleCreditsOpen:) forControlEvents:UIControlEventTouchUpInside];
    infoButton.tintColor = [UIColor darkGrayColor];
    [self.view addSubview:infoButton];
}

- (IBAction) toggleCreditsOpen:(id)inSender
{	
    InfoViewController *theController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self.navigationController presentViewController:theController animated:YES completion:nil];
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
	LearnViewController *nextController = [LearnViewController alloc];
	nextController.title = NSLocalizedString(@"Learn", @"");
	[self.navigationController pushViewController:nextController animated:YES];
}

- (IBAction)switchToTestView:(id)sender
{
	TestViewController *nextController = [TestViewController alloc];
	nextController.title = NSLocalizedString(@"Test", @"");
	[nextController setLoader:resLoaderRef];
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)switchToResultsView:(id)sender
{
	ResultsViewController *nextController = [ResultsViewController alloc];
	nextController.title = NSLocalizedString(@"High Scores", @"");
	[self.navigationController pushViewController:nextController animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

	//needed to stop speak on return from learn screen
	sTimerStatusGuid = [AppBasic GUIDString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
	
}

-(IBAction)STT2PanelViewTap:(id)sender
{
    [AppBasic STTV2Tap];
}

@end

