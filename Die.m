//
//  Die.m
//  Farkle
//
//  Created by Kern Jackson on 5/25/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import "Die.h"

@interface Die()
@end

@implementation Die

+ (NSArray *)sidesUp {
	return @[@"⚀",@"⚁",@"⚂",@"⚃",@"⚄",@"⚅"];
}

+ (NSArray *)sideValues {
	return @[@1,@2,@3,@4,@5,@6];
}

- (id)init {
	
	self = [super init];

    return [self rollDie]; // should I just send a blankDie instead?
}

- (id)blankDie {
	
	[self setLocked: NO];
	[self setScored: NO];
	[self setSideValue: 0];
	[self setSideUp: 0];
	
	return self;
}

- (id)rollDie {
	
	unsigned index = arc4random() % 6;
	
	[self setLocked:NO];
	[self setScored:NO];
	[self setSideValue: [  [Die sideValues] objectAtIndex:index] ];
	[self setSideUp:    [  [Die sidesUp] objectAtIndex:index]];
	
	return self;
}

// This is for the planned tutorial, don't think I'll actually need this
- (id)tutorialDie:(NSInteger)side {
    [self setLocked:NO];
	[self setScored:NO];
	[self setSideValue: [  [Die sideValues] objectAtIndex:side] ];
	[self setSideUp:    [  [Die sidesUp] objectAtIndex:side]];
	
	return self;
}

@end
