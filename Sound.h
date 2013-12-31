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

- (void)playClick;
- (void) playSound;

@end