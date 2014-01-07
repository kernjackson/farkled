//
//  TimeAttack.m
//  farkled
//
//  Created by Kern Jackson on 1/7/14.
//  Copyright (c) 2014 Kern Jackson. All rights reserved.
//

#import "TimeAttack.h"

@implementation TimeAttack

//@synthesize ticks;

- (void)updateCounter:(NSTimer *)theTimer {
    
}

- (void)countDownTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}


@end
