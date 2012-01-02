//
//  Prefs.m
//  SpeakTimesTableApp
//
//  Created by Julian Moorhouse on 19/12/2011.
//  Copyright (c) 2011 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "Prefs.h"

@implementation Prefs

#pragma mark - Pref Setters
+ (void)storeSettingStr:(NSString *)setting Value:(NSString *)value {
    
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![[myDefaults objectForKey:setting] isEqualToString:value]) {
        DLog(@"Prefs.storeSettingStr  setting=%@ value=%@", setting, value);
        [myDefaults setObject:value forKey:setting];
        [myDefaults synchronize];
    }
}

+ (void)storeSettingInt:(NSString *)setting Value:(int)value {
    
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    
    int current = [myDefaults integerForKey:setting];
    
    if (current != value) {
        DLog(@"Prefs.storeSettingInt  setting=%@ value=%i", setting, value);
        [myDefaults setInteger:value forKey:setting];
        [myDefaults synchronize];
    }
}

#pragma mark - Pref Getters
+ (NSString*)returnSettingStr:(NSString *)setting defaultValue:(NSString*)def{
    
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    NSString *ret = [myDefaults objectForKey:setting];
    
    if ([ret length] == 0) {
        ret = def;
    }
    DLog(@"Prefs.returnSettingStr  setting=%@ ret=%@", setting, ret);
    return ret;
}

+ (int)returnSettingInt:(NSString *)setting defaultValue:(int)def{
    
    int ret = def;
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sRet = [myDefaults objectForKey:setting];
    
    if (sRet != nil) {
    //if (![sRet isEqualToString:nil]) {
        ret = [sRet intValue];
    }
    
    DLog(@"Prefs.retrunSettingInt setting=%@ ret=%i", setting, ret);
    
    return ret;
}

#pragma mark - All Prefs
- (void)removeAllDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

    

@end
