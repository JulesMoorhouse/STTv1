//
//  TableSelectViewController.h
//  SPEAKTIMESTABLE
//
//  Created by Julian Moorhouse on 06/05/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableSelectViewController : UIViewController {
	IBOutlet UIButton *btn1;
	IBOutlet UIButton *btn2;
	IBOutlet UIButton *btn3;
	IBOutlet UIButton *btn4;
	IBOutlet UIButton *btn5;
	IBOutlet UIButton *btn6;
	IBOutlet UIButton *btn7;
	IBOutlet UIButton *btn8;
	IBOutlet UIButton *btn9;
	IBOutlet UIButton *btn10;
	IBOutlet UIButton *btn11;
	IBOutlet UIButton *btn12;
}
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;
@property (nonatomic, strong) UIButton *btn5;
@property (nonatomic, strong) UIButton *btn6;
@property (nonatomic, strong) UIButton *btn7;
@property (nonatomic, strong) UIButton *btn8;
@property (nonatomic, strong) UIButton *btn9;
@property (nonatomic, strong) UIButton *btn10;
@property (nonatomic, strong) UIButton *btn11;
@property (nonatomic, strong) UIButton *btn12;
- (IBAction)buttonTablePressed:(id)sender;
@end
