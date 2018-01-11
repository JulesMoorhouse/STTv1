//
//  AppBasic.m
//  SPEAKTIMESTABLE
//
//  Created by Julian Moorhouse on 17/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "AppBasic.h"

@implementation AppBasic
+(NSString*)GUIDString {
    /*
    CFUUIDRef theUUID = CFUUIDCreate(NULL);	
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
     */
    return [[NSUUID UUID] UUIDString];
}
/*
+(UIImage*)setButtonImageNormal {
	UIImage *buttonImageNormal = [UIImage imageNamed:@"action-normal.png"];
    UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	return stretchableButtonImageNormal;
}

+(UIImage*)setButtonImagePressed {
    UIImage *buttonImagePressed = [UIImage imageNamed:@"action-pressed.png"];
    UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	return stretchableButtonImagePressed;
}
*/
+(void)setButton:(UIButton *)button str:(NSString *)str {

	//UIImage *buttonImageNormal = [UIImage imageNamed:@"action-normal.png"];
	UIImage *buttonImageNormal = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@%@", @"action-normal-", str, @".png"]];
	
    UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [button setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	
	UIColor *colorYellow = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
	[button setTitleColor:colorYellow forState:UIControlStateNormal];
	[button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];

	UIImage *buttonImagePressed = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@%@", @"action-pressed-", str, @".png"]];
    UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[button setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];

	UIColor *colorDarkYellow = RGB(210,212,0);
	[button setTitleColor:colorDarkYellow forState:UIControlStateHighlighted];
	[button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateHighlighted];
}

+(void)STTV2Tap
{
    NSLog(@"STTV2 panel tapped");
}

@end
