//
//  ResultsViewController.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 28/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "ResultsViewController.h"
#import "highScores.h"
#import <UIColor-HexUtils/UIColor+HexUtils.h>

@implementation ResultsViewController
@synthesize results;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [Constants standardBackgound];

	highScores *MyResults = [[highScores alloc] init];
	[MyResults load];
	[MyResults debug];
	
	NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:0], @"Name", [MyResults GetTableScoreByIdx:0], @"TableUsed", 
						  [MyResults GetMarkByIdx:0], @"Score", [MyResults GetTestDateByIdx:0], @"Date", nil];
		
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [MyResults GetNameByIdx:1], @"Name", [MyResults GetTableScoreByIdx:1], @"TableUsed", 
						  [MyResults GetMarkByIdx:1], @"Score", [MyResults GetTestDateByIdx:1], @"Date", nil];
	

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

	
    NSArray *array = [[NSArray alloc] initWithObjects:row1, row2, 
                      row3, row4, row5, row6, row7, row8,row9, row10, nil];
    self.results = array;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.results = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier ";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellTableIdentifier];
    if (cell == nil) {
#ifdef __IPHONE_3_0__
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: CellTableIdentifier] autorelease];
#else
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
        
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

		if (indexPath.row % 2)
        {
            cell.backgroundColor = [Constants standardBackgound];
            			
		} else {
			cell.backgroundColor = [Constants standardBackgound];
		}
	
		CGRect nameLabelRect = CGRectMake(10, 10, 70, 25);
		UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:14];
		nameLabel.adjustsFontSizeToFitWidth = YES;
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.tag = kNameValueTag;
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
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = (self.results)[row];
		
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:kNameValueTag];
    name.text = rowData[@"Name"];
    	
	UILabel *Score = (UILabel *)[cell.contentView viewWithTag:kScoreValueTag];
    Score.text = rowData[@"Score"];

	UILabel *sdate = (UILabel *)[cell.contentView viewWithTag:kDateValueTag];
	sdate.text = rowData[@"Date"];
	
	UILabel *sTableUsed = (UILabel *)[cell.contentView viewWithTag:kTableUsedTag];
	sTableUsed.text = rowData[@"TableUsed"];
		
    return cell;
}

@end

