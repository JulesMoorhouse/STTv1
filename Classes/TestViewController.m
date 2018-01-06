//
//  TestViewController.m
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TestViewController.h"
#import "SoundEffect.h"
#import "Constants.h"
#import "Speaking.h"
#import "AppBasic.h"
#import "SpeakTimesTableAppDelegate.h"
#import "AnswersViewController.h"
#import "TableSelectViewController.h"
#import "RootViewController.h"
//#import "GANTracker.h"
#import "NumberKeypadModController.h"
#import "Preloader.h"
#import "RoundRectView.h"
#import "Prefs.h"

@interface UIView (FindAndResignFirstResponder)
- (UIView*)findFirstResponder;
@end
@implementation UIView (FindAndResignFirstResponder)
- (UIView*)findFirstResponder {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return self;
    }
    for (UIView *subView in self.subviews) {
        if ([subView findFirstResponder])
            return subView;
    }
    return nil;
}
@end


@implementation TestViewController
@synthesize numberKeyPadModController;
@synthesize placeholderView;
@synthesize textFieldRow1;
@synthesize textFieldRow2;
@synthesize textFieldRow3;
@synthesize textFieldRow4;
@synthesize textFieldRow5;
@synthesize textFieldRow6;
@synthesize textFieldRow7;
@synthesize textFieldRow8;
@synthesize textFieldRow9;
@synthesize textFieldRow10;
@synthesize textFieldRow11;
@synthesize textFieldRow12;
@synthesize tblTableSelect;
@synthesize tableSelectViewController;
@synthesize lblKeyboard;
@synthesize resLoaderRef;
@synthesize rrv;
@synthesize theAudio;

