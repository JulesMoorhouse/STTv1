//
//  LearnViewController.m
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "LearnViewController.h"
#import "SoundEffect.h"
#import "Speaking.h"
#import "AppBasic.h"
#import "SpeakTimesTableAppDelegate.h"
#import "TableSelectViewController.h"
#import "RootViewController.h"
//#import "GANTracker.h"

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

	//DLog(@"Table change Run=%@", sTimerStatusGuid);
		
	NSInteger row =1;
	float accumSecs = 2;
	//NSTimer *timer;
	
	NSString *rowAsString;
	
	for (row = 1; row < 13; row++)
    {
		//you probably don`t need retain here now
        rowAsString = [NSString stringWithFormat: @"%ld", (long)row];
		
		NSInteger iTagRow = 100 + (row * 10);
		
		//DLog(@"row=%@ tag=%@", rowAsString, sTagLabel);
		
		// ########## COLUMN 1 OF SUM - START ##########
		// ##										  ##
		NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
        NSString *sTagLabel1 = [NSString  stringWithFormat:@"%li", (long)iTagRow];
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
				
		accumSecs += [Speaking getTrackLength:sWav1Ac];
		//accumSecs += 2;
		
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
	//NSMutableDictionary *dict = [theTimer userInfo];
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[theTimer userInfo]];
    
	NSInteger iTagLabel = [[dict valueForKey:@"sTagLabel"] intValue];
	NSString *sLabelValue = [dict valueForKey:@"sLabelValue"];
	NSString *sGUIDCheck = [dict valueForKey:@"sGUIDCheck"];
	

	if (sTimerStatusGuid == sGUIDCheck) {
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
    
    //[dict release];
    
	//Removed invalidate as don`t need it as I`m not using repeat, see http://www.iphonedevsdk.com/forum/iphone-sdk-development/48229-nstimer-problems.html
	//[theTimer invalidate];
	//[sGUIDCheck release];
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
	for (row = 1; row < 13; row++) {
		NSInteger iTagRow = 100 + (row * 10);
		for (col = 0; col < 6; col++) {	
			UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];		
			lbl.hidden = YES;		
		}		
	}
}

- (void)viewDidLoad {

    self.view.backgroundColor = [Constants standardBackgound];

	strTableSelected = @"";
	
	tblTableSelect.backgroundColor = [UIColor clearColor];
	
	placeholderView.backgroundColor = [UIColor clearColor];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	
    [super viewDidLoad];
	
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    strTableSelected = @"";

    
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat width = screenBounds.size.width;
	UIButton *btnBackground = [[UIButton alloc] initWithFrame:CGRectMake(0,0,width-40,45)];
	if ([strTableSelected  isEqual: @""])
    {
		[btnBackground setTitle: @"   Choose Times Table" forState:UIControlStateNormal];
    }
    else
    {
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
    // Navigation logic may go here -- for example, create and push another view controller.
	
	
	TableSelectViewController *nextController = [TableSelectViewController alloc];
	nextController.title = @"Choose times table";	
	[self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark -
#pragma mark Button Event management

-(IBAction)btnDiscolsurePressed:(id)sender
{
	TableSelectViewController *nextController = [TableSelectViewController alloc];
	nextController.title = @"Choose times table";	
	[self.navigationController pushViewController:nextController animated:YES];
}

@end
