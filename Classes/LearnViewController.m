//
//  LearnViewController.m
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "LearnViewController.h"
#import "Speaking.h"
#import "AppBasic.h"
#import "SpeakTimesTableAppDelegate.h"
#import "TableSelectViewController.h"
#import "RootViewController.h"

@implementation LearnViewController
@synthesize placeholderView;
@synthesize tblTableSelect;
@synthesize tableSelectViewController;
@synthesize theAudio;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
	[tblTableSelect reloadData];
	[self hideLabels];
	
	if ([strTableSelected  isEqual: @""])
    {
		//
	}
    else
    {
		sTimerStatusGuid = [AppBasic GUIDString];
		[self ShowTimesTable];
	}
}

- (void)ShowTimesTable
{
	[self hideLabels];

	sTimerStatusGuid = [AppBasic GUIDString];
		
	NSInteger row =1;
	float accumSecs = 2;
	
	NSString *rowAsString;
	
	for (row = 1; row < 13; row++)
    {
		//you probably don`t need retain here now
        rowAsString = [NSString stringWithFormat: @"%ld", (long)row];
		
		NSInteger iTagRow = 100 + (row * 10);
		
		// ########## COLUMN 1 OF SUM - START ##########
		// ##										  ##
		NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
        NSString *sTagLabel1 = [NSString  stringWithFormat:@"%li", (long)iTagRow];
		NSString *sWav1 = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", rowAsString];
		NSString *sWav1Ac = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", rowAsString];
		
		[dict1 setValue:sWav1					forKey:@"sWav"];
		[dict1 setValue:rowAsString				forKey:@"sLabelValue"];
		[dict1 setValue:sTagLabel1				forKey:@"sTagLabel"];
		[dict1 setValue:sTimerStatusGuid		forKey:@"sGUIDCheck"];
				 
		 [NSTimer scheduledTimerWithTimeInterval:accumSecs
										  target:self selector:@selector(playSoundShowLabel:) 
										userInfo:dict1 repeats:NO];
				
		accumSecs += [Speaking getTrackLength:sWav1Ac];
		
		// ##										  ##
		// ########## COLUMN 1 OF SUM - END   ##########

		// ########## COLUMN TIMES - START    ##########
		// ##										  ##	
		NSMutableDictionary *dictTimes = [[NSMutableDictionary alloc] init];
		iTagRow ++;
        NSString *sTagLabelTimes = [NSString  stringWithFormat:@"%li", (long)iTagRow];
		NSString *sWavTimes = [NSString stringWithFormat:@"%@%@", sVoice, @"-times"];
		NSString *sWavTimesAc = [NSString stringWithFormat:@"%@%@", sVoice, @"-times"];
		
		[dictTimes setValue:sWavTimes			forKey:@"sWav"];	
		[dictTimes setValue:@"x"				forKey:@"sLabelValue"];
		[dictTimes setValue:sTagLabelTimes		forKey:@"sTagLabel"];
		[dictTimes setValue:sTimerStatusGuid	forKey:@"sGUIDCheck"];
		
		[NSTimer scheduledTimerWithTimeInterval:accumSecs
										 target:self selector:@selector(playSoundShowLabel:) 
									   userInfo:dictTimes repeats:NO];
		
		accumSecs += [Speaking getTrackLength:sWavTimesAc];		
		// ##										  ##
		// ########## COLUMN TIMES - END      ##########

		// ########## COLUMN 3 OF SUM - START ##########
		// ##										  ##
		NSMutableDictionary *dictSum = [[NSMutableDictionary alloc] init];
		iTagRow ++;
        NSString *sTagLabelSum = [NSString  stringWithFormat:@"%li", (long)iTagRow];
		NSString *sWavSum = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
		NSString *sWavSumAc = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
		[dictSum setValue:sWavSum				forKey:@"sWav"];	
		[dictSum setValue:strTableSelected		forKey:@"sLabelValue"];
		[dictSum setValue:sTagLabelSum			forKey:@"sTagLabel"];
		[dictSum setValue:sTimerStatusGuid		forKey:@"sGUIDCheck"];
		
		[NSTimer scheduledTimerWithTimeInterval:accumSecs
										 target:self selector:@selector(playSoundShowLabel:) 
									   userInfo:dictSum repeats:NO];
		
		accumSecs += [Speaking getTrackLength:sWavSumAc];		
		// ##										  ##
		// ########## COLUMN 3 OF SUM - END   ##########

		// ########## COLUMN EQUALS - START   ##########
		// ##										  ##
		NSMutableDictionary *dictEquals = [[NSMutableDictionary alloc] init];
		iTagRow ++;
        NSString *sTagLabelEquals = [NSString  stringWithFormat:@"%li", (long)iTagRow];
		NSString *sWavEquals = [NSString stringWithFormat:@"%@%@", sVoice, @"-equals"];
		NSString *sWavEqualsAc = [NSString stringWithFormat:@"%@%@", sVoice, @"-equals"];
		[dictEquals setValue:sWavEquals			forKey:@"sWav"];	
		[dictEquals setValue:@"="				forKey:@"sLabelValue"];
		[dictEquals setValue:sTagLabelEquals		forKey:@"sTagLabel"];
		[dictEquals setValue:sTimerStatusGuid	forKey:@"sGUIDCheck"];
		
		[NSTimer scheduledTimerWithTimeInterval:accumSecs
										 target:self selector:@selector(playSoundShowLabel:) 
									   userInfo:dictEquals repeats:NO];
		
		accumSecs += [Speaking getTrackLength:sWavEqualsAc];		
		// ##										  ##
		// ########## COLUMN EQUALS - END     ##########
		
		
		// ########## COLUMN RESULT - START   ##########
		// ##										  ##
		iTagRow ++;
		NSInteger iTable = [strTableSelected intValue];
		NSInteger iSum = row * iTable;
		// need to convert number into multi files
        NSString *sTagLabelResult = [NSString stringWithFormat:@"%li", (long)iTagRow];
        NSString *sSum = [NSString stringWithFormat:@"%ld", (long)iSum];
	
		NSMutableArray *arrFiles = [[NSMutableArray alloc] init];  

		[Speaking GetSoundForNumber:iSum sArrFiles:arrFiles];	
		
		NSInteger arrayCount = [arrFiles count];
		NSInteger cnt = 0;
		
		for (cnt = 0; cnt < arrayCount; cnt++)
		{
			NSString *sFile = arrFiles[cnt];
			NSString *sFileAc = arrFiles[cnt];
			
			NSMutableDictionary *dictResult = [[NSMutableDictionary alloc] init];
			
			[dictResult setValue:sFile			forKey:@"sWav"];	
			[dictResult setValue:sSum				forKey:@"sLabelValue"];
			[dictResult setValue:sTagLabelResult	forKey:@"sTagLabel"];
			[dictResult setValue:sTimerStatusGuid	forKey:@"sGUIDCheck"];
			
			[NSTimer scheduledTimerWithTimeInterval:accumSecs
											 target:self selector:@selector(playSoundShowLabel:) 
										   userInfo:dictResult repeats:NO];
			
			accumSecs += [Speaking getTrackLength:sFileAc];
		}
		
		// ##										  ##
		// ########## COLUMN RESULT - END     ##########
		
		accumSecs += 1;
	}
}