//int mRow;
- (void) SayShowRow:(int)row
{
	
	float accumSecs = 0;
	NSString *rowAsString;
	
	//DLog(@"SayShowRow1 %@", strTableSelected);
	
	//you probably don`t need retain here now
	rowAsString = [NSString stringWithFormat: @"%d", row];
	
	int iTagRow = 100 + (row * 10);
	
	//DLog(@"row=%@ tag=%@", rowAsString, sTagLabel);
	
	// ########## COLUMN 1 OF SUM - START ##########
	// ##										  ##
    //NSMutableDictionary *dict1 = [[[NSMutableDictionary alloc] init] retain];
	NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
	NSString *sTagLabel1 = [NSString  stringWithFormat:@"%i", iTagRow];
	NSString *sWav1 = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", rowAsString];
	NSString *sWav1Ac = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", rowAsString];
	
	//[dict setValue:rowAsString								forKey:@"sRow"];
	[dict1 setValue:sWav1					forKey:@"sWav"];	
	[dict1 setValue:rowAsString				forKey:@"sLabelValue"];
	[dict1 setValue:sTagLabel1				forKey:@"sTagLabel"];
	[dict1 setValue:sTimerStatusGuid		forKey:@"sGUIDCheck"];
	
	[NSTimer scheduledTimerWithTimeInterval:accumSecs
									 target:self selector:@selector(playSoundShowLabel:) 
								   userInfo:dict1 repeats:NO];
	
	//DLog(@"SayShowRow2");
	
	accumSecs += [Speaking getTrackLength:sWav1Ac];
	//accumSecs += 2;
	
	// ##										  ##
	// ########## COLUMN 1 OF SUM - END   ##########
	
	// ########## COLUMN TIMES - START    ##########
	// ##										  ##	
	//NSMutableDictionary *dictTimes = [[[NSMutableDictionary alloc] init] retain];
    NSMutableDictionary *dictTimes = [[NSMutableDictionary alloc] init];
	iTagRow ++;
	NSString *sTagLabelTimes = [NSString  stringWithFormat:@"%i", iTagRow];
	NSString *sWavTimes = [NSString stringWithFormat:@"%@%@", sVoice, @"-times"];
	NSString *sWavTimesAc = [NSString stringWithFormat:@"%@%@", sVoice, @"-times"];
	
	[dictTimes setValue:sWavTimes			forKey:@"sWav"];	
	[dictTimes setValue:@"x"				forKey:@"sLabelValue"];
	[dictTimes setValue:sTagLabelTimes		forKey:@"sTagLabel"];
	[dictTimes setValue:sTimerStatusGuid	forKey:@"sGUIDCheck"];
	
	[NSTimer scheduledTimerWithTimeInterval:accumSecs
									 target:self selector:@selector(playSoundShowLabel:) 
								   userInfo:dictTimes repeats:NO];
	
	//DLog(@"SayShowRow3");
	accumSecs += [Speaking getTrackLength:sWavTimesAc];		
	// ##										  ##
	// ########## COLUMN TIMES - END      ##########
	
	// ########## COLUMN 3 OF SUM - START ##########
	// ##										  ##
	
	//DLog(@"SayShowRow31");
	//NSMutableDictionary *dictSum = [[[NSMutableDictionary alloc] init] retain];
    NSMutableDictionary *dictSum = [[NSMutableDictionary alloc] init];
	iTagRow ++;
	//DLog(@"SayShowRow32 %i", iTagRow);
	NSString *sTagLabelSum = [NSString  stringWithFormat:@"%i", iTagRow];
	//DLog(@"SayShowRow33 %@ %@", sVoice, strTableSelected);
	NSString *sWavSum = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
	NSString *sWavSumAc = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
	//DLog(@"SayShowRow35 %@", sWavSum);
	[dictSum setValue:sWavSum				forKey:@"sWav"];	
	[dictSum setValue:strTableSelected				forKey:@"sLabelValue"];
	[dictSum setValue:sTagLabelSum			forKey:@"sTagLabel"];
	[dictSum setValue:sTimerStatusGuid		forKey:@"sGUIDCheck"];
	
	//DLog(@"SayShowRow36");
	[NSTimer scheduledTimerWithTimeInterval:accumSecs
									 target:self selector:@selector(playSoundShowLabel:) 
								   userInfo:dictSum repeats:NO];
	
	//DLog(@"SayShowRow4");
	accumSecs += [Speaking getTrackLength:sWavSumAc];		
	// ##										  ##
	// ########## COLUMN 3 OF SUM - END   ##########
	
	// ########## COLUMN EQUALS - START   ##########
	// ##										  ##
	//NSMutableDictionary *dictEquals = [[[NSMutableDictionary alloc] init] retain];
    NSMutableDictionary *dictEquals = [[NSMutableDictionary alloc] init];
	iTagRow ++;
	NSString *sTagLabelEquals = [NSString  stringWithFormat:@"%i", iTagRow];
	NSString *sWavEquals = [NSString stringWithFormat:@"%@%@", sVoice, @"-equals"];
	NSString *sWavEqualsAc = [NSString stringWithFormat:@"%@%@", sVoice, @"-equals"];
	[dictEquals setValue:sWavEquals			forKey:@"sWav"];	
	[dictEquals setValue:@"="				forKey:@"sLabelValue"];
	[dictEquals setValue:sTagLabelEquals		forKey:@"sTagLabel"];
	[dictEquals setValue:sTimerStatusGuid	forKey:@"sGUIDCheck"];
	
	[NSTimer scheduledTimerWithTimeInterval:accumSecs
									 target:self selector:@selector(playSoundShowLabel:) 
								   userInfo:dictEquals repeats:NO];
	
	//DLog(@"SayShowRow5");
	accumSecs += [Speaking getTrackLength:sWavEqualsAc];		
	// ##										  ##
	// ########## COLUMN EQUALS - END     ##########
	
	
	// ########## COLUMN RESULT - START   ##########
	// ##										  ##
	//NSMutableDictionary *dictResult = [[[NSMutableDictionary alloc] init] retain];
    NSMutableDictionary *dictResult = [[NSMutableDictionary alloc] init];
	iTagRow ++;
	NSString *sTagLabelResult = [NSString  stringWithFormat:@"%i", iTagRow];
	[dictResult setValue:@""			forKey:@"sWav"];	
	[dictResult setValue:@""				forKey:@"sLabelValue"];
	[dictResult setValue:sTagLabelResult		forKey:@"sTagLabel"];
	[dictResult setValue:sTimerStatusGuid	forKey:@"sGUIDCheck"];
	
	[NSTimer scheduledTimerWithTimeInterval:accumSecs
									 target:self selector:@selector(playSoundShowLabel:) 
								   userInfo:dictResult repeats:NO];
	//DLog(@"SayShowRow6");
	strKeyboardLabelBase = [[NSMutableString alloc] initWithFormat:@"%@ x %@ = ", rowAsString, strTableSelected];
	lblKeyboard.text = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, @"?"];
	accumSecs += 2;		
	// ##										  ##
	// ########## COLUMN RESULT - END     ##########
	
	accumSecs += 1;
    
    if ( accumSecs == 0) {
        DLog(@"Anything to stop analyzer warning");
    }
	
}
- (void) playSoundShowLabel:(NSTimer*)theTimer
{
	//DLog(@"playSoundShowLabel");
	

	//NSMutableDictionary *dict = [theTimer userInfo];
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[theTimer userInfo]];

	NSString *sGUIDCheck = [dict valueForKey:@"sGUIDCheck"];
	
	if (sTimerStatusGuid == sGUIDCheck) {
		
		int iTagLabel = [[dict valueForKey:@"sTagLabel"] intValue];
		NSString *sLabelValue = [dict valueForKey:@"sLabelValue"];
			
		//DLog(@"playSoundShowLabel %@ %i", sLabelValue, iTagLabel);
			
	
		//DLog(@"PosA");
		if (![sLabelValue isEqualToString:@""]) {
			//DLog(@"PosA1");
			UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagLabel];
			
			lbl.text = sLabelValue;	
			
			lbl.hidden = NO;
			
            NSURL *clickURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], [dict valueForKey:@"sWav"]]];  
            
            theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:
                        clickURL error:nil];
            theAudio.delegate = self;
            
            [theAudio play];
            theAudio.numberOfLoops = 0;
						
			//[path release];
		} else {
			UITextField *txt = (UITextField *)[placeholderView viewWithTag:iTagLabel];	
			txt.hidden = NO;
			[txt becomeFirstResponder];
		}
		//DLog(@"PosB");


	}
	
	//[dict release];
	
	//Removed invalidate as don`t need it as I`m not using repeat, see http://www.iphonedevsdk.com/forum/iphone-sdk-development/48229-nstimer-problems.html
	//[theTimer invalidate];

}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (player == theAudio)
    {
        theAudio = nil;
    }
}

