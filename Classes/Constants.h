//
//  Constants.h
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 01/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIColor-HexUtils/UIColor+HexUtils.h>


//extern BOOL *const isPlaying;

extern NSString *const MY_CONSTANT;
extern NSString * mycurrentView;

extern BOOL soundPlaying;


extern NSString *sVoice;

extern NSString *sTrackMale[34];
extern NSString *sTrackFemale[34];
extern float fTrackLengthMale[34];
extern float fTrackLengthFemale[34];


#ifndef NDEBUG
//#   define DLog(fmt, ...) DLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#   define DLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#   define DLog(...)
#else
#   define DLog(...)
#endif

@interface Constants : NSObject {
	
	
}

+(UIColor*)standardBackgound;

@end