- (void) playSoundShowLabel:(NSTimer*)theTimer
{
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[theTimer userInfo]];
    
	NSInteger iTagLabel = [[dict valueForKey:@"sTagLabel"] intValue];
	NSString *sLabelValue = [dict valueForKey:@"sLabelValue"];
	NSString *sGUIDCheck = [dict valueForKey:@"sGUIDCheck"];
	
	if (sTimerStatusGuid == sGUIDCheck)
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
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (player == theAudio)
    {
        theAudio = nil;
    }
}

- (void) hideLabels
{
	NSInteger row =1;
	NSInteger col = 1;
	for (row = 1; row < 13; row++)
    {
		NSInteger iTagRow = 100 + (row * 10);
		for (col = 0; col < 6; col++)
        {
			UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];		
			lbl.hidden = YES;		
		}		
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [Constants standardBackgound];

    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"STT2PanelView"
                                                          owner:nil
                                                        options:nil];
    [self.panel addSubview: arrayOfViews[0]];
    
	strTableSelected = @"";
	
	tblTableSelect.backgroundColor = [UIColor clearColor];
	
	placeholderView.backgroundColor = [UIColor clearColor];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Back", @"") style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
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

#pragma mark Table view methods
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
	UIButton *btnBackground = [[UIButton alloc] initWithFrame:CGRectMake(0,0,width-40,45)];
    
	if ([strTableSelected  isEqual: @""])
    {
		[btnBackground setTitle: NSLocalizedString(@"   Choose Times Table", @"")  forState:UIControlStateNormal];
    }
    else
    {
		[btnBackground setTitle:[NSString stringWithFormat:NSLocalizedString(@"   The %@ Times Table", ""), strTableSelected] forState:UIControlStateNormal];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	TableSelectViewController *nextController = [TableSelectViewController alloc];
	nextController.title = NSLocalizedString(@"Choose times table", @"");
	[self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark -
#pragma mark Button Event management
-(IBAction)btnDiscolsurePressed:(id)sender
{
	TableSelectViewController *nextController = [TableSelectViewController alloc];
	nextController.title = NSLocalizedString(@"Choose times table", @"");
	[self.navigationController pushViewController:nextController animated:YES];
}

-(IBAction)STT2PanelViewTap:(id)sender
{
    [AppBasic STTV2Tap];
}
@end