- (void) clearUITextFields
{
	textFieldRow1.text = @"";
	textFieldRow2.text = @"";
	textFieldRow3.text = @"";
	textFieldRow4.text = @"";	
	textFieldRow5.text = @"";
	textFieldRow6.text = @"";
	textFieldRow7.text = @"";
	textFieldRow8.text = @"";
	textFieldRow9.text = @"";
	textFieldRow10.text = @"";
	textFieldRow11.text = @"";
	textFieldRow12.text = @"";	
}

- (void) hideLabels
{
	int row =1;
	int col = 1;
	for (row = 1; row < 13; row++) {
		int iTagRow = 100 + (row * 10);
		for (col = 0; col < 6; col++) {	
			if (col < 5) {
				UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];		
				lbl.hidden = YES;	
				//lbl.hidden = NO;
			} else {
				UITextField *txt = (UITextField *)[placeholderView viewWithTag:iTagRow + col];		
				txt.hidden = YES;
				//txt.hidden = NO;
			}
		}		
	}
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
	[self clearUITextFields]; 
	[tblTableSelect reloadData];
	[self hideLabels];
	
	if ([strTableSelected  isEqual: @""]) {
		//
	} else {
		
		//[tblTableSelect reloadData];
		//[self hideLabels];
		sTimerStatusGuid = [AppBasic GUIDString];
		mRow = 1; // row will be incremented on the DONE click of the textfield
		[self SayShowRow:mRow];
	}

	
}

/*
 removed for - Evgeny Kostenko: in other words, for future safety, both would be better (too easy to get lost in notifications)
- (void)keyboardDidShow:(NSNotification *)note
{
	lblKeyboard.hidden = NO;

}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	
	//DLog(@"view did load!");
	
	/*
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/test_opened"
										 withError:&error]) {
		// Handle error here
	}
	*/
	
	//strTableSelected = [NSMutableString stringWithString: @""];
	strTableSelected = @"";
	
	mRow = 1;
	
	placeholderView.backgroundColor = [UIColor clearColor];
	
	self.numberKeyPadModController = [[NumberKeypadModController alloc] init];
	numberKeyPadModController.delegate = self;
	
	//removed for - Evgeny Kostenko: in other words, for future safety, both would be better (too easy to get lost in notifications)
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self 
				selector:@selector(doneButton:) name:@"DoneButtonPressed" object:nil];

	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
	//			initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit:)];
