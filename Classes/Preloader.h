//
//  Preloader.h
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 12/06/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Preloader : NSObject {
	AVAudioPlayer *ApplauseSoundPlayer;
}

@property (nonatomic, strong) AVAudioPlayer *ApplauseSoundPlayer;


- (void)load;


@end

