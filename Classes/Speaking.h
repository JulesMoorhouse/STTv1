//
//  Speaking.h
//  SPEAKTIMESTABLE
//
//  Created by Julian Moorhouse on 17/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Speaking : NSObject {

}
+ (float) getTrackLength:(NSString *)str;
+(void)GetSoundForNumber:(NSInteger)iSum sArrFiles:(NSMutableArray*)sArrFiles;
@end