/*
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:(UIBarButtonSystemItemAction) target:self action:@selector(cancelEdit:)];
			
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:(UIBarButtonSystemItemPlay) target:self action:@selector(cancelEdit:)];
*/	


	 tblTableSelect.backgroundColor = [UIColor clearColor];

	textFieldRow1.delegate = self;
	textFieldRow2.delegate = self;
	textFieldRow3.delegate = self;
	textFieldRow4.delegate = self;
	textFieldRow5.delegate = self;
	textFieldRow6.delegate = self;
	textFieldRow7.delegate = self;
	textFieldRow8.delegate = self;
	textFieldRow9.delegate = self;
	textFieldRow10.delegate = self;
	textFieldRow11.delegate = self;
	textFieldRow12.delegate = self;
	
	[textFieldRow1 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow2 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow3 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow4 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow5 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow6 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow7 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow8 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow9 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow10 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow11 setBorderStyle:UITextBorderStyleRoundedRect];
	[textFieldRow12 setBorderStyle:UITextBorderStyleRoundedRect];
	
	CGRect cgRect =[[UIScreen mainScreen] bounds];
	CGSize cgSize = cgRect.size;
	CGRect frame = lblKeyboard.frame;
	frame.origin.x = 0;
	//frame.origin.y = 180;
	frame.origin.y = 170;
	frame.size.width = cgSize.width;
	//frame.size.height = 21;
	frame.size.height = 31;
	
	lblKeyboard.frame = frame; 
	lblKeyboard.font = [UIFont systemFontOfSize:20];
	
	//this add the back button for the answers screen - weird putting it here.
	UIBarButtonItem *backButtonAnswers = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButtonAnswers;

	
	UIBarButtonItem *doneNavButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Finish", @"")        
								style:UIBarButtonItemStyleBordered  target:self action:@selector(buttonNavDone:)];
        
	self.navigationItem.rightBarButtonItem = doneNavButton;

	self.rrv = [[RoundRectView alloc] initWithFrame:CGRectMake(258, 26, 58, 31)];
	rrv.backgroundColor = [UIColor clearColor];
	rrv.alpha = 0;
	rrv.hidden = YES;
	[self.navigationController.view addSubview:rrv];
	
	// Adding handler for back nav button on this view
	UIButton* _backButton = [UIButton buttonWithType:101];
    [_backButton setTitle:NSLocalizedString(@"Back", @"") forState:UIControlStateNormal];
    [_backButton setTitle:NSLocalizedString(@"Back", @"") forState:UIControlStateHighlighted];
    [_backButton addTarget:self action:@selector(BackButtonPressed) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = backButton;
	/*
	 You may need to use this code if apple reject the lines above
	 
	 Suspicious line is:
	 UIButton* _backButton = [UIButton buttonWithType:101];
	 It uses button initialization method that is not documented by Apple...

	 Button index (101) is not mentioned in Apple's developer documentation. But from the other hand, compiler didn't show any warnings... So it's hard to predict Apple's reaction regarding this button.
	 
	 UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonPressed)];
	 self.navigationItem.leftBarButtonItem = cancelButton;
	 [cancelButton release];
	*/
	
	
    [super viewDidLoad];
}

