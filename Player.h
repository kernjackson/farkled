//
//  Player.h
//  farkled
//
//  Created by Kern Jackson on 12/29/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSNumber *totalScore;
@property (nonatomic) NSNumber *previousScore;
@property (nonatomic) NSNumber *farkles;

@end
