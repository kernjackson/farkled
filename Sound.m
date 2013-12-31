//
//  Sound.m
//  farkled
//
//  Created by Kern Jackson on 12/31/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import "Sound.h"

@implementation Sound

@synthesize click;

- (void)playClick {
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Farkled"
                                                                              ofType:@"caf"]];
    click = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
//    [click setVolume:1.0];
//    [click prepareToPlay];
    [click play];
}

-(void) playSound {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Farkled" ofType:@"aifc"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

@end