- (void) BackButtonPressed
{
	//This is the navigation back button
	
    UIView* firstResponder = [self.view findFirstResponder];
    [firstResponder resignFirstResponder];
    
	NSString *strAllValues = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", textFieldRow1.text, 
							  textFieldRow2.text, textFieldRow3.text, textFieldRow4.text, textFieldRow5.text, 
							  textFieldRow6.text, textFieldRow7.text, textFieldRow8.text, textFieldRow9.text, 
							  textFieldRow10.text, textFieldRow11.text, textFieldRow12.text];
	
    if (![strAllValues isEqualToString:@""])
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" 
			message:@"Are you sure ?\n\n(You've given answers, which will be lost, press Finish for results!)" 
			delegate:self cancelButtonTitle:@"No" 
			otherButtonTitles:@"Yes",nil];
		alert.tag = AlertNavBackButton;
		[alert show];
	} else {
		
		numberKeyPadModController.doneButton.hidden = YES;
		finishShowingPathNavHighlighter = YES;
		rrv.hidden = YES;
		
		[CATransaction begin];
		CATransition* animation = [CATransition animation];
		[animation setType:kCATransitionFade];
		animation.duration = 0.08;
		[[numberKeyPadModController.doneButton layer] addAnimation:animation forKey:@"fcext_fade"];
		[CATransaction commit];
		

		//SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        //[delegate.navigationController popViewControllerAnimated:YES];	
        [self.navigationController popViewControllerAnimated:YES];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSInteger tagnum = alertView.tag;
	if (tagnum == AlertNavBackButton) {

		if (buttonIndex != alertView.cancelButtonIndex) {
			//user pressed "Yes"
			finishShowingPathNavHighlighter = YES;
			rrv.hidden = YES;
			
			UIView* firstResponder = [self.view findFirstResponder];
			[firstResponder resignFirstResponder];
			
            //SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            //[delegate.navigationController popViewControllerAnimated:YES];	
            [self.navigationController popViewControllerAnimated:YES];
		}
	}
	
	if (tagnum == AlertTableButton) {

		
		if (buttonIndex != alertView.cancelButtonIndex) {
			//user pressed "Yes"
			finishShowingPathNavHighlighter = YES;
			rrv.hidden = YES;
			
			UIView* firstResponder = [self.view findFirstResponder];
			[firstResponder resignFirstResponder];
			
			TableSelectViewController *nextController = [TableSelectViewController alloc];
			nextController.title = @"Choose times table";	
			SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
			[delegate.navigationController pushViewController:nextController animated:YES];			
		}
	}
	
	//[alertView release];
}

/*
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	if ( row < 12 ) {
		int iTagLabel = (100 + (row * 10)) + 4;
		UITextField *txtLastVisible = (UITextField *)[placeholderView viewWithTag:iTagLabel];	
		
		if (![txtLastVisible.text isEqualToString:@""]) {
			row++;
			[self SayShowRow:row];
		}
	}
	[textField resignFirstResponder];
	return YES;
}
*/

- (void)buttonNavDone:(id)sender {
	
	BOOL booUnanswered = FALSE;
	int row =1;
	int iScore = 0;
	
	sCorrections = [[NSMutableString alloc] initWithString:@""];
	
	int iTableFromCol = 0;
	
	for (row = 1; row < 13; row++) {
		int iTagRow = (100 + (row * 10));
		
		int iTagAnswer = iTagRow+4;
		UITextField *txtAnswer = (UITextField *)[placeholderView viewWithTag:iTagAnswer];		

		if ([txtAnswer.text isEqualToString:@""]) {	
			booUnanswered = TRUE;
			break;
		}		
		int iValTheirAnswer = [txtAnswer.text intValue];
		
		int iTagCol1 = iTagRow;
		UITextField *txtCol1 = (UITextField *)[placeholderView viewWithTag:iTagCol1];	
		int iValCol1 = [txtCol1.text intValue];
		
		int iTagCol3 = iTagRow+2;
		UITextField *txtCol3 = (UITextField *)[placeholderView viewWithTag:iTagCol3];	
		int iValCol3 = [txtCol3.text intValue];

		if (iTableFromCol == 0) {
			iTableFromCol = iValCol3;
		}
		
		int iCorrectAnswer = iValCol1 * iValCol3;
		
		if (iCorrectAnswer != iValTheirAnswer) {
			NSString *sTemp = [NSString stringWithFormat:@"%i x %i = %i not %i\n", 
										 iValCol1, iValCol3, iCorrectAnswer, iValTheirAnswer];
			[sCorrections appendString:sTemp];
		} else {
			iScore ++;
		}
	}

	[Prefs storeSettingInt:pfRankScore Value:iScore];
    [Prefs storeSettingStr:pfTimesTableUsed Value:[[NSMutableString alloc] initWithFormat:@"%i x Table", iTableFromCol]];	
    [Prefs storeSettingInt:pfTableScore Value:iScore];
    
	NSString *msg = nil;
	
	if (booUnanswered == TRUE) {
		msg = @"You have not answered all the questions!";
		
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Results" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
	} else {
		/*
		if (iScore != 12) {
			msg = sCorrections;
		} else {
			msg = @"Well done you have got them all correct!";	
		}
		*/
		finishShowingPathNavHighlighter = YES;
		rrv.hidden = YES;
		
		UIView* firstResponder = [self.view findFirstResponder];
		[firstResponder resignFirstResponder];
		//[numberKeyPadModController resignedResponderWithView:firstResponder];
		//lblKeyboard.hidden = YES;
		
		AnswersViewController *nextController = [AnswersViewController alloc];
		nextController.title = @"Results";	
		[nextController setLoader:resLoaderRef];
		SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[delegate.navigationController pushViewController:nextController animated:YES];	
		
	}
	
}


