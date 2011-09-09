//
//  Speaking.m
//  SPEAKTIMESTABLE
//
//  Created by Julian Moorhouse on 17/04/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "Speaking.h"
#import "Constants.h"

@implementation Speaking

+ (float) getTrackLength:(NSString *)str
{
	float ret = 0.0;
	int cnt = 0;
	
	if (sVoice == @"male") {
		for (cnt = 0; cnt < 35; cnt++)
		{
			//NSLog(@"loop str=%@ arr=%@", str, sTrackMale[cnt]);
			
			if ([str isEqualToString:sTrackMale[cnt]]) {
				ret = fTrackLengthMale[cnt];	
				//NSLog(@"loop str=%@ arr=%@ ret=%f", str, sTrackMale[cnt], ret);
				break; 
			}
		}
	} else if (sVoice == @"female") {
		for (cnt = 0; cnt < 35; cnt++)
		{
			if ([str isEqualToString:sTrackFemale[cnt]]) {
				ret = fTrackLengthFemale[cnt];
				break;
			}
		}
	}
	
	//NSLog(@"getTrackLength=%f voice=%@", ret, sVoice);
	return ret;
}

+(void)GetSoundForNumber:(int)iSum sArrFiles:(NSMutableArray*)sArrFiles
{
	
	//Common values variables - Certified OK
	NSString *sSum = [NSString stringWithFormat:@"%d", iSum];
	int iLen = sSum.length;
	NSString *sFirstChar = [sSum substringWithRange: NSMakeRange(0, 1)];
	int iStartOfLastChar = iLen - 1;
	NSString *sLastChar = [sSum substringWithRange: NSMakeRange(iStartOfLastChar, 1)];
	//Common values variables - Certified OK
	NSString *sThisWav;
	
	
	switch (iLen) {
		case 1: {
			// speak sFirstChar
			sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sFirstChar];
			[sArrFiles addObject:sThisWav];
			break;
		}
		case 2: {
			if ([sFirstChar isEqualToString:@"1"]) {
				NSString *sTeen2 = [sSum substringWithRange: NSMakeRange(0, 2)];
				// speak teen2
				sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sTeen2];		
				[sArrFiles addObject:sThisWav];			
				
			} else {
				NSString *sFirstBit2 = [NSString stringWithFormat:@"%@%@", sFirstChar, @"0"];
				// speak sFirstBit2
				sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sFirstBit2];		
				[sArrFiles addObject:sThisWav];	
				
				if (![sLastChar isEqualToString:@"0"]) {
					// speak sLastChar
					sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sLastChar];			
					[sArrFiles addObject:sThisWav];
					
				}
			}
			break;
		}
		case 3: {
			// speak sFirstChar
			sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sFirstChar];		
			[sArrFiles addObject:sThisWav];
			
			// speak hundred
			sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", @"hundred"];		
			[sArrFiles addObject:sThisWav];
			
			NSString *sMiddlePart3 = [sSum substringWithRange: NSMakeRange(1, 1)];
			if ([sMiddlePart3 isEqualToString:@"0"]) {
				if (![sLastChar isEqualToString:@"0"]) {
					// speak and
					sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", @"and"];			
					[sArrFiles addObject:sThisWav];
					
					// speak sLastChar
					sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sLastChar];		
					[sArrFiles addObject:sThisWav];	
					
				}
			} else if ([sMiddlePart3 isEqualToString:@"1"]) {
				NSString *sTeen3 = [sSum substringWithRange: NSMakeRange(1, 2)];
				// speak and
				sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", @"and"];			
				[sArrFiles addObject:sThisWav];
				
				// speak teen3
				sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sTeen3];		
				[sArrFiles addObject:sThisWav];
				
			} else {
				// speak and
				sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", @"and"];			
				[sArrFiles addObject:sThisWav];
				
				// speak sMiddlePart3 + "0"
				sThisWav = [NSString stringWithFormat:@"%@%@%@%@", sVoice, @"-", sMiddlePart3, @"0"];			
				[sArrFiles addObject:sThisWav];
				
				if (![sLastChar isEqualToString:@"0"]) {
					// speak sLastChar
					sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sLastChar];	
					[sArrFiles addObject:sThisWav];
				}
			}
			break;
		}
		case 4: {
			// speak sFirstChar
			sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sFirstChar];	
			[sArrFiles addObject:sThisWav];
			
			// speak thousand
			NSString *sMiddlePart4 = [sSum substringWithRange: NSMakeRange(1, 1)];
			if ([sMiddlePart4 isEqualToString:@"0"]) {
				if (![sLastChar isEqualToString:@"0"]) {
					// speak sMiddlePart4
					sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sMiddlePart4];		
					[sArrFiles addObject:sThisWav];
					
					// speak hundred
					sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", @"hundred"];			
					[sArrFiles addObject:sThisWav];
					
				}
			}
			
			NSString *sLaterPart4 = [sSum substringWithRange: NSMakeRange(2, 1)];
			if ([sLaterPart4 isEqualToString:@"0"]) {
				if (![sLastChar isEqualToString:@"0"]) {
					// speak and
					sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", @"and"];		
					[sArrFiles addObject:sThisWav];
					
					// speak sLastChar
					sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sLastChar];		
					[sArrFiles addObject:sThisWav];	
				}
			} else if ([sLaterPart4 isEqualToString:@"1"]) {
				NSString *sTeen4 = [sSum substringWithRange: NSMakeRange(2, 2)];
				// speak and
				sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", @"and"];			
				[sArrFiles addObject:sThisWav];
				
				// speak teen4	
				sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sTeen4];	
				[sArrFiles addObject:sThisWav];
				
			} else {
				// speak and
				sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", @"and"];	
				[sArrFiles addObject:sThisWav];
				
				// speak sLaterPart4 + "0"
				sThisWav = [NSString stringWithFormat:@"%@%@%@%@", sVoice, @"-", sLaterPart4, @"0"];		
				[sArrFiles addObject:sThisWav];
				
				if (![sLastChar isEqualToString:@"0"]) {
					// speak sLastChar
					sThisWav = [NSString stringWithFormat:@"%@%@%@", sVoice, @"-", sLastChar];		
					[sArrFiles addObject:sThisWav];
				}
			}
			break;
		}
		default:
			break;
	}
	
	//[sThisWav release];
	
}

@end
