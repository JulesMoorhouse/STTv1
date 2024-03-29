//
//  AnswersViewController.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 29/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "AnswersViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "SpeakTimesTableAppDelegate.h"
#import "highScores.h"
#import "AppBasic.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [Constants standardBackgound];
    
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"STT2PanelView"
                                                          owner:nil
                                                        options:nil];
    [self.panel addSubview: arrayOfViews[0]];
    [arrayOfViews[0] addTarget:self action:@selector(STT2PanelViewTap) forControlEvents:UIControlEventTouchUpInside];
    
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(doneButton:) name:@"DoneButtonPressed" object:nil];	
	
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Back", @"")
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(BackButtonPressed)];
    self.navigationItem.leftBarButtonItem = backNavButton;
    
	txtNickName.delegate = self;
		
    NSInteger iTableScore = [Prefs returnSettingInt:pfTableScore defaultValue:1];
    
	if (iTableScore != 12)
    {
        lblScore.text = [NSString  stringWithFormat:@"%li", (long)iTableScore];
        lblOutOfLabel.numberOfLines = 0;
	}
    else
    {
        lblResultStatus.text = NSLocalizedString(@"Well done!", @"");

        lblOutOf.hidden = YES;
		lblOutOfLabel.text = NSLocalizedString(@"You've got them\n all correct!", "");
		lblScore.hidden = YES;
        lblOutOfLabel.numberOfLines = 2;
		
		[resLoaderRef.ApplauseSoundPlayer play];
	}
}

- (void) BackButtonPressed
{
	if ([resLoaderRef.ApplauseSoundPlayer isPlaying]) {
		[resLoaderRef.ApplauseSoundPlayer stop];
		resLoaderRef.ApplauseSoundPlayer.currentTime = 0;
	}
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneButton:(NSNotification *)notification
{
	if ([txtNickName isEditing])
    {
		[txtNickName resignFirstResponder];
	}
}	

-(IBAction)buttonSavePressed:(id)sender
{
	NSString *msg = nil;
	
	if ([txtNickName.text isEqualToString:@""])
    {
		msg = NSLocalizedString(@"You haven't entered your name!", @"");
		
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle: NSLocalizedString(@"Saving score", @"")
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
    else
    {
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
            textField.toolbarPlaceholder = [NSString stringWithFormat:NSLocalizedString(@"Your name :- %@", ""), @"?"];
		} else {
			textField.toolbarPlaceholder = [NSString stringWithFormat:NSLocalizedString(@"Your name :- %@", ""), newString];
		}
	}
	
	return res;
}

-(IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.toolbarPlaceholder = [NSString stringWithFormat:NSLocalizedString(@"Your name :- %@", ""), @"?"];
	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	[animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 480)]];
	[animation setToValue:[NSValue valueWithCGPoint:CGPointMake(160, 185)]];
	[animation setDuration:0.268];
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)STT2PanelViewTap
{
    [AppBasic STTV2Tap];
}

@end
