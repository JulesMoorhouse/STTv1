//
//  TestViewController.h
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import "NumberKeypadModController.h"

#define AlertNavBackButton 1
#define AlertTableButton 2

@class TableSelectViewController;
@class Preloader;
@class RoundRectView;

//NSString *sTimerStatusGuid;//this is the guid we want to be running now, so we would set to something differenty to stop it

@interface TestViewController : UIViewController < UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, 
		NumberKeypadModControllerDelegate> {

	NumberKeypadModController *numberKeyPadModController;
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
	IBOutlet UILabel *lblKeyboard;
	
	int mRow;
	NSString *sTable;
	NSMutableString *strKeyboardLabelBase;
	NSMutableString *sCorrections;
	Preloader *resLoaderRef;	
	BOOL finishShowingPathNavHighlighter;
	RoundRectView *rrv;		
}
@property(nonatomic,retain) NumberKeypadModController *numberKeyPadModController;
@property (nonatomic, retain) UITextField *textFieldRow1;
@property (nonatomic, retain) UITextField *textFieldRow2;
@property (nonatomic, retain) UITextField *textFieldRow3;
@property (nonatomic, retain) UITextField *textFieldRow4;
@property (nonatomic, retain) UITextField *textFieldRow5;
@property (nonatomic, retain) UITextField *textFieldRow6;
@property (nonatomic, retain) UITextField *textFieldRow7;
@property (nonatomic, retain) UITextField *textFieldRow8;
@property (nonatomic, retain) UITextField *textFieldRow9;
@property (nonatomic, retain) UITextField *textFieldRow10;
@property (nonatomic, retain) UITextField *textFieldRow11;
@property (nonatomic, retain) UITextField *textFieldRow12;
@property (nonatomic, retain) UITableView *tblTableSelect;
@property (nonatomic, retain) TableSelectViewController *tableSelectViewController;
@property (nonatomic, retain) UIView *placeholderView;
@property (nonatomic, retain) UILabel *lblKeyboard;
@property (nonatomic, retain, setter=setLoader) Preloader *resLoaderRef;
@property (nonatomic, retain) RoundRectView *rrv;

- (void)buttonNavDone:(id)sender;
- (void) playSoundShowLabel:(NSTimer*)theTimer;
- (void) hideLabels;
- (void) SayShowRow:(int)row;
- (void) clearUITextFields;

-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)buttonCheat:(id)sender;
-(IBAction)btnDiscolsurePressed:(id)sender;

@end
