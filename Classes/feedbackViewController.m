//
//  feedbackViewController.m
//  CalcVat
//
//  Created by aaron Wardle on 15/05/2011.
//  Copyright 2011 Smart PC Solutions Ltd. All rights reserved.
//

#import "feedbackViewController.h"


@implementation feedbackViewController


@synthesize myWebView;




-(IBAction)backButton 
{
    [myWebView goBack];
    
}

-(IBAction)forwardButton
{
    [myWebView goForward];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
  //  [activityIndicator startAnimating];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
 //   [activityIndicator stopAnimating];
    
}


-(IBAction)closeButton
{
    [super dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *urlAddress = @"http://www.kidsmathstore.com/info/speaking-times-tables-v1-2-iphone-feedback-suggestions";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [myWebView loadRequest:requestObj];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
