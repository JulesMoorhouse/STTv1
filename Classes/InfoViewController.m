//
//  InfoViewController.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 09/06/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "InfoViewController.h"
#import "AppBasic.h"
#import "Constants.h"

@implementation InfoViewController
@synthesize btnDone;
@synthesize txvContents;
@synthesize segOptions;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[AppBasic setButton:btnDone str:@"red"];

	[NSTimer scheduledTimerWithTimeInterval: 2.0 target: self selector:@selector(pulseScrollIndicator:)
												userInfo: nil repeats:YES];
	[self setHelpText];
}

-(void)setHelpText
{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"helptext" ofType:@"txt"];  
	if (filePath) {  
		NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
		if (myText) {  
			txvContents.text= myText;  
		}  
	}
}

-(IBAction)segmentedAction:(id)sender
{
	if (segOptions.selectedSegmentIndex == 0)
    {
		lblTitle.text = NSLocalizedString(@"HELP", @"");
		[self setHelpText];
	}
    else
    {
		lblTitle.text = NSLocalizedString(@"ABOUT", @"");
		
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"credits" ofType:@"txt"];  
		if (filePath)
        {
			NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil]; 
			if (myText)
            {
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

-(IBAction)buttonDonePressed:(id)sender
{
	DLog(@"Done pressed!");
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
