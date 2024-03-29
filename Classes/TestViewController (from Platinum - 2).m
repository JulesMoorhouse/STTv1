//
//  TestViewController.m
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>
#import "TestViewController.h"
#import "SoundEffect.h";
#import "Constants.h";
#import "Speaking.h";
#import "AppBasic.h";
#import "SpeakTimesTableAppDelegate.h"
#import "AnswersViewController.h"
#import "TableSelectViewController.h"
#import "RootViewController.h";
#import "GANTracker.h"

@implementation TestViewController
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

int mRow;

- (void) SayShowRow:(int)row
{
	
	float accumSecs = 0;
	NSString *rowAsString;
	
	//NSLog(@"SayShowRow1 %@", strTableSelected);
	
	//you probably don`t need retain here now
	rowAsString = [NSString stringWithFormat: @"%d", row];
	
	int iTagRow = 100 + (row * 10);
	
	//NSLog(@"row=%@ tag=%@", rowAsString, sTagLabel);
	
	// ########## COLUMN 1 OF SUM - START ##########
	// ##										  ##
	NSMutableDictionary *dict1 = [[[NSMutableDictionary alloc] init] retain];
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
	[dict1 release];
	
	//NSLog(@"SayShowRow2");
	
	accumSecs += [Speaking getTrackLength:sWav1Ac];
	//accumSecs += 2;
	
	// ##										  ##
	// ########## COLUMN 1 OF SUM - END   ##########
	
	// ########## COLUMN TIMES - START    ##########
	// ##										  ##	
	NSMutableDictionary *dictTimes = [[[NSMutableDictionary alloc] init] retain];
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
	[dictTimes release];
	
	//NSLog(@"SayShowRow3");
	accumSecs += [Speaking getTrackLength:sWavTimesAc];		
	// ##										  ##
	// ########## COLUMN TIMES - END      ##########
	
	// ########## COLUMN 3 OF SUM - START ##########
	// ##										  ##
	
	//NSLog(@"SayShowRow31");
	NSMutableDictionary *dictSum = [[[NSMutableDictionary alloc] init] retain];
	iTagRow ++;
	//NSLog(@"SayShowRow32 %i", iTagRow);
	NSString *sTagLabelSum = [NSString  stringWithFormat:@"%i", iTagRow];
	//NSLog(@"SayShowRow33 %@ %@", sVoice, strTableSelected);
	NSString *sWavSum = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
	NSString *sWavSumAc = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
	//NSLog(@"SayShowRow35 %@", sWavSum);
	[dictSum setValue:sWavSum				forKey:@"sWav"];	
	[dictSum setValue:strTableSelected				forKey:@"sLabelValue"];
	[dictSum setValue:sTagLabelSum			forKey:@"sTagLabel"];
	[dictSum setValue:sTimerStatusGuid		forKey:@"sGUIDCheck"];
	
	//NSLog(@"SayShowRow36");
	[NSTimer scheduledTimerWithTimeInterval:accumSecs
									 target:self selector:@selector(playSoundShowLabel:) 
								   userInfo:dictSum repeats:NO];
	[dictSum release];
	
	//NSLog(@"SayShowRow4");
	accumSecs += [Speaking getTrackLength:sWavSumAc];		
	// ##										  ##
	// ########## COLUMN 3 OF SUM - END   ##########
	
	// ########## COLUMN EQUALS - START   ##########
	// ##										  ##
	NSMutableDictionary *dictEquals = [[[NSMutableDictionary alloc] init] retain];
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
	[dictEquals release];
	
	//NSLog(@"SayShowRow5");
	accumSecs += [Speaking getTrackLength:sWavEqualsAc];		
	// ##										  ##
	// ########## COLUMN EQUALS - END     ##########
	
	
	// ########## COLUMN RESULT - START   ##########
	// ##										  ##
	NSMutableDictionary *dictResult = [[[NSMutableDictionary alloc] init] retain];
	iTagRow ++;
	NSString *sTagLabelResult = [NSString  stringWithFormat:@"%i", iTagRow];
	[dictResult setValue:@""			forKey:@"sWav"];	
	[dictResult setValue:@""				forKey:@"sLabelValue"];
	[dictResult setValue:sTagLabelResult		forKey:@"sTagLabel"];
	[dictResult setValue:sTimerStatusGuid	forKey:@"sGUIDCheck"];
	
	[NSTimer scheduledTimerWithTimeInterval:accumSecs
									 target:self selector:@selector(playSoundShowLabel:) 
								   userInfo:dictResult repeats:NO];
	[dictResult release];
	//NSLog(@"SayShowRow6");
	strKeyboardLabelBase = [[NSMutableString alloc] initWithFormat:@"%@ x %@ = ", rowAsString, strTableSelected];
	lblKeyboard.text = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, @"?"];
	accumSecs += 2;		
	// ##										  ##
	// ########## COLUMN RESULT - END     ##########
	
	accumSecs += 1;
	
}
- (void) playSoundShowLabel:(NSTimer*)theTimer
{
	//NSLog(@"playSoundShowLabel");
	
	NSMutableDictionary *dict = [theTimer userInfo];
	
	int iTagLabel = [[dict valueForKey:@"sTagLabel"] intValue];
	NSString *sLabelValue = [dict valueForKey:@"sLabelValue"];
	NSString *sGUIDCheck = [dict valueForKey:@"sGUIDCheck"];
		
	NSLog(@"playSoundShowLabel %@ %i", sLabelValue, iTagLabel);
	
	if (sTimerStatusGuid == sGUIDCheck) {
		//NSLog(@"PosA");
		if (![sLabelValue isEqualToString:@""]) {
			//NSLog(@"PosA1");
			UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagLabel];
			lbl.text = sLabelValue;		
			lbl.hidden = NO;
			//lbl.text = [dict valueForKey:@"sWav"];
			NSLog(@"labelval=%@", sLabelValue);
			
			NSLog(@"label showing=%i", iTagLabel);
			//NSLog(@"hidden=%i", lbl.hidden);
			//NSLog(@"Is Kind of NSString: %@", ([lbl.hidden isKindOfClass:[NSString class]]) ? @"YES" : @"NO");
	  
			NSString *path = [[NSBundle mainBundle] pathForResource:[dict valueForKey:@"sWav"] ofType:@"wav"];
			
			
			 SystemSoundID soundID;
			 AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
			 AudioServicesPlaySystemSound(soundID);
			 
			/*
			AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL]; 
			[theAudio play];
			theAudio.numberOfLoops = 0;
			*/
			
			[path release];
		} else {
			UITextField *txt = (UITextField *)[placeholderView viewWithTag:iTagLabel];	
			txt.hidden = NO;	
			[txt becomeFirstResponder];
		}
		//NSLog(@"PosB");
		[dict release];

	}
	//Removed invalidate as don`t need it as I`m not using repeat, see http://www.iphonedevsdk.com/forum/iphone-sdk-development/48229-nstimer-problems.html
	//[theTimer invalidate];

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
				lbl.hidden = NO;
			} else {
				UITextField *txt = (UITextField *)[placeholderView viewWithTag:iTagRow + col];		
				txt.hidden = YES;	
				txt.hidden = NO;
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
	
	booNumericKeyboard = YES;
	
	if (strTableSelected == @"") {
		//
	} else {
		
		[tblTableSelect reloadData];
		[self hideLabels];
		sTimerStatusGuid = [[AppBasic GUIDString] retain];
		mRow = 1; // row will be incremented on the DONE click of the textfield
		[self SayShowRow:mRow];
	}
	
}

