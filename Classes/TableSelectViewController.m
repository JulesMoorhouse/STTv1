//
//  TableSelectViewController.m
//  SPEAKTIMESTABLE
//
//  Created by Julian Moorhouse on 06/05/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "TableSelectViewController.h"
#import "SpeakTimesTableAppDelegate.h"
#import "AppBasic.h"
//#import "GANTracker.h"

@implementation TableSelectViewController
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;
@synthesize btn5;
@synthesize btn6;
@synthesize btn7;
@synthesize btn8;
@synthesize btn9;
@synthesize btn10;
@synthesize btn11;
@synthesize btn12;

- (IBAction)buttonTablePressed:(id)sender
{
	//[self hideLabels];
	// used a string here so we can add random too
	NSString *str = [sender titleForState:UIControlStateNormal];
	str = [str stringByReplacingOccurrencesOfString:@"x" withString:@""]; 
	
	/*
	NSError *error;
	if (![[GANTracker sharedTracker] trackEvent:@"button_click"
										 action:@"table_select"
										  label:str
										  value:-1
									  withError:&error]) {
		// Handle error here
	}
	*/
	
	//strTableSelected = [[NSMutableString stringWithString: str] retain];	
	strTableSelected = [NSString stringWithString: str];	// added retain 13/05/2010
	
	sTimerStatusGuid = [AppBasic GUIDString];
	//row =1; // row will be incremented on the DONE click of the textfield
	//[self SayShowRow:row];
	[[self navigationController] popViewControllerAnimated: YES];
	
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
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [Constants standardBackgound];

    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"STT2PanelView"
                                                          owner:nil
                                                        options:nil];
    [self.panel addSubview: arrayOfViews[0]];
    
	[AppBasic setButton:btn1 str:@"red"];
	[AppBasic setButton:btn2 str:@"blue"];
	[AppBasic setButton:btn3 str:@"green"];
	[AppBasic setButton:btn4 str:@"yellow"];
	
	[AppBasic setButton:btn5 str:@"red"];
	[AppBasic setButton:btn6 str:@"blue"];
	[AppBasic setButton:btn7 str:@"green"];
	[AppBasic setButton:btn8 str:@"yellow"];
	
	[AppBasic setButton:btn9 str:@"red"];
	[AppBasic setButton:btn10 str:@"blue"];
	[AppBasic setButton:btn11 str:@"green"];
	[AppBasic setButton:btn12 str:@"yellow"];
	
	sTimerStatusGuid = [AppBasic GUIDString]; //added to stop sounds playing while the screen is shown
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
	strTableSelected = @"";
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

-(IBAction)STT2PanelViewTap:(id)sender
{
    [AppBasic STTV2Tap];
}

@end
