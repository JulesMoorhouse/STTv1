//
//  LearnViewController.h
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

//#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
@class TableSelectViewController;

//NSString *sTimerStatusGuid;//this is the guid we want to be running now, so we would set to something differenty to stop it

@interface LearnViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	IBOutlet UIView *placeholderView;
	IBOutlet UITableView *tblTableSelect;
	TableSelectViewController *tableSelectViewController;
}

@property (nonatomic, retain) UITableView *tblTableSelect;
@property (nonatomic, retain) UIView *placeholderView;
@property (nonatomic, retain) TableSelectViewController *tableSelectViewController;
- (void)ShowTimesTable;
- (void) playSoundShowLabel:(NSTimer*)theTimer;
- (void) hideLabels;

-(IBAction)btnDiscolsurePressed:(id)sender;
@end