- (void)keyboardDidShow:(NSNotification *)note
{
	lblKeyboard.hidden = NO;

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/test_opened"
										 withError:&error]) {
		// Handle error here
	}
	
	//strTableSelected = [NSMutableString stringWithString: @""];
	strTableSelected = [NSString stringWithString: @""];
	
	mRow = 1;
	
	placeholderView.backgroundColor = [UIColor clearColor];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

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
	frame.origin.y = 180;
	frame.size.width = cgSize.width;
	lblKeyboard.frame = frame; 
	
	//this add the back button for the answers screen - weird putting it here.
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"")        
								style:UIBarButtonItemStyleBordered  target:self action:@selector(buttonDone:)]  autorelease];
        
	self.navigationItem.rightBarButtonItem = doneButton;
	
    [super viewDidLoad];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	BOOL res = TRUE;
	
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    res = !([newString length] > 3);
	
	/*
	if ( res == TRUE){
		NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		
		res = ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0);
	}
	*/

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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)theTextField {

	UILabel *lblRow = (UILabel *)[placeholderView viewWithTag:(theTextField.tag-4)];

	strKeyboardLabelBase = [[NSMutableString alloc] initWithFormat:@"%@ x %@ = ", lblRow.text, strTableSelected];
	lblKeyboard.text = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, @"?"];

	return YES;
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

