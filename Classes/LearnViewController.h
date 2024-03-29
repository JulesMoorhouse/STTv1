//
//  LearnViewController.h
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
#import "STT2PanelView.h"

@class TableSelectViewController;

@interface LearnViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,AVAudioPlayerDelegate>{
	IBOutlet UIView *placeholderView;
	IBOutlet UITableView *tblTableSelect;
	TableSelectViewController *tableSelectViewController;
    AVAudioPlayer *theAudio;
}

@property (nonatomic, strong) UITableView *tblTableSelect;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, strong) TableSelectViewController *tableSelectViewController;
@property (nonatomic, strong) AVAudioPlayer *theAudio;

@property (strong, nonatomic) IBOutlet STT2PanelView *panel;

- (void)ShowTimesTable;
- (void) playSoundShowLabel:(NSTimer*)theTimer;
- (void) hideLabels;

-(IBAction)btnDiscolsurePressed:(id)sender;
@end
