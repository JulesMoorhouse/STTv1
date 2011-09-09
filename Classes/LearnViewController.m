//
//  LearnViewController.m
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>
#import "LearnViewController.h"
#import "SoundEffect.h";
#import "Constants.h";
#import "Speaking.h";
#import "AppBasic.h";
#import "SpeakTimesTableAppDelegate.h"
#import "TableSelectViewController.h"
#import "RootViewController.h";
//#import "GANTracker.h"

@implementation LearnViewController
@synthesize placeholderView;
@synthesize tblTableSelect;
@synthesize tableSelectViewController;

-(void)viewWillAppear:(BOOL)animated {
		
	[tblTableSelect reloadData];
	[self hideLabels];
	
	if (strTableSelected == @"") {
		//
	} else {
		//[tblTableSelect reloadData];
		//[self hideLabels];
		sTimerStatusGuid = [[AppBasic GUIDString] retain];
		[self ShowTimesTable];
	}
	
}
- (void)ShowTimesTable
{
	
	[self hideLabels];

	sTimerStatusGuid = [[AppBasic GUIDString] retain];

	//NSLog(@"Table change Run=%@", sTimerStatusGuid);
		
	int row =1;
	float accumSecs = 2;
	//NSTimer *timer;
	
	NSString *rowAsString;
	
	for (row = 1; row < 13; row++) {
		
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
		
		accumSecs += [Speaking getTrackLength:sWavTimesAc];		
		// ##										  ##
		// ########## COLUMN TIMES - END      ##########

		// ########## COLUMN 3 OF SUM - START ##########
		// ##										  ##
		NSMutableDictionary *dictSum = [[[NSMutableDictionary alloc] init] retain];
		iTagRow ++;
		NSString *sTagLabelSum = [NSString  stringWithFormat:@"%i", iTagRow];
		NSString *sWavSum = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
		NSString *sWavSumAc = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", strTableSelected];
		[dictSum setValue:sWavSum				forKey:@"sWav"];	
		[dictSum setValue:strTableSelected		forKey:@"sLabelValue"];
		[dictSum setValue:sTagLabelSum			forKey:@"sTagLabel"];
		[dictSum setValue:sTimerStatusGuid		forKey:@"sGUIDCheck"];
		
		[NSTimer scheduledTimerWithTimeInterval:accumSecs
										 target:self selector:@selector(playSoundShowLabel:) 
									   userInfo:dictSum repeats:NO];
		[dictSum release];
		
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
		
		accumSecs += [Speaking getTrackLength:sWavEqualsAc];		
		// ##										  ##
		// ########## COLUMN EQUALS - END     ##########
		
		
		// ########## COLUMN RESULT - START   ##########
		// ##										  ##
		iTagRow ++;
		int iTable = [strTableSelected intValue];
		int iSum = row * iTable;
		// need to convert number into multi files
		NSString *sTagLabelResult = [NSString stringWithFormat:@"%i", iTagRow];
		NSString *sSum = [NSString stringWithFormat:@"%d", iSum];
	
		NSMutableArray *arrFiles = [[NSMutableArray alloc] init];  

		[Speaking GetSoundForNumber:iSum sArrFiles:arrFiles];	
		
		int arrayCount = [arrFiles count];
		int cnt = 0;
		
		for (cnt = 0; cnt < arrayCount; cnt++)
		{
			NSString *sFile = [arrFiles objectAtIndex:cnt];
			NSString *sFileAc = [arrFiles objectAtIndex:cnt];
			
			NSMutableDictionary *dictResult = [[[NSMutableDictionary alloc] init] retain];
			
			[dictResult setValue:sFile			forKey:@"sWav"];	
			[dictResult setValue:sSum				forKey:@"sLabelValue"];
			[dictResult setValue:sTagLabelResult	forKey:@"sTagLabel"];
			[dictResult setValue:sTimerStatusGuid	forKey:@"sGUIDCheck"];
			
			[NSTimer scheduledTimerWithTimeInterval:accumSecs
											 target:self selector:@selector(playSoundShowLabel:) 
										   userInfo:dictResult repeats:NO];
			[dictResult release];
			
			accumSecs += [Speaking getTrackLength:sFileAc];			

		}
		
		// ##										  ##
		// ########## COLUMN RESULT - END     ##########
		
		accumSecs += 1;
	}
}


- (void) playSoundShowLabel:(NSTimer*)theTimer
{
	NSMutableDictionary *dict = [theTimer userInfo];
	
	int iTagLabel = [[dict valueForKey:@"sTagLabel"] intValue];
	NSString *sLabelValue = [dict valueForKey:@"sLabelValue"];
	NSString *sGUIDCheck = [dict valueForKey:@"sGUIDCheck"];
	
	//NSLog(@"val=%@ wav=%@", sLabelValue, [dict valueForKey:@"sWav"]);
		  
		  
	if (sTimerStatusGuid == sGUIDCheck) {
		UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagLabel];
		lbl.text = sLabelValue;		
		lbl.hidden = NO;
		
		//TODO
		NSString *path = [[NSBundle mainBundle] pathForResource:[dict valueForKey:@"sWav"] ofType:@"mp3"];
	
		/*
		SystemSoundID soundID;
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
		AudioServicesPlaySystemSound(soundID);
		 */

		AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL]; 
		[theAudio play];
		theAudio.numberOfLoops = 0;
		
		
		[dict release];
		[path release];
	}
	//Removed invalidate as don`t need it as I`m not using repeat, see http://www.iphonedevsdk.com/forum/iphone-sdk-development/48229-nstimer-problems.html
	//[theTimer invalidate];
	//[sGUIDCheck release];
}
- (void) hideLabels
{
	int row =1;
	int col = 1;
	for (row = 1; row < 13; row++) {
		int iTagRow = 100 + (row * 10);
		for (col = 0; col < 6; col++) {	
			UILabel *lbl = (UILabel *)[placeholderView viewWithTag:iTagRow + col];		
			lbl.hidden = YES;		
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	/*
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/learn_opened"
										 withError:&error]) {
		// Handle error here
	}
	*/
	
	//strTableSelected = [NSMutableString stringWithString: @""];
	strTableSelected = [NSString stringWithString: @""];
	
	tblTableSelect.backgroundColor = [UIColor clearColor];
	
	placeholderView.backgroundColor = [UIColor clearColor];
	
	//this add the back button for the answers screen - weird putting it here.
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
    [super viewDidLoad];
	
	//Path get the path to MyTestList.plist
	//NSString *path=[[NSBundle mainBundle] pathForResource:@"MyTestList" ofType:@"plist"];
		
	//Next create the dictionary from the contents of the file.
	//NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:path];
	
	//dict=[NSDictionary dictionaryWithContentsOfFile:path];
	
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
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[placeholderView release];
	[tblTableSelect release];
	[tableSelectViewController release];
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
    
	UIButton *btnBackground = [[UIButton alloc] initWithFrame:CGRectMake(0,0,300,45)];
	if (strTableSelected == @"") {
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

#pragma mark -
#pragma mark Button Event management

-(IBAction)btnDiscolsurePressed:(id)sender {
	TableSelectViewController *nextController = [TableSelectViewController alloc];
	nextController.title = @"Choose times table";	
	SpeakTimesTableAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:nextController animated:YES];
}

@end
