//
//  Prefs.h
//  SpeakTimesTableApp
//
//  Created by Julian Moorhouse on 19/12/2011.
//  Copyright (c) 2011 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

#define pfTimesTableUsed            @"pfTimesTableUsed"
#define pfTableScore                @"pfTableScore"
#define pfRankScore                 @"pfRankScore"
#define pfTableSelected             @"pfTableSelected"

@interface Prefs : NSObject

+ (void)storeSettingStr:(NSString *)setting Value:(NSString *)value;
+ (void)storeSettingInt:(NSString *)setting Value:(NSInteger)value;

+ (NSString*)returnSettingStr:(NSString *)setting defaultValue:(NSString*)def;
+ (NSInteger)returnSettingInt:(NSString *)setting defaultValue:(NSInteger)def;

- (void)removeAllDefaults;

@end
