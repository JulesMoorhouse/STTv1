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
	NSString *str = [sender titleForState:UIControlStateNormal];
	str = [str stringByReplacingOccurrencesOfString:@"x" withString:@""]; 
	
	strTableSelected = [NSString stringWithString: str];
	sTimerStatusGuid = [AppBasic GUIDString];

	[[self navigationController] popViewControllerAnimated: YES];
}

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
	strTableSelected = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];    
}

-(IBAction)STT2PanelViewTap:(id)sender
{
    [AppBasic STTV2Tap];
}

@end
