//
//  RootViewController.h
//  TestNavBasedApp
//
//  Created by Julian Moorhouse on 31/03/2010.
//  Copyright Mindwarp Consultancy Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

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
@property (strong, nonatomic) LearnViewController *learnViewController;
@property (strong, nonatomic) TestViewController *testViewController;
@property (strong, nonatomic) ResultsViewController *resultsViewController;
@property (strong, nonatomic) TableSelectViewController *tableSelectViewController;
@property (strong, nonatomic) UISegmentedControl *segVoiceChoice;

@property (strong, nonatomic) UIButton *btnLearn;
@property (strong, nonatomic) UIButton *btnTest;
@property (strong, nonatomic) UIButton *btnHighScores;

@property (nonatomic, strong, setter=setLoader:) Preloader *resLoaderRef;

-(IBAction)switchToLearnView:(id)sender;
-(IBAction)switchToTestView:(id)sender;
-(IBAction)switchToResultsView:(id)sender;
-(IBAction)switchVoice:(id)sender;

@end
