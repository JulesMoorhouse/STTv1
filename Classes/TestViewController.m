//
//  TestViewController.m
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TestViewController.h"
#import "Speaking.h"
#import "AppBasic.h"
#import "SpeakTimesTableAppDelegate.h"
#import "AnswersViewController.h"
#import "TableSelectViewController.h"
#import "RootViewController.h"
#import "Preloader.h"
#import "Prefs.h"
#import "CBBezier.h"

@interface UIView (FindAndResignFirstResponder)
- (UIView*)findFirstResponder;
@end
@implementation UIView (FindAndResignFirstResponder)
- (UIView*)findFirstResponder
{
    if (self.isFirstResponder)
    {
        [self resignFirstResponder];
        return self;
    }
    for (UIView *subView in self.subviews)
    {
        if ([subView findFirstResponder])
            return subView;
    }
    return nil;
}
@end

@implementation TestViewController

#pragma mark - Properties
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
@synthesize resLoaderRef;
@synthesize theAudio;

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [Constants standardBackgound];
    
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"STT2PanelView"
                                                          owner:nil
                                                        options:nil];
    [self.panel addSubview: arrayOfViews[0]];
    [arrayOfViews[0] addTarget:self action:@selector(STT2PanelViewTap) forControlEvents:UIControlEventTouchUpInside];
    
    strTableSelected = @"";

    mRow = 1;
    
    placeholderView.backgroundColor = [UIColor clearColor];
    
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
    
    //this add the back button for the answers screen - weird putting it here.
    UIBarButtonItem *backButtonAnswers = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Back", @"")
                                                                          style: UIBarButtonItemStylePlain
                                                                         target: nil
                                                                         action: nil];
    self.navigationItem.backBarButtonItem = backButtonAnswers;
    
    
    UIBarButtonItem *finishNavButton = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Finish", @"")
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(btnNavFinishedTest:)];
    self.navigationItem.rightBarButtonItem = finishNavButton;
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Back", @"")
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(BackButtonPressed)];
    self.navigationItem.leftBarButtonItem = backNavButton;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self clearUITextFields];
    [tblTableSelect reloadData];
    [self hideLabels];
    
    if ([strTableSelected  isEqual: @""])
    {
        [self checkSavedAnswers];
    }
    else
    {
        sTimerStatusGuid = [AppBasic GUIDString];
        mRow = 1; // row will be incremented on the DONE click of the textfield
        #pragma mRow = 1
        [self SayShowRow:mRow];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [self storeAnswers];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    strTableSelected = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TextField methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length > 0 && [string length] == 0)
    {
        // enable delete
        return YES;
    }
    
	BOOL res = TRUE;
    static NSString *numbers = @"0123456789";

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    res = !([newString length] > 3);
    
    if (res)
    {
        NSCharacterSet *characterSet;
        characterSet = [[NSCharacterSet characterSetWithCharactersInString:numbers] invertedSet];
        res = ([[string stringByTrimmingCharactersInSet:characterSet] length] > 0);
    }
    
	if (res == TRUE)
    {
		if ([newString isEqualToString:@""])
        {
			textField.toolbarPlaceholder = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, @"?"];
		}
        else
        {
		    textField.toolbarPlaceholder = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, newString];
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
	UILabel *lblRow = (UILabel *)[placeholderView viewWithTag:(textField.tag-4)];
	
	strKeyboardLabelBase = [[NSMutableString alloc] initWithFormat:@"%@ x %@ = ", lblRow.text, strTableSelected];
	textField.toolbarPlaceholder = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, @"?"];
    
    if (![textField.text isEqualToString:@""])
    {
        textField.text = @"";
    }
    NSInteger row = (((textField.tag)-100)/10);
    if (mRow != row)
    {
        sTimerStatusGuid = [AppBasic GUIDString];
        mRow = row;
        [self SayShowRow: row];
    }

	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
	
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}

