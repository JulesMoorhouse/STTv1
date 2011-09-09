//
//  InfoViewController.h
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 09/06/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoViewController : UIViewController {
	IBOutlet UIButton *btnDone;
	IBOutlet UITextView *txvContents;
	IBOutlet UILabel *lblTitle;
	IBOutlet UISegmentedControl *segOptions;
}
@property (nonatomic, retain) UIButton *btnDone;
@property (nonatomic, retain) UITextView *txvContents;
@property (nonatomic, retain) UISegmentedControl *segOptions;

-(IBAction)buttonDonePressed:(id)sender;
-(IBAction)segmentedAction:(id)sender;
-(void)setHelpText;
@end
