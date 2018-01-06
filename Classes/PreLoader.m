//
//  Preloader.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 12/06/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "Preloader.h"

@interface Preloader (Private)
- (AVAudioPlayer*)playerWithSoundNamed:(NSString*)filename;
@end

@implementation Preloader

@synthesize ApplauseSoundPlayer;

- (AVAudioPlayer*)playerWithSoundNamed:(NSString*)filename {
	NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
	if (!path)
		return nil;
	
	NSData *fileData = [NSData dataWithContentsOfFile:path];
	NSError *err;
	AVAudioPlayer *result = [[AVAudioPlayer alloc] initWithData:fileData error:&err];
	result.volume = 1; // 03/july/2010
	
	[result prepareToPlay];
	
	return result;
}

- (id)init {
    //if (self == [super init]) {
	if (self = [super init]) {
		self.ApplauseSoundPlayer = nil;
	}
	
	return self;
}

- (void)load {
	self.ApplauseSoundPlayer = [self playerWithSoundNamed:@"LargeCrowdApplauseE.mp3"];
}



@end