#pragma mark - Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat width = screenBounds.size.width;
	CBBezier *btnBackground = [[CBBezier alloc] initWithFrame:CGRectMake(0,0,width-40,45)];
	if ([strTableSelected  isEqual: @""])
    {
		[btnBackground setTitle: NSLocalizedString(@"   Choose Times Table", @"")
                       forState:UIControlStateNormal];
    }
    else
    {
		[btnBackground setTitle:[NSString stringWithFormat: NSLocalizedString(@"   The %@ Times Table", ""), strTableSelected] forState:UIControlStateNormal];
	}		
	
    // --- accessibility ---
    btnBackground.isAccessibilityElement = YES;
    btnBackground.accessibilityLabel = @"Choose Times Table";
    btnBackground.accessibilityTraits = UIAccessibilityTraitStaticText;
    btnBackground.userInteractionEnabled = true;
    // --- accessibility ---
    
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	[cell setBackgroundColor:[UIColor clearColor]];
	
	btnBackground.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	btnBackground.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [btnBackground setBackgroundColor:[UIColor clearColor]];
    
    [btnBackground setTitleColor: [UIColor darkGrayColor] forState:UIControlStateNormal];

	// Set button enabled to get it's touch effect & also set event receiver method
	btnBackground.enabled = YES;
	[btnBackground addTarget:self action:@selector(btnDiscolsurePressed:) forControlEvents:UIControlEventTouchUpInside];
		
	// add button first and then label to display label 
	[cell.contentView addSubview:btnBackground];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

