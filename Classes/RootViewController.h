//
//  RootViewController.h
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright Mindwarp Consultancy Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LearnViewController;
@class TestViewController;
@class ResultsViewController;
@class TableSelectViewController;
@class Preloader;

@interface RootViewController : UIViewController <UIActionSheetDelegate> {
	Preloader *resLoaderRef;
	LearnViewController *learnViewController;
	TestViewController *testViewController;	
	ResultsViewController *resultsViewController;
	TableSelectViewController *tableSelectViewController;
	
	IBOutlet UISegmentedControl *segVoiceChoice;
	IBOutlet UIButton *btnLearn;
	IBOutlet UIButton *btnTest;
	IBOutlet UIButton *btnHighScores;
}
@property (retain, nonatomic) LearnViewController *learnViewController;
@property (retain, nonatomic) TestViewController *testViewController;
@property (retain, nonatomic) ResultsViewController *resultsViewController;
@property (retain, nonatomic) TableSelectViewController *tableSelectViewController;
@property (retain, nonatomic) UISegmentedControl *segVoiceChoice;

@property (retain, nonatomic) UIButton *btnLearn;
@property (retain, nonatomic) UIButton *btnTest;
@property (retain, nonatomic) UIButton *btnHighScores;

@property (nonatomic, retain, setter=setLoader) Preloader *resLoaderRef;

-(IBAction)switchToLearnView:(id)sender;
-(IBAction)switchToTestView:(id)sender;
-(IBAction)switchToResultsView:(id)sender;
-(IBAction)switchVoice:(id)sender;

@end