-(IBAction)buttonCheat:(id)sender
{
	
	rrv.hidden = NO;
	
	[UIView beginAnimations:@"rrvFadeIn" context:(__bridge void *)(rrv)];
	[UIView setAnimationDuration:1];
	[rrv setAlpha:1];
	[UIView setAnimationDelegate:self];
	[UIView commitAnimations];
	
	finishShowingPathNavHighlighter = NO;	
	
	//DLog(@"cheat button pressed");

	int row =1;
	int col = 1;
	NSString *strCol1Row1;
	
	for (row = 1; row < 13; row++) {
		int iTagRow = 100 + (row * 10);
		
		for (col = 0; col < 5; col++) {	
			
			UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];		
			lbl.hidden = NO;
			if (row == 1 ){
				if (col == 2) {
					strCol1Row1 = lbl.text;
				}
			}
			if (col == 2) {
				lbl.text = strCol1Row1;
			}
		}		
	}
	

	for (row = 1; row < 13; row++) {
		int iTagRow = 100 + (row * 10);
		int col1;
		int col3;
		int res;
		for (col = 0; col < 6; col++) {	
			if (col < 5) {
				UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];		
				lbl.hidden = NO;
				if (col == 0) {
					col1 = [lbl.text intValue];
				}
				if (col == 2) {
					col3 = [lbl.text intValue];
				}
			} else {
				UITextField *txt = (UITextField *)[placeholderView viewWithTag:iTagRow + col];	
				txt.hidden = NO;
				res = col1 * col3;
			}
			switch (row) {
				case 1: {
					textFieldRow1.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 2: {
					textFieldRow2.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 3: {
					textFieldRow3.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 4: {
					textFieldRow4.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 5: {
					textFieldRow5.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 6: {
					textFieldRow6.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 7: {
					textFieldRow7.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 8: {
					textFieldRow8.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 9: {
					textFieldRow9.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 10: {
					textFieldRow10.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 11: {
					textFieldRow11.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
				case 12: {
					textFieldRow12.text = [NSString stringWithFormat:@"%d", res];
					break;	
				}
					
				default:
					break;
			}
		}		
	}
	

	
	
	/*
	textFieldRow1.text = @"99";textFieldRow2.text = @"99";textFieldRow3.text = @"99";textFieldRow4.text = @"99";
	textFieldRow5.text = @"99";textFieldRow6.text = @"99";textFieldRow7.text = @"99";textFieldRow8.text = @"99";
	textFieldRow9.text = @"99";textFieldRow10.text = @"99";textFieldRow11.text = @"99";textFieldRow12.text = @"99";
	*/

	
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)doneButtonPressed:(UITextField*)sender{
	
	if ([textFieldRow1 isEditing]) {
		[textFieldRow1 resignFirstResponder];
		
	} else if ([textFieldRow2 isEditing]) {
		[textFieldRow2 resignFirstResponder];
		
	} else if ([textFieldRow3 isEditing]) {
		[textFieldRow3 resignFirstResponder];
		
	} else if ([textFieldRow4 isEditing]) {
		[textFieldRow4 resignFirstResponder];
		
	} else if ([textFieldRow5 isEditing]) {
		[textFieldRow5 resignFirstResponder];
		
	} else if ([textFieldRow6 isEditing]) {
		[textFieldRow6 resignFirstResponder];
		
	} else if ([textFieldRow7 isEditing]) {
		[textFieldRow7 resignFirstResponder];
		
	} else if ([textFieldRow8 isEditing]) {
		[textFieldRow8 resignFirstResponder];
		
	} else if ([textFieldRow9 isEditing]) {
		[textFieldRow9 resignFirstResponder];
		
	} else if ([textFieldRow10 isEditing]) {
		[textFieldRow10 resignFirstResponder];
		
	} else if ([textFieldRow11 isEditing]) {
		[textFieldRow11 resignFirstResponder];
		
	} else if ([textFieldRow12 isEditing]) {
		[textFieldRow12 resignFirstResponder];
	}

}

// NumberKeypadModControllerDelegate method
- (void) donePressed:(id)sender {
	
	lblKeyboard.hidden = YES;
	UIView* firstResponder = [self.view findFirstResponder];
	[firstResponder resignFirstResponder];
	
	
	if ( mRow < 12 ) {
		int iTagLabel = (100 + (mRow * 10)) + 4;
		UITextField *txtLastVisible = (UITextField *)[placeholderView viewWithTag:iTagLabel];	
		//DLog(@"PosE");
		if (![txtLastVisible.text isEqualToString:@""]) {
			//DLog(@"PosE1");
			//mRow++;
			mRow = mRow + 1;
			
			[self SayShowRow:mRow];
		}
		//DLog(@"PosF");
	} else {
		rrv.hidden = NO;
		
		[UIView beginAnimations:@"rrvFadeIn" context:(__bridge void *)(rrv)];
		[UIView setAnimationDuration:1];
		[rrv setAlpha:1];
		[UIView setAnimationDelegate:self];
		[UIView commitAnimations];
		
		finishShowingPathNavHighlighter = NO;	
		
	}
	
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    strTableSelected = @"";
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)touchesBegan :(NSSet *)touches withEvent:(UIEvent *)event
{
	
	//You might not need this method now since you added the done button 
	//to the numeric pad and handle text fields differently
	
	/*
	[textFieldRow1 resignFirstResponder];
	[textFieldRow2 resignFirstResponder];	
	[textFieldRow3 resignFirstResponder];
	[textFieldRow4 resignFirstResponder];	
	[textFieldRow5 resignFirstResponder];
	[textFieldRow6 resignFirstResponder];	
	[textFieldRow7 resignFirstResponder];
	[textFieldRow8 resignFirstResponder];	
	[textFieldRow9 resignFirstResponder];
	[textFieldRow10 resignFirstResponder];	
	[textFieldRow11 resignFirstResponder];
	[textFieldRow12 resignFirstResponder];	
	*/
	
	UIView* firstResponder = [self.view findFirstResponder];
	[firstResponder resignFirstResponder];
	[numberKeyPadModController resignedResponderWithView:firstResponder];
	
	lblKeyboard.hidden = YES;
	
	[super touchesBegan:touches withEvent:event];
}

- (void)animationDidStop:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context
{
	if (finishShowingPathNavHighlighter) {
		rrv.hidden = YES;
	} else {
		if (context) {
			if ([animationID isEqualToString:@"rrvFadeIn"]) {
				[UIView beginAnimations:@"rrvFadeOut" context:context];
				[UIView setAnimationDuration:1];
				[(__bridge RoundRectView*)context setAlpha:0];
				[UIView setAnimationDelegate:self];
				[UIView commitAnimations];
				return;
			}
			if ([animationID isEqualToString:@"rrvFadeOut"]) {
				[UIView beginAnimations:@"rrvFadeIn" context:context];
				[UIView setAnimationDuration:1];
				[(__bridge RoundRectView*)context setAlpha:1];
				[UIView setAnimationDelegate:self];
				[UIView commitAnimations];
			}
		}
	}
}

#pragma mark TextField methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	BOOL res = TRUE;
	
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    res = !([newString length] > 3);
		
	//lblKeyboard.text = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, string];
	if (res == TRUE) {
		if ([newString isEqualToString:@""]) {
			lblKeyboard.text = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, @"?"];
		} else {
			lblKeyboard.text = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, newString];
		}
	}
	
	return res;
}

-(IBAction)textFieldDoneEditing:(id)sender
{
	//You might not need this method now since you added the done button 
	//to the numeric pad and handle text fields differently
	[sender resignFirstResponder];
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	
	UILabel *lblRow = (UILabel *)[placeholderView viewWithTag:(textField.tag-4)];
	
	strKeyboardLabelBase = [[NSMutableString alloc] initWithFormat:@"%@ x %@ = ", lblRow.text, strTableSelected];
	lblKeyboard.text = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, @"?"];
	
	[numberKeyPadModController textFieldShouldBeginEditing:textField];
	
	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
	lblKeyboard.hidden = NO; 
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	[animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 480)]];
	[animation setToValue:[NSValue valueWithCGPoint:CGPointMake(160, 185)]];
	[animation setDuration:0.268];
	[[lblKeyboard layer] addAnimation:animation forKey:@"positionAnimation"];
	
	[numberKeyPadModController textFieldDidBeginEditing:textField];
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
	lblKeyboard.hidden = YES; 
	[numberKeyPadModController textFieldShouldEndEditing:textField];
	return YES;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	UIButton *btnBackground = [[UIButton alloc] initWithFrame:CGRectMake(0,0,300,45)];
	if ([strTableSelected  isEqual: @""]) {
		[btnBackground setTitle: @"   Choose Times Table" forState:UIControlStateNormal];
    } else {
		[btnBackground setTitle:[NSString stringWithFormat:@"   The %@ Times Table", strTableSelected] forState:UIControlStateNormal];
	}		
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	[cell setBackgroundColor:[UIColor clearColor]];
	
	btnBackground.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	btnBackground.titleLabel.font = [UIFont boldSystemFontOfSize:14];
	[btnBackground setBackgroundColor:[UIColor clearColor]];
	
	// Set button enabled to get it's touch effect & also set event receiver method
	btnBackground.enabled = YES;
	[btnBackground addTarget:self action:@selector(btnDiscolsurePressed:) forControlEvents:UIControlEventTouchUpInside];
	
	[AppBasic setButton:btnBackground str:@"blue"];
	
	// add button first and then label to display label 
	[cell.contentView addSubview:btnBackground];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;

		
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//DONT THINK THIS IS CALLED ANYMORE
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
    // Navigation logic may go here -- for example, create and push another view controller.

	NSString *strAllValues = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", textFieldRow1.text, 
							  textFieldRow2.text, textFieldRow3.text, textFieldRow4.text, textFieldRow5.text, 
							  textFieldRow6.text, textFieldRow7.text, textFieldRow8.text, textFieldRow9.text, 
							  textFieldRow10.text, textFieldRow11.text, textFieldRow12.text];
	
    if (![strAllValues isEqualToString:@""])
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" 
														message:@"Are you sure ?\n\n(You've given answers, which will be lost, press Finish for results!)" 
													   delegate:self cancelButtonTitle:@"No" 
											  otherButtonTitles:@"Yes",nil];
		alert.tag = AlertTableButton;
		[alert show];	
        
	} else {	
		finishShowingPathNavHighlighter = YES;
		rrv.hidden = YES;
		
		TableSelectViewController *nextController = [TableSelectViewController alloc];
		nextController.title = @"Choose times table";	
		SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[delegate.navigationController pushViewController:nextController animated:YES];	
	}
	
}
#pragma mark -
#pragma mark Button Event management

