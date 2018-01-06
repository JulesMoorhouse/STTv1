//
//  AnswersViewController.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 29/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "AnswersViewController.h"
#import "SpeakTimesTableAppDelegate.h"
#import "highScores.h"
#import "AppBasic.h"
//#import "GANTracker.h"
#import "Preloader.h"
#import "Prefs.h"

@implementation AnswersViewController
@synthesize lblMessage;
@synthesize txtNickName;
@synthesize lblScore;
@synthesize lblOutOf;
@synthesize lblOutOfLabel;
@synthesize lblResultStatus;
@synthesize btnSave;
@synthesize lblKeyboard;
@synthesize resLoaderRef;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
	// removed for - Evgeny Kostenko: in other words, for future safety, both would be better (too easy to get lost in notifications)
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(doneButton:) name:@"DoneButtonPressed" object:nil];	
	
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
    
	txtNickName.delegate = self;
	
	[AppBasic setButton:btnSave str:@"blue"];
	
	//NSString *msg = nil;
    int iTableScore = [Prefs returnSettingInt:pfTableScore defaultValue:1];
    
	if (iTableScore != 12) {
		//msg = sCorrections;
		lblScore.text = [NSString  stringWithFormat:@"%i", iTableScore];
	} else {
		lblResultStatus.text = @"Well done !!";	
		//lblResultStatus.font = [UIFont systemFontOfSize:16];
		lblOutOf.hidden = YES;
		//lblOutOfLabel.hidden = YES;
		lblOutOfLabel.frame = CGRectMake(20,99, 280, 43);
		lblOutOfLabel.text = @"You've got them all correct!";	
		lblScore.hidden = YES;
		
		/*
		NSString *path = [[NSBundle mainBundle] pathForResource:@"LargeCrowdApplauseE" ofType:@"wav"];
		AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL]; 
		[theAudio play];
		theAudio.numberOfLoops = 0;
		[path release];
		 */
		
		[resLoaderRef.ApplauseSoundPlayer play];	
		
	}
		
	[super viewDidLoad];
}
- (void) BackButtonPressed
{
	if ([resLoaderRef.ApplauseSoundPlayer isPlaying]) {
		[resLoaderRef.ApplauseSoundPlayer stop];
		resLoaderRef.ApplauseSoundPlayer.currentTime = 0;
	}
	
    //SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    //[delegate.navigationController popViewControllerAnimated:YES];	
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneButton:(NSNotification *)notification {
	
	if ([txtNickName isEditing]) {
		[txtNickName resignFirstResponder];
	} 
	
	lblKeyboard.hidden = YES;	
	
}	

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction)buttonSavePressed:(id)sender {

	NSString *msg = nil;
	
	if ([txtNickName.text isEqualToString:@""]) {
		msg = @"You haven't entered your name!";
		
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Saving score" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	} else {
		
		/*
		NSError *error;
		if (![[GANTracker sharedTracker] trackEvent:@"button_click"
											 action:@"save_answer"
											  label:[UIDevice currentDevice].uniqueIdentifier
											  value:-1
										  withError:&error]) {
			// Handle error here
		}
		 */
		
		NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
		[dateForm setDateFormat:@"g"];
		NSString *dateString = [dateForm stringFromDate:[NSDate date]];
		int iJulian = [dateString intValue];
		
        int iRankScore = [Prefs returnSettingInt:pfRankScore defaultValue:1];
        
		highScores *MyHigh = [[highScores alloc] init];
		[MyHigh load];
		//[MyHigh save:99 name:txtNickName.text tableScore:sTimesTableUsed mark:iRankScore];
        NSString *sTimesTableUsed = [Prefs returnSettingStr:pfTimesTableUsed defaultValue:@""];
		[MyHigh save:iJulian name:txtNickName.text tableScore:sTimesTableUsed mark:iRankScore];
		[MyHigh debug];
		//[[self navigationController] popViewControllerAnimated: YES];
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
	
}

/*
 removed for - Evgeny Kostenko: in other words, for future safety, both would be better (too easy to get lost in notifications)
- (void)keyboardDidShow:(NSNotification *)note
{
	lblKeyboard.hidden = NO;
	
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)touchesBegan :(NSSet *)touches withEvent:(UIEvent *)event
{
	[txtNickName resignFirstResponder];	
	
	lblKeyboard.hidden = YES;
	
	[super touchesBegan:touches withEvent:event];
}

#pragma mark TextField methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	BOOL res = TRUE;
	
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    res = !([newString length] > 10);
	
	if (res == TRUE) {
		if ([newString isEqualToString:@""]) {
			lblKeyboard.text = [NSString stringWithFormat:@"Your name :- %@", @"?"];
		} else {
			lblKeyboard.text = [NSString stringWithFormat:@"Your name :- %@", newString];
		}
	}
	
	return res;
	
}

-(IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
	lblKeyboard.hidden = YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)theTextField {
	
	lblKeyboard.text = [NSString stringWithFormat:@"Your name :- %@", @"?"];
	
	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
	lblKeyboard.hidden = NO; 
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	[animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 480)]];
	[animation setToValue:[NSValue valueWithCGPoint:CGPointMake(160, 185)]];
	[animation setDuration:0.268];
	[[lblKeyboard layer] addAnimation:animation forKey:@"positionAnimation"];
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
	lblKeyboard.hidden = YES; 
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	lblKeyboard.hidden = YES;
	return YES;
}


@end
