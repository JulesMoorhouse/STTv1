//
//  ResultsViewController.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 28/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "ResultsViewController.h"
#import "highScores.h"
//#import "GANTracker.h"

@implementation ResultsViewController
@synthesize results;


- (void)viewDidLoad {
    [super viewDidLoad];
    
	//DLog(@"ResultsViewController.viewDidLoad start");
	
	/*
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/results_opened"
										 withError:&error]) {
		// Handle error here
	}
	*/
	
	//highScores *MyHigh = [highScores init];
	highScores *MyResults = [[highScores alloc] init];
	//MyHigh.initialize;

	//DLog(@"ResultsViewController.viewDidLoad a");
	
	[MyResults load];
	//[MyHigh save:50 name:@"billy"];
	
	//DLog(@"ResultsViewController.viewDidLoad b");
	
	[MyResults debug];
	
	
    //NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:
    //                      @"MacBook", @"Name", @"White", @"Color", nil];
	
	//DLog(@"ResultsViewController.viewDidLoad 1");
	
	/*
	NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyHigh GetNameByIdx:0], @"Name", [MyHigh GetScoreByIdx:0], @"Color", nil];
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyHigh GetNameByIdx:1], @"Name", [MyHigh GetScoreByIdx:1], @"Color", nil];
	NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyHigh GetNameByIdx:2], @"Name", [MyHigh GetScoreByIdx:2], @"Color", nil];
	NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyHigh GetNameByIdx:3], @"Name", [MyHigh GetScoreByIdx:3], @"Color", nil];
	NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyHigh GetNameByIdx:4], @"Name", [MyHigh GetScoreByIdx:4], @"Color", nil];
	NSDictionary *row6 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyHigh GetNameByIdx:5], @"Name", [MyHigh GetScoreByIdx:5], @"Color", nil];
	NSDictionary *row7 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyHigh GetNameByIdx:6], @"Name", [MyHigh GetScoreByIdx:6], @"Color", nil];
	NSDictionary *row8 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyHigh GetNameByIdx:7], @"Name", [MyHigh GetScoreByIdx:7], @"Color", nil];
	NSDictionary *row9 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyHigh GetNameByIdx:8], @"Name", [MyHigh GetScoreByIdx:8], @"Color", nil];
	NSDictionary *row10 = [[NSDictionary alloc] initWithObjectsAndKeys:
						   [MyHigh GetNameByIdx:9], @"Name", [MyHigh GetScoreByIdx:9], @"Color", nil];
	*/
	
	NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:0], @"Name", [MyResults GetTableScoreByIdx:0], @"TableUsed", 
						  [MyResults GetMarkByIdx:0], @"Score", [MyResults GetTestDateByIdx:0], @"Date", nil];
	
	//DLog(@"ResultsViewController.viewDidLoad 1a");
	
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:1], @"Name", [MyResults GetTableScoreByIdx:1], @"TableUsed", 
						  [MyResults GetMarkByIdx:1], @"Score", [MyResults GetTestDateByIdx:1], @"Date", nil];
	
	//DLog(@"ResultsViewController.viewDidLoad 1b");
	
	NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:2], @"Name", [MyResults GetTableScoreByIdx:2], @"TableUsed", 
						  [MyResults GetMarkByIdx:2], @"Score", [MyResults GetTestDateByIdx:2], @"Date", nil];
	NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:3], @"Name", [MyResults GetTableScoreByIdx:3], @"TableUsed", 
						  [MyResults GetMarkByIdx:3], @"Score", [MyResults GetTestDateByIdx:3], @"Date", nil];
	NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:4], @"Name", [MyResults GetTableScoreByIdx:4], @"TableUsed", 
						  [MyResults GetMarkByIdx:4], @"Score", [MyResults GetTestDateByIdx:4], @"Date", nil];
	NSDictionary *row6 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:5], @"Name", [MyResults GetTableScoreByIdx:5], @"TableUsed", 
						  [MyResults GetMarkByIdx:5], @"Score", [MyResults GetTestDateByIdx:5], @"Date", nil];
	NSDictionary *row7 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:6], @"Name", [MyResults GetTableScoreByIdx:6], @"TableUsed", 
						  [MyResults GetMarkByIdx:6], @"Score", [MyResults GetTestDateByIdx:6], @"Date", nil];
	NSDictionary *row8 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:7], @"Name", [MyResults GetTableScoreByIdx:7], @"TableUsed", 
						  [MyResults GetMarkByIdx:7], @"Score", [MyResults GetTestDateByIdx:7], @"Date", nil];
	NSDictionary *row9 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:8], @"Name", [MyResults GetTableScoreByIdx:8], @"TableUsed", 
						  [MyResults GetMarkByIdx:8], @"Score", [MyResults GetTestDateByIdx:8], @"Date", nil];
	NSDictionary *row10 = [[NSDictionary alloc] initWithObjectsAndKeys:
						   [MyResults GetNameByIdx:9], @"Name", [MyResults GetTableScoreByIdx:9], @"TableUsed", 
						   [MyResults GetMarkByIdx:9], @"Score", [MyResults GetTestDateByIdx:9], @"sDate", nil];

	
    //DLog(@"ResultsViewController.viewDidLoad 2");
	
    NSArray *array = [[NSArray alloc] initWithObjects:row1, row2, 
                      row3, row4, row5, row6, row7, row8,row9, row10, nil];
    self.results = array;
    
	//DLog(@"ResultsViewController.viewDidLoad 3");
	
	//DLog(@"ResultsViewController.viewDidLoad 4");
	//DLog(@"ResultsViewController.viewDidLoad 5");
    
	//DLog(@"ResultsViewController.viewDidLoad end");
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.results = nil;
    
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView 
        cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//DLog(@"ResultsViewController.tableView.cellForRowAtIndexPath start");
	
    static NSString *CellTableIdentifier = @"CellTableIdentifier ";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellTableIdentifier];
    if (cell == nil) {
#ifdef __IPHONE_3_0__
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: CellTableIdentifier] autorelease];
#else // Prior to 3.0, use this call which is available but deprecated in 3.0
        //cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
        //                               reuseIdentifier:CellTableIdentifier] autorelease];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
        
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

		if (indexPath.row % 2) {
			//cell.contentView.backgroundColor = [[UIColor alloc] initWithRed:255 / 255 green:255 / 255 blue:192 / 255 alpha:1.0];
			//cell.contentView.backgroundColor = RGB(237, 255, 246);
			
			cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row1.png"]];

			
			
		} else {
			//cell.contentView.backgroundColor = [[UIColor alloc] initWithRed:193 / 255 green:255 / 255 blue:227 / 255 alpha:1.0];
			//cell.contentView.backgroundColor = RGB(255, 255, 223);
			
			cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row2.png"]];
			
		}
	
		CGRect nameLabelRect = CGRectMake(10, 10, 70, 25);
		UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:14];
		nameLabel.adjustsFontSizeToFitWidth = YES;
		nameLabel.backgroundColor = [UIColor clearColor];
		//nameLabel.backgroundColor = [UIColor yellowColor];
		nameLabel.tag = kNameValueTag; //NEW
        [cell.contentView addSubview: nameLabel];
		
		CGRect DateValueRect = CGRectMake(90, 10, 80, 25);
        UILabel *DateValue = [[UILabel alloc] initWithFrame:DateValueRect];
		DateValue.textAlignment = NSTextAlignmentLeft;
        DateValue.tag = kDateValueTag;
		DateValue.font = [UIFont systemFontOfSize:14];
		DateValue.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:DateValue];
		
		CGRect TableUsedRect = CGRectMake(190, 10, 70, 25);
        UILabel *TableUsed = [[UILabel alloc] initWithFrame:TableUsedRect];
		TableUsed.textAlignment = NSTextAlignmentCenter;
        TableUsed.tag = kTableUsedTag;
		TableUsed.font = [UIFont systemFontOfSize:14];
		TableUsed.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:TableUsed];
		
		CGRect ScoreRect = CGRectMake(270, 10, 40, 25);
        UILabel *Score = [[UILabel alloc] initWithFrame:ScoreRect];
		Score.textAlignment = NSTextAlignmentRight;
        Score.tag = kScoreValueTag;
		Score.font = [UIFont systemFontOfSize:14];
		Score.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:Score];
		 
    }
    
	//DLog(@"ResultsViewController.tableView.cellForRowAtIndexPath 2");
	
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = (self.results)[row];
	
	//DLog(@"ResultsViewController.tableView.cellForRowAtIndexPath 3");
	
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:kNameValueTag];
    name.text = rowData[@"Name"];
    	
	UILabel *Score = (UILabel *)[cell.contentView viewWithTag:kScoreValueTag];
    Score.text = rowData[@"Score"];

	UILabel *sdate = (UILabel *)[cell.contentView viewWithTag:kDateValueTag];
	sdate.text = rowData[@"Date"];
	
	UILabel *sTableUsed = (UILabel *)[cell.contentView viewWithTag:kTableUsedTag];
	sTableUsed.text = rowData[@"TableUsed"];
	
	//DLog(@"ResultsViewController.tableView.cellForRowAtIndexPath end");
	
    return cell;
}
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


@end

