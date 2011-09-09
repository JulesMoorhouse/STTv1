//
//  AppBasic.h
//  SPEAKTIMESTABLE
//
//  Created by Julian Moorhouse on 17/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface AppBasic : NSObject {

}
+(NSString*)GUIDString;
//+(UIImage*)setButtonImageNormal;
//+(UIImage*)setButtonImagePressed;
+(void)setButton:(UIButton *)button str:(NSString *)str;
@end
