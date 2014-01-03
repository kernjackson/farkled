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
/*
- (void)playClick {
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Farkled"
                                                                              ofType:@"caf"]];
    click = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
//    [click setVolume:1.0];
//    [click prepareToPlay];
    [click play];
}
 */
/*
-(void) playSound {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Pickup_Coin69" ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}
*/
-(void) coinUp {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Pickup_Coin69" ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

-(void) coinDown {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Drop_Coin69" ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (void)gameOver {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"decay" ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (void)didFarkle {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"farkled1" ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (void)hotDice {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"threePairs" ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (void)threePairs {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"threePairs" ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}



- (void) rollDice1 {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"1Dice" ofType:@"m4a"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (void) nonscoring1 {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"nonscoring1" ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

- (void)coinUp:(UIButton *)sender {
    if (sender == 0) {
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Drop_Coin69" ofType:@"caf"];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
        AudioServicesPlaySystemSound (soundID);
    }
}

- (void)passedSmall {
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"threePairs" ofType:@"caf"];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
        AudioServicesPlaySystemSound (soundID);
}


@end
