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
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat width = screenBounds.size.width;
    CGFloat left = (width - 30) - 15;

	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.frame = CGRectMake(left, 10.0, 15.0, 15.0); // puts it top-right
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
    
    if (!booShownOnboarding)
    {
        booShownOnboarding = YES;

        NSString *msg = NSLocalizedString(@"Thanks for downloading Speaking Times Tables Classic.\n\n This older version of the app was first released in 2010. We've updated it for newer devices and made it Free.\n\n However it has been superseded by the new version, tap the banner at the bottom of most screens for more details.", @"");
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle: NSLocalizedString(@"", @"")
                                     message: msg
                                     preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle: NSLocalizedString(@"OK", @"")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){
                                                             
                                                             //do something when click button
                                                         }];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
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

