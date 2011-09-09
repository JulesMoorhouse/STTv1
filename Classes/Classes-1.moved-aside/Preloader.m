//
//  PreLoader.m
//  SpeakTimesTable
//
//  Created by Julian Moorhouse on 12/06/2010.
//  Copyright 2010 Mindwarp Consultancy Ltd. All rights reserved.
//

#import "PreLoader.h"

@implementation SoundsPreloader

@synthesize myClickSound;


- (id)init {
	if (self = [super init]) {
		self.myClickSound = 0;
	}
	
	return self;
}

- (void)load {
	SystemSoundID soundID;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path isDirectory:NO], &soundID);
	self.myClickSound = soundID;
	[path release];
}

- (void)dealloc {
	[super dealloc];
}


@end