- (void)buttonDone:(id)sender
{

	BOOL booUnanswered = FALSE;
	int row =1;
	int iScore = 0;
	
	//NSMutableString *sCorrections = [[NSMutableString alloc] initWithString:@""];
	sCorrections = [[NSMutableString alloc] initWithString:@""];
	
	int iTableFromCol = 0;
	
	for (row = 1; row < 13; row++) {
		int iTagRow = (100 + (row * 10));
		
		int iTagAnswer = iTagRow+4;
		UITextField *txtAnswer = (UITextField *)[placeholderView viewWithTag:iTagAnswer];		
		//NSLog(@"PosC");
		if ([txtAnswer.text isEqualToString:@""]) {	
			booUnanswered = TRUE;
			break;
		}		
		//NSLog(@"PosD");
		int iValTheirAnswer = [txtAnswer.text intValue];
		//[txtAnswer release];
		
		int iTagCol1 = iTagRow;
		UITextField *txtCol1 = (UITextField *)[placeholderView viewWithTag:iTagCol1];	
		int iValCol1 = [txtCol1.text intValue];
		//[txtCol1 release];
		
		int iTagCol3 = iTagRow+2;
		UITextField *txtCol3 = (UITextField *)[placeholderView viewWithTag:iTagCol3];	
		int iValCol3 = [txtCol3.text intValue];
		//[txtCol3 release];
		if (iTableFromCol == 0) {
			iTableFromCol = iValCol3;
		}
		
		int iCorrectAnswer = iValCol1 * iValCol3;
		
		if (iCorrectAnswer != iValTheirAnswer) {
			NSString *sTemp = [NSString stringWithFormat:@"%i x %i = %i not %i\n", 
										 iValCol1, iValCol3, iCorrectAnswer, iValTheirAnswer];
			//[sCorrections stringByAppendingString:sTemp];
			[sCorrections appendString:sTemp];
			
			//sCorrections = [[sCorrections autorelease] stringByAppendingString:@"%i x %i = %i not %i", iValCol1, iValCol3, iCorrectAnswer, iValTheirAnswer];
		} else {
			iScore ++;
		}
	}

	iRankScore = iScore; // * iTableFromCol;
	
	/*
	if (iScore == 12) {
		sTimesTableScore = [[NSMutableString alloc] initWithFormat:@"All correct, %i Times Table", iTableFromCol];
	} else {
		sTimesTableScore = [[NSMutableString alloc] initWithFormat:@"%i correct, %i Times Table", iScore, iTableFromCol];

	}
	*/
	sTimesTableUsed = [[NSMutableString alloc] initWithFormat:@"%i x Table", iTableFromCol];
	
	//sTimesTableScore = [[NSMutableString alloc] initWithFormat:@"%i/%i",iScore, iTableFromCol];
	//sTableScore = [NSString stringWithFormat:@"%i/%i",iScore, iTableFromCol];
	// All correct, 12 Times Table
	// 11 correct, 12 Times Table
	
	
	
	iTableScore = iScore;
	
	NSString *msg = nil;
	
	if (booUnanswered == TRUE) {
		msg = @"You have not answered all the questions!";
		
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Results" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	} else {
		/*
		if (iScore != 12) {
			msg = sCorrections;
		} else {
			msg = @"Well done you have got them all correct!";	
		}
		*/
		
		AnswersViewController *nextController = [AnswersViewController alloc];
		nextController.title = @"Results";	
		SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[delegate.navigationController pushViewController:nextController animated:YES];	
		
	}
	
}


