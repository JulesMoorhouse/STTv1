//
//  Prefs.h
//  SpeakTimesTableApp
//
//  Created by Julian Moorhouse on 19/12/2011.
//  Copyright (c) 2011 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

#define pfAppAdvAcSel           @"pfAppAdvAcSel"
#define pfAppSelectedAccountID	@"pfAppSelACID"
#define pfAppCurrentTransDesc	@"pfAppCurTranDesc"

@interface Prefs : NSObject

+ (void)storeSettingStr:(NSString *)setting Value:(NSString *)value;
+ (void)storeSettingInt:(NSString *)setting Value:(int)value;

+ (NSString*)returnSettingStr:(NSString *)setting defaultValue:(NSString*)def;
+ (int)returnSettingInt:(NSString *)setting defaultValue:(int)def;

- (void)removeAllDefaults;

@end
