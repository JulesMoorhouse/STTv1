//
//  feedbackViewController.h
//  CalcVat
//
//  Created by aaron Wardle on 15/05/2011.
//  Copyright 2011 Smart PC Solutions Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface feedbackViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *myWebView;
    
  //  IBOutlet UIActivityIndicatorView *activityIndicator;
    
}


@property (nonatomic, strong) UIWebView *myWebView;
//@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;


-(IBAction)backButton;
-(IBAction)forwardButton;
-(IBAction)closeButton;


@end
