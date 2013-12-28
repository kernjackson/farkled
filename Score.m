//
//  Score.m
//  spinninyarn
//
//  Created by Kern Jackson on 12/24/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import "Score.h"
#import "Die.h"

@implementation Score

#pragma mark Values

@synthesize nonScoring;
@synthesize rolledPoints;
@synthesize lockedPoints;
@synthesize scoredPoints;

#pragma mark Methods

- (NSInteger)scoreRolled:(NSMutableArray *)dice {
    // make a temporary array
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    // and initialize it
    for (int i = 0; i < 6; i++) {
        [temp insertObject:@0 atIndex:i];
    }
    // calculate score for rolled
    for (int i = 0; i < 6; i++) {
        // is it neither locked or scored?
        if ((![[dice objectAtIndex:i] isLocked]) &&
            (![[dice objectAtIndex:i] isScored]))
        {
            [temp replaceObjectAtIndex:i withObject:[[dice objectAtIndex:i] sideValue]];
        } // else [temp insertObject:@0 atIndex:i];
    }
    return rolledPoints = [self score:[self sort:temp]];
}

- (NSInteger)scoreLocked:(NSMutableArray *)dice {
    // make a temporary array
    NSMutableArray *unsorted = [[NSMutableArray alloc] init];
    NSArray *sorted = [[NSArray alloc] init];
    // and initialize it
    for (int i = 0; i < 6; i++) {
        [unsorted insertObject:@0 atIndex:i];
    }
    // calculate score for rolled
    for (int i = 0; i < 6; i++) {
        // is it neither locked or scored?
        if (( [[dice objectAtIndex:i] isLocked]) &&
            (![[dice objectAtIndex:i] isScored]))
        {
            [unsorted replaceObjectAtIndex:i withObject:[[dice objectAtIndex:i] sideValue]];
        } // else [temp insertObject:@0 atIndex:i];
    }
    
    sorted = [self sort:unsorted];
    lockedPoints = [self score:sorted];

    // check for nonscoring dice
    nonScoring = [self nonScoringDice:sorted];
    
    if (nonScoring) {
        return nonScoring; // This returns a 1 for the score
    }
    return lockedPoints;
}

- (NSInteger)scoreScored:(NSMutableArray *)dice {
    // make a temporary array
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    // and initialize it
    for (int i = 0; i < 6; i++) {
        [temp insertObject:@0 atIndex:i];
    }
    // calculate score for rolled
    for (int i = 0; i < 6; i++) {
        // is it neither locked or scored?
        if (( [[dice objectAtIndex:i] isLocked]) &&
            ( [[dice objectAtIndex:i] isScored]))
        {
            [temp replaceObjectAtIndex:i withObject:[[dice objectAtIndex:i] sideValue]];
        } // else [temp insertObject:@0 atIndex:i];
    }
    return scoredPoints = [self score:[self sort:temp]];
}

// 121345 == 211110, 443564 == 001311, etc
- (NSArray *)sort:(NSMutableArray *)unsorted {
    NSMutableArray *sorted = [[NSMutableArray alloc] init];
    // Initialize the array
    for (int i = 0; i < 6; i++) {
        [sorted addObject:@0];
    } // increment at each position for each die value
    for (int position = 0; position < 6; position++) {
        for (int value = 0; value < 6; value++) {
            if (unsorted[position] == [NSNumber numberWithInt:value+1]) {
                //  if ([[unsorted[position] sideValue] isEqual:[NSNumber numberWithInt:value+1]]) {
                NSNumber *count = [NSNumber numberWithInt:[sorted[value] intValue] + 1];
                //NSLog(@"count: %@", count);
                [sorted replaceObjectAtIndex:value withObject:count];
            }
        }
    }
    return sorted;
}

- (BOOL)nonScoringDice:(NSArray *)unscored {
/*
    for (int i = 0; i < 6; i++) {
        NSLog(@"asdfasdf: %@", unscored[i]);
    }
  */
    if ((([unscored[1] intValue] == 1) || ([unscored[1] intValue] == 2) ||
        ([unscored[2] intValue] == 1) || ([unscored[2] intValue] == 2) ||
        ([unscored[3] intValue] == 1) || ([unscored[3] intValue] == 2) ||
        ([unscored[5] intValue] == 1) || ([unscored[5] intValue] == 2))
        ) {
            if ((![self threePair:unscored]) && (![self straight:unscored])) {
                return YES;
        } else return NO;
    }
    return NO;
}

- (BOOL)threePair:(NSArray *)unscored {
    int counter = 0;
    for (int j = 0; j < 6; j++) {
        if ([unscored[j] intValue] == 2) {
            counter++;
        }
    }
    if (counter == 3) {
        return YES;
    }
    return NO;
}

- (BOOL)straight:(NSArray *)unscored {
    if (   ([unscored[0] intValue] == 1)
        && ([unscored[1] intValue] == 1)
        && ([unscored[2] intValue] == 1)
        && ([unscored[3] intValue] == 1)
        && ([unscored[4] intValue] == 1)
        && ([unscored[5] intValue] == 1)
        ) {
        return YES;
    }
    return NO;
}

- (NSInteger)triples:(NSArray *)unscored position:(NSInteger)i {
    
    NSArray *pointsForTriples = @[@1000,@200,@300,@400,@500,@600];
    
    int scored = 0;
    if ([unscored[i] intValue] >= 3) {
        
        // check _onesLow whether 1*4 = 2000 or 1*4 == 1100
        scored += (([[pointsForTriples
                      objectAtIndex:i]
                     intValue] * (([unscored[i] intValue] -2))) );
        
        // check _doubling whether adding or doubling
        /*(
        if (_doubling) {
            //
        }
        */
        // check for fullhouse
        // if 3 and 2
    }
    return scored;
}

- (NSInteger)pairs:(NSArray *)unscored position:(NSInteger)i {
    int scored = 0;
    if ([unscored[i] intValue] == 2) {
        // two ones
        if (i == 0) {
            scored += 200;
        }
        // two fives
        else if (i == 4) {
            scored += 100;
        }
    }
    return scored;
}

- (NSInteger)singles:(NSArray *)unscored position:(NSInteger)i {
    int scored = 0;
    if ([unscored[i] intValue] == 1) {
        // one one
        if (i == 0) {
            scored += 100;
        }
        // one five
        else if (i == 4) {
            scored += 50;
        }
    }
    return scored;
}

- (NSInteger)score:(NSArray *)unscored {
    
    if ([self threePair:unscored]) {
        return 1500;
    }
    if ([self straight:unscored]) {
        return 2500;
    }
    int scored = 0;
    // step through the entire array
    for (int i = 0; i < 6; i++) {
        // are there more than 6 objects? Maybe comment this out before production.
        if ([unscored count] > 6) {
            return -1; // if so return an error
        }
        // scored 3 or more
        scored += [self triples:unscored position:i]; // change one of these i's to something more meaningful
        // check for pairs
        scored += [self pairs:unscored position:i]; // called 3 times, since we += instead of just returning it accumulates
        // check for singles
        scored += [self singles:unscored position:i];
    }
    return scored;
}

@end
