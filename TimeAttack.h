//
//  TimeAttack.h
//  farkled
//
//  Created by Kern Jackson on 1/7/14.
//  Copyright (c) 2014 Kern Jackson. All rights reserved.
//

#import "Farkle.h"

@interface TimeAttack : Farkle {
    NSTimer *timer;
    NSInteger ticks;
}

- (void)updateCounter:(NSTimer *)theTimer;
- (void)countDownTimer;

@end
