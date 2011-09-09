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
    
	//NSLog(@"ResultsViewController.viewDidLoad start");
	
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

	//NSLog(@"ResultsViewController.viewDidLoad a");
	
	MyResults.load;
	//[MyHigh save:50 name:@"billy"];
	
	//NSLog(@"ResultsViewController.viewDidLoad b");
	
	MyResults.debug;
	
	
    //NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:
    //                      @"MacBook", @"Name", @"White", @"Color", nil];
	
	//NSLog(@"ResultsViewController.viewDidLoad 1");
	
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
	
	//NSLog(@"ResultsViewController.viewDidLoad 1a");
	
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:1], @"Name", [MyResults GetTableScoreByIdx:1], @"TableUsed", 
						  [MyResults GetMarkByIdx:1], @"Score", [MyResults GetTestDateByIdx:1], @"Date", nil];
	
	//NSLog(@"ResultsViewController.viewDidLoad 1b");
	
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

	
    //NSLog(@"ResultsViewController.viewDidLoad 2");
	
    NSArray *array = [[NSArray alloc] initWithObjects:row1, row2, 
                      row3, row4, row5, row6, row7, row8,row9, row10, nil];
    self.results = array;
    
	//NSLog(@"ResultsViewController.viewDidLoad 3");
	
    [row1 release];
    [row2 release];
    [row3 release];
    [row4 release];
    [row5 release];
	[row6 release];
    [row7 release];
    [row8 release];
    [row9 release];
    [row10 release];
	//NSLog(@"ResultsViewController.viewDidLoad 4");
	[MyResults release];
	//NSLog(@"ResultsViewController.viewDidLoad 5");
    [array release];
    
	//NSLog(@"ResultsViewController.viewDidLoad end");
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    self.results = nil;
}
- (void)dealloc {
    [results release];
    [super dealloc];
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
	//NSLog(@"ResultsViewController.tableView.cellForRowAtIndexPath start");
	
    static NSString *CellTableIdentifier = @"CellTableIdentifier ";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellTableIdentifier];
    if (cell == nil) {
#ifdef __IPHONE_3_0__
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: CellTableIdentifier] autorelease];
#else // Prior to 3.0, use this call which is available but deprecated in 3.0
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:CellTableIdentifier] autorelease];
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
		
		//NSLog(@"ResultsViewController.tableView.cellForRowAtIndexPath 1");
		
		/*
		// BILLY
		//CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
		CGRect nameLabelRect = CGRectMake(10, 5, 60, 25);
		UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameLabel.textAlignment = UITextAlignmentLeft;
        //nameLabel.text = @"Name:";
        nameLabel.font = [UIFont boldSystemFontOfSize:16];
		//nameLabel.backgroundColor = [UIColor yellowColor];
		nameLabel.tag = kNameValueTag; //NEW
        [cell.contentView addSubview: nameLabel];
        [nameLabel release];
        		
        // 1 to 144
		//CGRect nameValueRect = CGRectMake(270, 5, 35, 25);
		CGRect nameValueRect = CGRectMake(290, 5, 35, 15);
        UILabel *nameValue = [[UILabel alloc] initWithFrame:nameValueRect];
		//nameValue.textAlignment = UITextAlignmentCenter;
		nameValue.textAlignment = UITextAlignmentLeft;
		//nameValue.font = [UIFont boldSystemFontOfSize:16];
		nameValue.font = [UIFont systemFontOfSize:10];
		//nameValue.backgroundColor = [UIColor yellowColor];
        nameValue.tag = kScoreValueTag;
        [cell.contentView addSubview:nameValue];
        [nameValue release];
        
		CGRect DateLabelRect = CGRectMake(80, 5, 40, 15);
        UILabel *Datelabel = [[UILabel alloc] initWithFrame:DateLabelRect];
		Datelabel.textAlignment = UITextAlignmentRight;
        Datelabel.tag = kDateLabelTag;
		Datelabel.font = [UIFont boldSystemFontOfSize:10];
		//Datelabel.backgroundColor = [UIColor yellowColor];
        [cell.contentView addSubview:Datelabel];
        [Datelabel release];
		
		// date
        //CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
		CGRect colorValueRect = CGRectMake(125, 5, 60, 15);
        UILabel *colorValue = [[UILabel alloc] initWithFrame:colorValueRect];
        colorValue.tag = kDateValueTag;
		colorValue.font = [UIFont systemFontOfSize:10];
		//colorValue.backgroundColor = [UIColor yellowColor];
        [cell.contentView addSubview:colorValue];
        [colorValue release];
        
		CGRect ResultLabelRect = CGRectMake(80, 20, 40, 15);
        UILabel *Resultlabel = [[UILabel alloc] initWithFrame:ResultLabelRect];
		Resultlabel.textAlignment = UITextAlignmentRight;
        Resultlabel.tag = kResultLabelTag;
		Resultlabel.font = [UIFont boldSystemFontOfSize:10];
		//Resultlabel.backgroundColor = [UIColor yellowColor];
        [cell.contentView addSubview:Resultlabel];
        [Resultlabel release];
		
		CGRect ResultValueRect = CGRectMake(125, 20, 130, 15);
        UILabel *ResultValue = [[UILabel alloc] initWithFrame:ResultValueRect];
        ResultValue.tag = kResultValueTag;
		ResultValue.font = [UIFont systemFontOfSize:10];
		//ResultValue.backgroundColor = [UIColor yellowColor];
        [cell.contentView addSubview:ResultValue];
        [ResultValue release];
		
		//CGRect ScoreLabelRect = CGRectMake(225, 5, 40, 15);
		CGRect ScoreLabelRect = CGRectMake(245, 5, 40, 15);
        UILabel *Scorelabel = [[UILabel alloc] initWithFrame:ScoreLabelRect];
		Scorelabel.textAlignment = UITextAlignmentRight;
        Scorelabel.tag = kScoreLabelTag;
		Scorelabel.font = [UIFont boldSystemFontOfSize:10];
		//Scorelabel.backgroundColor = [UIColor yellowColor];
        [cell.contentView addSubview:Scorelabel];
        [Scorelabel release];
		 
		 */
		 
		CGRect nameLabelRect = CGRectMake(10, 10, 70, 25);
		UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameLabel.textAlignment = UITextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:14];
		nameLabel.adjustsFontSizeToFitWidth = YES;
		nameLabel.backgroundColor = [UIColor clearColor];
		//nameLabel.backgroundColor = [UIColor yellowColor];
		nameLabel.tag = kNameValueTag; //NEW
        [cell.contentView addSubview: nameLabel];
        [nameLabel release];
		
		CGRect DateValueRect = CGRectMake(90, 10, 80, 25);
        UILabel *DateValue = [[UILabel alloc] initWithFrame:DateValueRect];
		DateValue.textAlignment = UITextAlignmentLeft;
        DateValue.tag = kDateValueTag;
		DateValue.font = [UIFont systemFontOfSize:14];
		DateValue.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:DateValue];
        [DateValue release];
		
		CGRect TableUsedRect = CGRectMake(190, 10, 70, 25);
        UILabel *TableUsed = [[UILabel alloc] initWithFrame:TableUsedRect];
		TableUsed.textAlignment = UITextAlignmentCenter;
        TableUsed.tag = kTableUsedTag;
		TableUsed.font = [UIFont systemFontOfSize:14];
		TableUsed.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:TableUsed];
        [TableUsed release];
		
		CGRect ScoreRect = CGRectMake(270, 10, 40, 25);
        UILabel *Score = [[UILabel alloc] initWithFrame:ScoreRect];
		Score.textAlignment = UITextAlignmentRight;
        Score.tag = kScoreValueTag;
		Score.font = [UIFont systemFontOfSize:14];
		Score.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:Score];
        [Score release];
		 
    }
    
	//NSLog(@"ResultsViewController.tableView.cellForRowAtIndexPath 2");
	
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.results objectAtIndex:row];
	
	//NSLog(@"ResultsViewController.tableView.cellForRowAtIndexPath 3");
	
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:kNameValueTag];
    name.text = [rowData objectForKey:@"Name"];
    	
	UILabel *Score = (UILabel *)[cell.contentView viewWithTag:kScoreValueTag];
    Score.text = [rowData objectForKey:@"Score"];

	UILabel *sdate = (UILabel *)[cell.contentView viewWithTag:kDateValueTag];
	sdate.text = [rowData objectForKey:@"Date"];
	
	UILabel *sTableUsed = (UILabel *)[cell.contentView viewWithTag:kTableUsedTag];
	sTableUsed.text = [rowData objectForKey:@"TableUsed"];
	
	//NSLog(@"ResultsViewController.tableView.cellForRowAtIndexPath end");
	
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

