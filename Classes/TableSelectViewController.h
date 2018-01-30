//
//  TableSelectViewController.h
//  SPEAKTIMESTABLE
//
//  Created by Julian Moorhouse on 06/05/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "STT2PanelView.h"
#import "CBBezier.h"

@interface TableSelectViewController : UIViewController {
	IBOutlet CBBezier *btn1;
	IBOutlet CBBezier *btn2;
	IBOutlet CBBezier *btn3;
	IBOutlet CBBezier *btn4;
	IBOutlet CBBezier *btn5;
	IBOutlet CBBezier *btn6;
	IBOutlet CBBezier *btn7;
	IBOutlet CBBezier *btn8;
	IBOutlet CBBezier *btn9;
	IBOutlet CBBezier *btn10;
	IBOutlet CBBezier *btn11;
	IBOutlet CBBezier *btn12;
}
@property (nonatomic, strong) CBBezier *btn1;
@property (nonatomic, strong) CBBezier *btn2;
@property (nonatomic, strong) CBBezier *btn3;
@property (nonatomic, strong) CBBezier *btn4;
@property (nonatomic, strong) CBBezier *btn5;
@property (nonatomic, strong) CBBezier *btn6;
@property (nonatomic, strong) CBBezier *btn7;
@property (nonatomic, strong) CBBezier *btn8;
@property (nonatomic, strong) CBBezier *btn9;
@property (nonatomic, strong) CBBezier *btn10;
@property (nonatomic, strong) CBBezier *btn11;
@property (nonatomic, strong) CBBezier *btn12;

@property (strong, nonatomic) IBOutlet STT2PanelView *panel;

- (IBAction)buttonTablePressed:(id)sender;
@end
