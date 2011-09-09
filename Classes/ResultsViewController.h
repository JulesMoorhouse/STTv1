//
//  ResultsViewController.h
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 28/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kNameValueTag     1
#define kDateValueTag    2
#define kTableUsedTag    3
#define kScoreValueTag    4

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface ResultsViewController : UITableViewController 
	<UITableViewDataSource, UITableViewDelegate> 
{
    NSArray    *results;
}
@property (nonatomic, retain) NSArray *results;
@end
