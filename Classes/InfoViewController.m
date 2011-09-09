//
//  InfoViewController.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 09/06/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "InfoViewController.h"
#import "AppBasic.h"

@implementation InfoViewController
@synthesize btnDone;
@synthesize txvContents;
@synthesize segOptions;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[AppBasic setButton:btnDone str:@"red"];

	[NSTimer scheduledTimerWithTimeInterval: 2.0 target: self selector:@selector(pulseScrollIndicator:)
												userInfo: nil repeats:YES];
	[self setHelpText];
}
-(void)setHelpText {
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"helptext" ofType:@"txt"];  
	if (filePath) {  
		NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
		if (myText) {  
			txvContents.text= myText;  
		}  
	}  
	
}
-(IBAction)segmentedAction:(id)sender {

	if (segOptions.selectedSegmentIndex == 0) {
		lblTitle.text = @"HELP";		
		[self setHelpText];
	} else {
		lblTitle.text = @"ABOUT";	
		
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"credits" ofType:@"txt"];  
		if (filePath) {  
			NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil]; 
			if (myText) {  
				txvContents.text= myText;  
			}  
		}  

	}
	
}

- (void) pulseScrollIndicator:(NSTimer*)theTimer
{
	txvContents.showsVerticalScrollIndicator = YES;
	[txvContents flashScrollIndicators];
}

-(IBAction)buttonDonePressed:(id)sender{
	
	NSLog(@"Done pressed!");
	[self dismissModalViewControllerAnimated:YES];
	[self release];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[btnDone release];
	[txvContents release];
    [super dealloc];
}


@end
