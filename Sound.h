//
//  Sound.h
//  farkled
//
//  Created by Kern Jackson on 12/31/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Sound : NSObject

@property (nonatomic,strong) AVAudioPlayer *click;

//- (void)playClick;
//- (void)playSound;
- (void)rollDice1;
- (void)nonscoring;
- (void)nonscoring1;

- (void)didFarkle;
- (void)gameOver;
- (void)coinUp;
- (void)coinDown;

#pragma mark acutally planned ahead of time

- (void)scoreUp;
- (void)scoreDown;
- (void)scoreSame;
// just just use die1 for now?
- (void)die1; // 1 & 5 should sound very similar, positive coinUp sound
- (void)die2; // 2,3,4,6 should play their normal sound unless part of a larger scoring set, such as a threePairs, straight, triple++
- (void)die3;
- (void)die4;
- (void)die5;
- (void)die6;

- (void)unlockDie;

- (void)match3;
- (void)match4;
- (void)match5;
- (void)match6;

- (void)threePairs;
- (void)straight;

- (void)rolled;
- (void)passedSmall;
- (void)passedMedium;
- (void)passedLarge;

- (void)hotDice;
- (void)farkled;

- (void)playerLost;
- (void)playerWon;

// not so sure about these

- (void)achievment;

- (void)challengeReceived;

- (void)coinUp:(UIButton *)sender;


@end

