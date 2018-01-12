//
//  TestViewController.h
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <CMPopTipView/CMPopTipView.h>
#import "Constants.h"
#import "STT2PanelView.h"

#define AlertNavBackButton 1
#define AlertTableButton 2

@class TableSelectViewController;
@class Preloader;
@class RoundRectView;

//NSString *sTimerStatusGuid;//this is the guid we want to be running now, so we would set to something differenty to stop it

@interface TestViewController : UIViewController < UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate, CMPopTipViewDelegate> {

	TableSelectViewController *tableSelectViewController;
	
	IBOutlet UIView *placeholderView;
	IBOutlet UITextField *textFieldRow1;
	IBOutlet UITextField *textFieldRow2;
	IBOutlet UITextField *textFieldRow3;
	IBOutlet UITextField *textFieldRow4;	
	IBOutlet UITextField *textFieldRow5;
	IBOutlet UITextField *textFieldRow6;
	IBOutlet UITextField *textFieldRow7;
	IBOutlet UITextField *textFieldRow8;
	IBOutlet UITextField *textFieldRow9;
	IBOutlet UITextField *textFieldRow10;
	IBOutlet UITextField *textFieldRow11;
	IBOutlet UITextField *textFieldRow12;
	IBOutlet UITableView *tblTableSelect;	
	
	NSInteger mRow;
	NSString *sTable;
	NSMutableString *strKeyboardLabelBase;
	NSMutableString *sCorrections;
	Preloader *resLoaderRef;	
    AVAudioPlayer *theAudio;
}
@property (nonatomic, strong) UITextField *textFieldRow1;
@property (nonatomic, strong) UITextField *textFieldRow2;
@property (nonatomic, strong) UITextField *textFieldRow3;
@property (nonatomic, strong) UITextField *textFieldRow4;
@property (nonatomic, strong) UITextField *textFieldRow5;
@property (nonatomic, strong) UITextField *textFieldRow6;
@property (nonatomic, strong) UITextField *textFieldRow7;
@property (nonatomic, strong) UITextField *textFieldRow8;
@property (nonatomic, strong) UITextField *textFieldRow9;
@property (nonatomic, strong) UITextField *textFieldRow10;
@property (nonatomic, strong) UITextField *textFieldRow11;
@property (nonatomic, strong) UITextField *textFieldRow12;
@property (nonatomic, strong) UITableView *tblTableSelect;
@property (nonatomic, strong) TableSelectViewController *tableSelectViewController;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, strong, setter=setLoader:) Preloader *resLoaderRef;
@property (nonatomic, strong) AVAudioPlayer *theAudio;

@property (strong, nonatomic) IBOutlet STT2PanelView *panel;
-(IBAction)STT2PanelViewTap:(id)sender;

- (void) playSoundShowLabel:(NSTimer*)theTimer;
- (void) hideLabels;
- (void) SayShowRow:(NSInteger)row;
- (void) clearUITextFields;

-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)buttonCheat:(id)sender;

@end
