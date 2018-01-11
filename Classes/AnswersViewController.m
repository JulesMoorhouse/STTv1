//
//  AnswersViewController.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 29/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "AnswersViewController.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <QuartzCore/QuartzCore.h>
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
- (void)viewDidLoad
{

    self.view.backgroundColor = [Constants standardBackgound];
    
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"STT2PanelView"
                                                          owner:nil
                                                        options:nil];
    [self.panel addSubview: arrayOfViews[0]];
    
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

	txtNickName.delegate = self;
	
	[AppBasic setButton:btnSave str:@"blue"];
	
    NSInteger iTableScore = [Prefs returnSettingInt:pfTableScore defaultValue:1];
    
	if (iTableScore != 12) {
		//msg = sCorrections;
        lblScore.text = [NSString  stringWithFormat:@"%li", (long)iTableScore];
        lblOutOfLabel.numberOfLines = 0;
	} else {
		lblResultStatus.text = @"Well done !!";	

        lblOutOf.hidden = YES;
		lblOutOfLabel.text = @"You've got them\n all correct!";
		lblScore.hidden = YES;
        lblOutOfLabel.numberOfLines = 2;
		
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneButton:(NSNotification *)notification {
	
	if ([txtNickName isEditing]) {
		[txtNickName resignFirstResponder];
	} 
		
}	

-(IBAction)buttonSavePressed:(id)sender {

	NSString *msg = nil;
	
	if ([txtNickName.text isEqualToString:@""]) {
		msg = @"You haven't entered your name!";
		

        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Saving score"
                                     message: msg
                                     preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            //do something when click button
        }];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];

        
	} else {
		
		NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
		[dateForm setDateFormat:@"g"];
		NSString *dateString = [dateForm stringFromDate:[NSDate date]];
		NSInteger iJulian = [dateString intValue];
		
        NSInteger iRankScore = [Prefs returnSettingInt:pfRankScore defaultValue:1];
        
		highScores *MyHigh = [[highScores alloc] init];
		[MyHigh load];
        NSString *sTimesTableUsed = [Prefs returnSettingStr:pfTimesTableUsed defaultValue:@""];
		[MyHigh save:iJulian name:txtNickName.text tableScore:sTimesTableUsed mark:iRankScore];
		[MyHigh debug];

        [self.navigationController popToRootViewControllerAnimated:YES];
	}
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)touchesBegan :(NSSet *)touches withEvent:(UIEvent *)event
{
	[txtNickName resignFirstResponder];	
		
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
			textField.toolbarPlaceholder= [NSString stringWithFormat:@"Your name :- %@", @"?"];
            
		} else {
			textField.toolbarPlaceholder = [NSString stringWithFormat:@"Your name :- %@", newString];
		}
	}
	
	return res;
	
}

-(IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)theTextField {
	
	theTextField.toolbarPlaceholder = [NSString stringWithFormat:@"Your name :- %@", @"?"];
	
	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	[animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 480)]];
	[animation setToValue:[NSValue valueWithCGPoint:CGPointMake(160, 185)]];
	[animation setDuration:0.268];
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	return YES;
}

-(IBAction)STT2PanelViewTap:(id)sender
{
    [AppBasic STTV2Tap];
}

@end
