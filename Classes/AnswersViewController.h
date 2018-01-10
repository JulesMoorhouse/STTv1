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
	Preloader *resLoaderRef;	
}
-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)buttonSavePressed:(id)sender;
@property (strong, nonatomic) UILabel *lblMessage;
@property (strong, nonatomic) UITextField *txtNickName;
@property (strong, nonatomic) UILabel *lblScore;
@property (strong, nonatomic) UILabel *lblOutOf;
@property (strong, nonatomic) UILabel *lblOutOfLabel;
@property (strong, nonatomic) UILabel *lblResultStatus;
@property (strong, nonatomic) UIButton *btnSave;
@property (nonatomic, strong, setter=setLoader:) Preloader *resLoaderRef;

@end
