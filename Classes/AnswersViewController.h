//
//  AnswersViewController.h
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 29/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Preloader;

@interface AnswersViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UILabel *lblMessage;
	IBOutlet UITextField *txtNickName;
	IBOutlet UILabel *lblScore;
	IBOutlet UILabel *lblOutOf;
	IBOutlet UILabel *lblOutOfLabel;
	IBOutlet UILabel *lblResultStatus;
	IBOutlet UIButton *btnSave;
	IBOutlet UILabel *lblKeyboard;
	Preloader *resLoaderRef;	
}
-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)buttonSavePressed:(id)sender;
@property (retain, nonatomic) UILabel *lblMessage;
@property (retain, nonatomic) UITextField *txtNickName;
@property (retain, nonatomic) UILabel *lblScore;
@property (retain, nonatomic) UILabel *lblOutOf;
@property (retain, nonatomic) UILabel *lblOutOfLabel;
@property (retain, nonatomic) UILabel *lblResultStatus;
@property (retain, nonatomic) UIButton *btnSave;
@property (nonatomic, retain) UILabel *lblKeyboard;
@property (nonatomic, retain, setter=setLoader) Preloader *resLoaderRef;

@end
