//
//  Settings.m
//  spinninyarn
//
//  Created by Kern Jackson on 11/25/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import "Settings.h"



@implementation Settings
/*
@synthesize penalty;
@synthesize minimum;
@synthesize hotdice;
@synthesize stealing;
@synthesize  *playTo;
@synthesize  *minimumScore;
@synthesize  *difficulty;
*/

+ (id)sharedManager {
    static Settings *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (id)init {
    if (self = [super init]) {
        
        // possibly check defaults here.
        //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //[defaults setObject:minimumScore forKey:@"minimumScore"];
        
        [self factoryDefaults];
        
        //NSMutableArray *rolled = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)factoryDefaults {
    // reset all settings to factory default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    sounds = NO;
    penalty = NO;
    minimum = YES;
    hotdice = YES;
    stealing = YES;
    
    playTo = @2;
    minimumScore = @1;
    difficulty = @1;
    
    [defaults setBool:sounds forKey:@"sounds"];
    [defaults setBool:penalty forKey:@"penalty"];
    [defaults setBool:minimum forKey:@"minimum"];
    [defaults setBool:hotdice forKey:@"hotdice"];
    [defaults setBool:stealing forKey:@"stealing"];
    
    [defaults setObject:playTo forKey:@"playTo"];
    [defaults setObject:minimumScore forKey:@"minimumScore"];
    [defaults setObject:difficulty forKey:@"difficulty"];
}

@end
