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
    [arrayOfViews[0] addTarget:self action:@selector(STT2PanelViewTap) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)STT2PanelViewTap
{
    [AppBasic STTV2Tap];
}

@end