-(IBAction)btnDiscolsurePressed:(id)sender {
	
	
	NSString *strAllValues = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@", textFieldRow1.text, 
							  textFieldRow2.text, textFieldRow3.text, textFieldRow4.text, textFieldRow5.text, 
							  textFieldRow6.text, textFieldRow7.text, textFieldRow8.text, textFieldRow9.text, 
							  textFieldRow10.text, textFieldRow11.text, textFieldRow12.text];
	
    if (![strAllValues isEqualToString:@""])
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" 
														message:@"Are you sure ?\n\n(You've given answers, which will be lost, press Finish for results!)" 
													   delegate:self cancelButtonTitle:@"No" 
											  otherButtonTitles:@"Yes",nil];
		alert.tag = AlertTableButton;
		[alert show];	
	} else {	
		
		finishShowingPathNavHighlighter = YES;
		rrv.hidden = YES;
		
		UIView* firstResponder = [self.view findFirstResponder];
		[firstResponder resignFirstResponder];
		
		numberKeyPadModController.doneButton.hidden = YES;
		
		[CATransaction begin];
		CATransition* animation = [CATransition animation];
		[animation setType:kCATransitionFade];
		animation.duration = 0.05;
		[[numberKeyPadModController.doneButton layer] addAnimation:animation forKey:@"fcext_fade"];
		[CATransaction commit];
		
		TableSelectViewController *nextController = [TableSelectViewController alloc];
		nextController.title = @"Choose times table";	
		SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[delegate.navigationController pushViewController:nextController animated:YES];
	}
}

@end