#pragma mark - Buttons
-(IBAction)btnDiscolsurePressed:(id)sender
{
    UIView* firstResponder = [self.view findFirstResponder];
    [firstResponder resignFirstResponder];

    TableSelectViewController *nextController = [TableSelectViewController alloc];
    nextController.title = NSLocalizedString(@"Choose times table", @"");
    [self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)buttonCheat:(id)sender
{
    NSInteger row =1;
    NSInteger col = 1;
    NSString *strCol1Row1;
    
    for (row = 1; row < 13; row++)
    {
        NSInteger iTagRow = 100 + (row * 10);
        for (col = 0; col < 5; col++)
        {
            UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];
            lbl.hidden = NO;
            if (row == 1)
            {
                if (col == 2)
                {
                    strCol1Row1 = lbl.text;
                }
            }
            if (col == 2)
            {
                lbl.text = strCol1Row1;
            }
        }
    }
    
    for (row = 1; row < 13; row++)
    {
        NSInteger iTagRow = 100 + (row * 10);
        NSInteger col1;
        NSInteger col3;
        NSInteger res;
        for (col = 0; col < 5; col++)
        {
            if (col < 4)
            {
                UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];
                lbl.hidden = NO;
                if (col == 0)
                {
                    col1 = [lbl.text intValue];
                }
                if (col == 2)
                {
                    col3 = [lbl.text intValue];
                }
            }
            else
            {
                UITextField *txt = (UITextField *)[placeholderView viewWithTag:iTagRow + col];
                txt.hidden = NO;
                res = col1 * col3;
            }
            switch (row)
            {
                case 1:
                {
                    textFieldRow1.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 2:
                {
                    textFieldRow2.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 3:
                {
                    textFieldRow3.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 4:
                {
                    textFieldRow4.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 5:
                {
                    textFieldRow5.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 6:
                {
                    textFieldRow6.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 7:
                {
                    textFieldRow7.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 8:
                {
                    textFieldRow8.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 9:
                {
                    textFieldRow9.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 10:
                {
                    textFieldRow10.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 11:
                {
                    textFieldRow11.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                case 12:
                {
                    textFieldRow12.text = [NSString stringWithFormat:@"%ld", (long)res];
                    break;
                }
                default:
                    break;
            }
        }
    }
    
    [self showTooltip];
}


- (void)btnNavFinishedTest:(id)sender
{
    BOOL booUnanswered = FALSE;
    NSInteger row =1;
    NSInteger iScore = 0;
    
    sCorrections = [[NSMutableString alloc] initWithString:@""];
    
    NSInteger iTableFromCol = 0;
    
    for (row = 1; row < 13; row++)
    {
        NSInteger iTagRow = (100 + (row * 10));
        
        NSInteger iTagAnswer = iTagRow+4;
        UITextField *txtAnswer = (UITextField *)[placeholderView viewWithTag:iTagAnswer];
        
        if ([txtAnswer.text isEqualToString:@""])
        {
            booUnanswered = TRUE;
            break;
        }
        NSInteger iValTheirAnswer = [txtAnswer.text intValue];
        
        NSInteger iTagCol1 = iTagRow;
        UITextField *txtCol1 = (UITextField *)[placeholderView viewWithTag:iTagCol1];
        NSInteger iValCol1 = [txtCol1.text intValue];
        
        NSInteger iTagCol3 = iTagRow+2;
        UITextField *txtCol3 = (UITextField *)[placeholderView viewWithTag:iTagCol3];
        NSInteger iValCol3 = [txtCol3.text intValue];
        
        if (iTableFromCol == 0)
        {
            iTableFromCol = iValCol3;
        }
        
        NSInteger iCorrectAnswer = iValCol1 * iValCol3;
        
        if (iCorrectAnswer != iValTheirAnswer)
        {
            NSString *sTemp = [NSString stringWithFormat:@"%li x %li = %li not %li\n",
                               (long)iValCol1, (long)iValCol3, (long)iCorrectAnswer, (long)iValTheirAnswer];
            [sCorrections appendString:sTemp];
        }
        else
        {
            iScore ++;
        }
    }
    
    [Prefs storeSettingInt:pfRankScore Value:iScore];
    [Prefs storeSettingStr:pfTimesTableUsed Value:[[NSMutableString alloc] initWithFormat:@"%li x Table", (long)iTableFromCol]];
    [Prefs storeSettingInt:pfTableScore Value:iScore];
    
    UIView* firstResponder = [self.view findFirstResponder];
    [firstResponder resignFirstResponder];
    if (!booUnanswered)
    {
        [self clearStoredAnswers];
    }
    AnswersViewController *nextController = [AnswersViewController alloc];
    nextController.title = NSLocalizedString(@"Results", @"");
    [nextController setLoader:resLoaderRef];
    [self.navigationController pushViewController:nextController animated:YES];
}

- (void) BackButtonPressed
{
    UIView* firstResponder = [self.view findFirstResponder];
    [firstResponder resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneButtonPressed:(UITextField*)sender
{
    if ([textFieldRow1 isEditing])
    {
        [textFieldRow1 resignFirstResponder];
    }
    else if ([textFieldRow2 isEditing])
    {
        [textFieldRow2 resignFirstResponder];
    }
    else if ([textFieldRow3 isEditing])
    {
        [textFieldRow3 resignFirstResponder];
    }
    else if ([textFieldRow4 isEditing])
    {
        [textFieldRow4 resignFirstResponder];
    }
    else if ([textFieldRow5 isEditing])
    {
        [textFieldRow5 resignFirstResponder];
    }
    else if ([textFieldRow6 isEditing])
    {
        [textFieldRow6 resignFirstResponder];
    }
    else if ([textFieldRow7 isEditing])
    {
        [textFieldRow7 resignFirstResponder];
    }
    else if ([textFieldRow8 isEditing])
    {
        [textFieldRow8 resignFirstResponder];
    }
    else if ([textFieldRow9 isEditing])
    {
        [textFieldRow9 resignFirstResponder];
    }
    else if ([textFieldRow10 isEditing])
    {
        [textFieldRow10 resignFirstResponder];
    }
    else if ([textFieldRow11 isEditing])
    {
        [textFieldRow11 resignFirstResponder];
    }
    else if ([textFieldRow12 isEditing])
    {
        [textFieldRow12 resignFirstResponder];
    }
}

// NumberKeypadModControllerDelegate method
- (void)keyboardDonePressed:(id)sender
{
    UIView* firstResponder = [self.view findFirstResponder];
    [firstResponder resignFirstResponder];
    
    if ( mRow < 12 )
    {
        NSInteger iTagLabel = (100 + (mRow * 10)) + 4;
        UITextField *txtLastVisible = (UITextField *)[placeholderView viewWithTag:iTagLabel];
        if (![txtLastVisible.text isEqualToString:@""])
        {
            mRow = mRow + 1;
            #pragma mRow + 1
            [self SayShowRow:mRow];
        }
    }
    else
    {
        [self showTooltip];
    }
}

#pragma mark - Handlers
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (player == theAudio)
    {
        theAudio = nil;
    }
}

-(void)touchesBegan :(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView* firstResponder = [self.view findFirstResponder];
    [firstResponder resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];
}

// CMPopTipViewDelegate method
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    // any code
}

#pragma mark - Functions
- (void) SayShowRow:(NSInteger)row
{
    NSInteger iTagRow = 100 + (row * 10);
    
    UITextField *txt = (UITextField *)[placeholderView viewWithTag: iTagRow+4];
//    if (![txt.text isEqualToString:@""])
//    {
//        return;
//    }
    
    float accumSecs = 0;
    NSString *rowAsString;
    
    rowAsString = [NSString stringWithFormat: @"%ld", (long)row];
    
    // ########## COLUMN 1 OF SUM - START ##########
    // ##                                          ##
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    NSString *sTagLabel1 = [NSString  stringWithFormat:@"%li", (long)iTagRow];
    NSString *sWav1 = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", rowAsString];
    NSString *sWav1Ac = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", rowAsString];
    
    [dict1 setValue:sWav1                    forKey:@"sWav"];
    [dict1 setValue:rowAsString                forKey:@"sLabelValue"];
    [dict1 setValue:sTagLabel1                forKey:@"sTagLabel"];
    [dict1 setValue:sTimerStatusGuid        forKey:@"sGUIDCheck"];
    
    [NSTimer scheduledTimerWithTimeInterval:accumSecs
                                     target:self selector:@selector(playSoundShowLabel:)
                                   userInfo:dict1 repeats:NO];
    
    accumSecs += [Speaking getTrackLength:sWav1Ac];
    
    // ##                                          ##
    // ########## COLUMN 1 OF SUM - END   ##########
    
    // ########## COLUMN TIMES - START    ##########
    // ##                                          ##
    NSMutableDictionary *dictTimes = [[NSMutableDictionary alloc] init];
    iTagRow ++;
    NSString *sTagLabelTimes = [NSString  stringWithFormat:@"%li", (long)iTagRow];
    NSString *sWavTimes = [NSString stringWithFormat:@"%@%@", sVoice, @"-times"];
    NSString *sWavTimesAc = [NSString stringWithFormat:@"%@%@", sVoice, @"-times"];
    
    [dictTimes setValue:sWavTimes            forKey:@"sWav"];
    [dictTimes setValue:@"x"                forKey:@"sLabelValue"];
    [dictTimes setValue:sTagLabelTimes        forKey:@"sTagLabel"];
    [dictTimes setValue:sTimerStatusGuid    forKey:@"sGUIDCheck"];
    
    [NSTimer scheduledTimerWithTimeInterval:accumSecs
                                     target:self selector:@selector(playSoundShowLabel:)
                                   userInfo:dictTimes repeats:NO];
    
    accumSecs += [Speaking getTrackLength:sWavTimesAc];
    // ##                                          ##
    // ########## COLUMN TIMES - END      ##########
    
    // ########## COLUMN 3 OF SUM - START ##########
    // ##                                          ##
    
    NSMutableDictionary *dictSum = [[NSMutableDictionary alloc] init];
    iTagRow ++;
    
    NSString *sTagLabelSum = [NSString  stringWithFormat:@"%li", (long)iTagRow];
    
    NSString *sWavSum = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
    NSString *sWavSumAc = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
    
    [dictSum setValue:sWavSum                forKey:@"sWav"];
    [dictSum setValue:strTableSelected                forKey:@"sLabelValue"];
    [dictSum setValue:sTagLabelSum            forKey:@"sTagLabel"];
    [dictSum setValue:sTimerStatusGuid        forKey:@"sGUIDCheck"];
    
    [NSTimer scheduledTimerWithTimeInterval:accumSecs
                                     target:self selector:@selector(playSoundShowLabel:)
                                   userInfo:dictSum repeats:NO];
    
    accumSecs += [Speaking getTrackLength:sWavSumAc];
    // ##                                          ##
    // ########## COLUMN 3 OF SUM - END   ##########
    
    // ########## COLUMN EQUALS - START   ##########
    // ##                                          ##
    NSMutableDictionary *dictEquals = [[NSMutableDictionary alloc] init];
    iTagRow ++;
    NSString *sTagLabelEquals = [NSString  stringWithFormat:@"%li", (long)iTagRow];
    NSString *sWavEquals = [NSString stringWithFormat:@"%@%@", sVoice, @"-equals"];
    NSString *sWavEqualsAc = [NSString stringWithFormat:@"%@%@", sVoice, @"-equals"];
    [dictEquals setValue:sWavEquals            forKey:@"sWav"];
    [dictEquals setValue:@"="                forKey:@"sLabelValue"];
    [dictEquals setValue:sTagLabelEquals        forKey:@"sTagLabel"];
    [dictEquals setValue:sTimerStatusGuid    forKey:@"sGUIDCheck"];
    
    [NSTimer scheduledTimerWithTimeInterval:accumSecs
                                     target:self selector:@selector(playSoundShowLabel:)
                                   userInfo:dictEquals repeats:NO];
    
    accumSecs += [Speaking getTrackLength:sWavEqualsAc];
    // ##                                          ##
    // ########## COLUMN EQUALS - END     ##########
    
    
    // ########## COLUMN RESULT - START   ##########
    // ##                                          ##
    NSMutableDictionary *dictResult = [[NSMutableDictionary alloc] init];
    iTagRow ++;
    NSString *sTagLabelResult = [NSString  stringWithFormat:@"%li", (long)iTagRow];
    [dictResult setValue:@""            forKey:@"sWav"];
    [dictResult setValue:@""                forKey:@"sLabelValue"];
    [dictResult setValue:sTagLabelResult        forKey:@"sTagLabel"];
    [dictResult setValue:sTimerStatusGuid    forKey:@"sGUIDCheck"];
    
    [NSTimer scheduledTimerWithTimeInterval:accumSecs
                                     target:self selector:@selector(playSoundShowLabel:)
                                   userInfo:dictResult repeats:NO];
    
    strKeyboardLabelBase = [[NSMutableString alloc] initWithFormat:@"%@ x %@ = ", rowAsString, strTableSelected];
    
    //UITextField *txt = (UITextField *)[placeholderView viewWithTag: iTagRow];
    txt.toolbarPlaceholder = [NSString stringWithFormat:@"%@%@", strKeyboardLabelBase, @"?"];
    [txt.keyboardToolbar.doneBarButton setTarget:self action: @selector(keyboardDonePressed:)];
    
    accumSecs += 2;
    // ##                                          ##
    // ########## COLUMN RESULT - END     ##########
    
    accumSecs += 1;
    
    if ( accumSecs == 0) {
        DLog(@"Anything to stop analyzer warning");
    }
}

- (void) playSoundShowLabel:(NSTimer*)theTimer
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[theTimer userInfo]];
    
    NSString *sGUIDCheck = [dict valueForKey:@"sGUIDCheck"];
    
    if (sTimerStatusGuid == sGUIDCheck)
    {
        NSInteger iTagLabel = [[dict valueForKey:@"sTagLabel"] intValue];
        NSString *sLabelValue = [dict valueForKey:@"sLabelValue"];
        
        if (![sLabelValue isEqualToString:@""])
        {
            UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagLabel];
            
            lbl.text = sLabelValue;
            
            lbl.hidden = NO;
            
            NSURL *clickURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], [dict valueForKey:@"sWav"]]];
            
            theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:
                        clickURL error:nil];
            theAudio.delegate = self;
            
            [theAudio play];
            theAudio.numberOfLoops = 0;
        }
        else
        {
            UITextField *txt = (UITextField *)[placeholderView viewWithTag:iTagLabel];
            txt.hidden = NO;
            [txt becomeFirstResponder];
        }
    }
}

- (void)clearUITextFields
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
    NSInteger row =1;
    NSInteger col = 1;
    
    for (row = 1; row < 13; row++)
    {
        NSInteger iTagRow = 100 + (row * 10);
        for (col = 0; col < 5; col++)
        {
            if (col < 4)
            {
                UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];
                lbl.hidden = YES;
            }
            else
            {
                UITextField *txt = (UITextField *)[placeholderView viewWithTag:iTagRow + col];
                txt.hidden = YES;
            }
        }
    }
}

-(void)showTooltip
{
    CMPopTipView *navBarLeftButtonPopTipView = [[CMPopTipView alloc] initWithMessage:@"Tap finish now?"];
    navBarLeftButtonPopTipView.delegate = self;
    navBarLeftButtonPopTipView.dismissTapAnywhere = YES;
    navBarLeftButtonPopTipView.backgroundColor = [UIColor whiteColor];
    navBarLeftButtonPopTipView.textColor = [UIColor darkTextColor];
    
    [navBarLeftButtonPopTipView presentPointingAtBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

- (void)STT2PanelViewTap
{
    [AppBasic STTV2Tap];
}

-(void)clearStoredAnswers
{
    [Prefs storeSettingStr: @"answers" Value: @""];
    [self clearUITextFields];
}

-(void)storeAnswers
{
    NSString *strAllValues = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",
                              ([textFieldRow1.text length] == 0 ? @"?" : textFieldRow1.text),
                              ([textFieldRow2.text length] == 0 ? @"?" : textFieldRow2.text),
                              ([textFieldRow3.text length] == 0 ? @"?" : textFieldRow3.text),
                              ([textFieldRow4.text length] == 0 ? @"?" : textFieldRow4.text),
                              ([textFieldRow5.text length] == 0 ? @"?" : textFieldRow5.text),
                              ([textFieldRow6.text length] == 0 ? @"?" : textFieldRow6.text),
                              ([textFieldRow7.text length] == 0 ? @"?" : textFieldRow7.text),
                              ([textFieldRow8.text length] == 0 ? @"?" : textFieldRow8.text),
                              ([textFieldRow9.text length] == 0 ? @"?" : textFieldRow9.text),
                              ([textFieldRow10.text length] == 0 ? @"?" : textFieldRow10.text),
                              ([textFieldRow11.text length] == 0 ? @"?" : textFieldRow11.text),
                              ([textFieldRow12.text length] == 0 ? @"?" : textFieldRow12.text)];
    
    [Prefs storeSettingStr: @"answers" Value: strAllValues];
    [Prefs storeSettingStr: @"table" Value: strTableSelected];
}

-(void)checkSavedAnswers
{
    NSString *strAllValues = [Prefs returnSettingStr: @"answers" defaultValue: @""];

    if (![strAllValues isEqualToString:@""])
    {
        strTableSelected = [Prefs returnSettingStr: @"table" defaultValue: @""];

        NSArray* items = [strAllValues componentsSeparatedByString:@","];
        NSInteger col = 1;
        mRow = 1;
        
        for (NSInteger row = 1; row < 13; row++)
        {
            NSString *str = items[row-1];
            bool on = ![str isEqualToString:@"?"];
            [self setItemValue: row
                           val: str
                            on: on];
            
            NSInteger iTagRow = 100 + (row * 10);
            for (col = 0; col < 4; col++)
            {
                UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];
                lbl.hidden = !on;
                
                if (col == 2)
                {
                    lbl.text = strTableSelected;
                }
            }
        }

        //unhide any below rows which are not answered too
        for (NSInteger row = 1; row <= mRow; row++)
        {
            NSInteger iTagRow = 100 + (row * 10);

            for (col = 0; col < 4; col++)
            {
                UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];
                lbl.hidden = NO;
            }
            UITextField *txt = (UITextField *)[placeholderView viewWithTag: iTagRow + 4];
            txt.hidden = NO;

        }
        
        [self SayShowRow: mRow];
    }
}

-(void)setItemValue:(NSInteger)row val:(NSString*)val on:(BOOL)on
{
    NSInteger tag = 100 + (row * 10) + 4;
    UITextField *txt = (UITextField *)[placeholderView viewWithTag: tag];
    
    txt.hidden = !on;
    if (on)
    {
        txt.text = val;
        if (![txt.text isEqualToString:@""])
        {
            mRow = row + 1;
        }
    }
    else
    {
        txt.text = @"";
    }
}

@end