-(IBAction)buttonCheat:(id)sender
{
	//NSLog(@"cheat button pressed");

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

- (void)doneButton:(NSNotification *)notification {
	
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

	lblKeyboard.hidden = YES;
	
	if ( mRow < 12 ) {
		int iTagLabel = (100 + (mRow * 10)) + 4;
		UITextField *txtLastVisible = (UITextField *)[placeholderView viewWithTag:iTagLabel];	
		//NSLog(@"PosE");
		if (![txtLastVisible.text isEqualToString:@""]) {
			//NSLog(@"PosE1");
			mRow++;
			[self SayShowRow:mRow];
		}
		//NSLog(@"PosF");
	}
	
	
}

-(IBAction)textFieldDoneEditing:(id)sender
{
	//You might not need this method now since you added the done button 
	//to the numeric pad and handle text fields differently
	[sender resignFirstResponder];

}
-(void)touchesBegan :(NSSet *)touches withEvent:(UIEvent *)event
{
	
	//You might not need this method now since you added the done button 
	//to the numeric pad and handle text fields differently
	
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

	lblKeyboard.hidden = YES;
	
	[super touchesBegan:touches withEvent:event];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	
	//strTableSelected = [NSMutableString stringWithString: @""];
	strTableSelected = [NSString stringWithString: @""];
	
	sTimerStatusGuid = [[AppBasic GUIDString] retain];
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[placeholderView release];
	[textFieldRow1 release];
	[textFieldRow2 release];
	[textFieldRow3 release];
	[textFieldRow4 release];
	[textFieldRow5 release];
	[textFieldRow6 release];
	[textFieldRow7 release];
	[textFieldRow8 release];
	[textFieldRow9 release];
	[textFieldRow10 release];
	[textFieldRow11 release];
	[textFieldRow12 release];
	[tableSelectViewController release];
	[lblKeyboard release];
	[strKeyboardLabelBase release];
	
    [super dealloc];
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
    //if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //}
    

    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0,260,40)];
	if (strTableSelected == @"") {
		rightLabel.text = @"Choose Times Table";
    } else {
		rightLabel.text = [NSString  stringWithFormat:@"The %@ Times Table", strTableSelected];
	}		
    //rightLabel.textColor = [UIColor blueColor];
    rightLabel.textAlignment = UITextAlignmentLeft;
    rightLabel.font = [UIFont boldSystemFontOfSize:14];
	rightLabel.backgroundColor = [UIColor clearColor];//added 18/05/1010
    [cell.contentView addSubview:rightLabel];
    [rightLabel release];
	


	UIButton *btnBackground= [[UIButton alloc] initWithFrame:CGRectMake(0,0,300,45)];
	btnBackground.enabled = NO;
	[AppBasic setButton:btnBackground str:@"blue"];
	[cell.contentView addSubview:btnBackground];
	[btnBackground release];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
    // Navigation logic may go here -- for example, create and push another view controller.
	
	
	TableSelectViewController *nextController = [TableSelectViewController alloc];
	nextController.title = @"Choose times table";	
	SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:nextController animated:YES];	
	
}


@end
