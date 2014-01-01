//
//  Farkle.m
//  Farkle
//
//  Created by Kern Jackson on 5/25/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//
#import "Die.h"
#import "Score.h"
#import "Farkle.h"
#import "Sound.h"

#define APP_DELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

@interface Farkle() {

    NSInteger rolledPoints;
    NSInteger lockedPoints;
    NSInteger scoredPoints;
    NSInteger totalPoints;
    NSInteger previousPoints;
    NSInteger finalPoints;
    
    NSNumber *minimumScore; // [defaults setObject:minimumScore forKey:@"minimumScore"];
    
    
}

//+ (NSArray *)pointsForTriples;

@property (nonatomic, assign) NSInteger rolledPoints;
@property (nonatomic, assign) NSInteger lockedPoints;
@property (nonatomic, assign) NSInteger scoredPoints;
@property (nonatomic, assign) NSInteger totalPoints;
@property (nonatomic, assign) NSInteger previousPoints;

@property (nonatomic, retain) NSMutableArray *rolledDice;
@property (nonatomic, retain) NSMutableArray *lockedDice;
@property (nonatomic, retain) NSMutableArray *scoredDice;

@property (nonatomic, retain) NSMutableArray *oldDice;

@property (nonatomic, assign) NSInteger nonScoringDice;

@end

@implementation Farkle

@synthesize rolledPoints;
@synthesize lockedPoints;
@synthesize scoredPoints;
@synthesize totalPoints;
@synthesize previousPoints;

//@synthesize minimumScore;

@synthesize isNewGame;
@synthesize canPass;
@synthesize noDiceSelected;
@synthesize canRoll;
@synthesize hotDice;
@synthesize nonScoring;
@synthesize nonScoringDice;

@synthesize scoreTitle;
@synthesize passTitle;

@synthesize memory; // replaced by one of the above
@synthesize farkles;
@synthesize turns;

@synthesize dice;

@synthesize rolledDice;
@synthesize lockedDice;
@synthesize scoredDice;

#pragma mark Initialize

+ (id)sharedManager {
    static Farkle *singleton = nil;
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
        
        scoreTitle = @0;
        passTitle = @0;
        
        scoredPoints = 0;
        rolledPoints = 0;
        lockedPoints = 0;
        
        isNewGame = YES; // what!?
        nonScoring = YES;
        nonScoringDice = 0;
        
        farkles = @0;
        turns = @11; // +1 for roll, +1 for 10 through 1
        
        //NSMutableArray *rolled = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark Actions

- (void)rolled {
    
    Score *score = [[Score alloc] init];

    if (isNewGame) {
        isNewGame = NO; // what!?
  //      NSLog(@"isNewGame");
    }
    if (self.isGameOver) {
 //       NSLog(@"isGameOver");
    } else {
            previousPoints = totalPoints;
            scoredPoints = lockedPoints;
            rolledPoints = [score scoreRolled:dice];
            totalPoints = previousPoints + scoredPoints;
        lockedPoints = 0; // !!!
       /*
        if (!hotDice) {
            [self newDice];
        }
        */
      //      [self logPoints];
        }
}

- (void)passed {
    
    Score *score = [[Score alloc] init];
    
    totalPoints = (previousPoints + lockedPoints);
    finalPoints += totalPoints;
    scoreTitle = [NSNumber numberWithInteger:(finalPoints)];
    
    lockedPoints = [score scoreLocked:dice];
    scoredPoints = [score scoreScored:dice];

   // [self logPoints];
    [self endTurn];
}

- (void)toggleDie {
    
    Score *score = [[Score alloc] init];
    
    lockedPoints = [score scoreLocked:dice];
    // aparrently returns a 1 if dice are non-scoring
    
    // This feels like a hack, but in it's present state we get a BOOL Yes back if nonscoring dice are selected.
    
   
    
    totalPoints = previousPoints + lockedPoints;
    

    
    
    /*
    NSLog(@"######################################");
    NSLog(@"previousPoints: %d", previousPoints);
    NSLog(@"lockedPoints:   %d", lockedPoints);
    NSLog(@"totalPoints:    %d", totalPoints);
    NSLog(@"######################################");
    */
    Sound *sound = [[Sound alloc] init];
    
    if (lockedPoints == 1) {
        passTitle = @0;
        //[sound coindDown];
    } else { passTitle = [NSNumber numberWithInteger:totalPoints];
        
     //       if (sounds) {
        if (totalPoints > previousPoints) {
            [sound coinUp];
        }
        
   //         }
    }

    //NSLog(@"toggle nonScoring: %hhd", score.nonScoring);
    
    //[self noLockedDice];
    
  //  [self logPoints];
}

- (void)endTurn {
    
    // This is probably the only place we need to check for isGameOver
    
    // decrement turns
    NSNumber *temp = [NSNumber numberWithInt:[self.turns intValue] -1];
    self.turns = temp;
    rolledPoints = -1; // -1
    scoredPoints = 0;
    lockedPoints = -1; // 0 hack, makes rollButton appear after farlking
    totalPoints = 0;
    previousPoints = 0;
    passTitle = @0;
 //   nonScoring = NO;
//    NSLog(@"nonScoring: %hhd", nonScoring);
    [self clearDice];
    if (self.isGameOver) {
  //      NSLog(@"GAMEOVER");
    }
    // clear dice here
}

#pragma mark State

- (BOOL)isNewGame {
    if ([turns  isEqual: @11]) {
        NSNumber *temp = [NSNumber numberWithInt:[turns intValue] -1];
        turns = temp;
        return YES;
    } else return NO;
}

- (BOOL)isGameOver {
    if ([turns  isEqual: @0] ) {
        //turns = @10;
        return YES;
    } else return NO;
}

// REALLY DON"T LIKE THIS METHOD
- (BOOL)canRoll {
    
 //   Score *score = [[Score alloc] init];
    
//    NSLog(@"canRoll - nonScoring: %d", score.nonScoring);

    if ( (self.isNewGame)
       // || (!self.areDiceHot)
       // || (self.lockedPoints >= 50)
        ) {
        return YES;
    }
 
 /*
    if ( ((!self.isNewGame) && ( (lockedPoints == 0) && (lockedPoints != -1)) )
        || (score.nonScoring) // hmm
        || (self.isGameOver)
        ) {
        return NO;
  */
    [self areDiceHot];
    /* // does commenting this out affect gameplay?
    if (self.noDiceSelected) {
        NSLog(@"noDiceSelected");
    }
    */
    if ( ((!self.isNewGame) && ((lockedPoints == 1) || (lockedPoints == 0) || (self.noDiceSelected) )) // was 1
        || (self.isGameOver)
        || (nonScoring)
        ) {
        return NO;
    } else return YES;
}

- (BOOL)canPass {
    Score *score = [[Score alloc] init];
 //   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 //   [defaults setObject:minimumScore forKey:@"minimumScore"];
 //   NSLog(@"%ld", (long)[minimumScore integerValue]);
    NSInteger temp = [passTitle integerValue];
    if ( (temp < 300) || (self.areDiceHot) || (score.nonScoring) )
    { // add a check for non-scoring dice
        return NO;
    } else return YES;
}

- (BOOL)noDiceSelected {
    NSInteger count = 0;
    for (int i = 0; i <= 5; i++) {
		if (![[dice objectAtIndex:i] isLocked])  {
			count++;
        }
        else if  (![[dice objectAtIndex:i] isScored]) {
            count++;
        }
    }
  //  NSLog(@"count: %d", count);
    if (count == 12) {
        return YES;
    } else return NO;
}

- (BOOL)areDiceHot {
    // if all dice are scored return YES

    NSInteger count = 0;
    for (int i = 0; i <= 5; i++) {
		if ( ([[dice objectAtIndex:i] isLocked]) || [[dice objectAtIndex:i] isScored]) {
			count++;
        }
    }
    if (count == 6) {
        return YES;
    } else return NO;
}

- (void)newGame {
    turns = @11;
    totalPoints = 0;
    scoredPoints = 0;
    lockedPoints = 0;
    finalPoints = 0;
    passTitle = @0;
    scoreTitle = @0;
}

- (int)whoOne {
    return -1;
}

- (BOOL)didPlayerWin {
    if (finalPoints >= 10000) {
        return YES;
    }
    return NO;
}

- (BOOL)didFarkle {
    if ((rolledPoints == 0) && (!isNewGame)) {
        [self endTurn];
         
        return YES;
    }
      return NO;
}

#pragma mark Dice

- (NSMutableArray *)newDice {
    NSMutableArray *newDice = [[NSMutableArray alloc] init];
    for (int i = 0; i <= 5; i++) {
		Die *die = [[Die alloc] init];
        [newDice addObject:die];
	}
    return newDice;
}



- (void)clearDice {
    Die *die = [[Die alloc] init];
    for (int i = 0; i <= 5; i++) {
        [dice replaceObjectAtIndex:i withObject:[die blankDie]];
	}
}

- (void)rollDice {
    
    if (!dice) {
        dice = [self newDice];
        nonScoring = NO;
   //     NSLog(@"rollDice nonScoring: %hhd", nonScoring);
        nonScoringDice = 0;
    }
    
    //NSLog(@"rollDice nonScoring: %hhd", nonScoring);
    
    if (self.areDiceHot) {
        dice = [self newDice];
    }
    // replace unlocked and unscored dice
	for (int i = 0; i <= 5; i++) {
		if ([[dice objectAtIndex:i] isLocked]) {
			[[dice objectAtIndex:i] setScored:YES];
		} else {
			Die *die = [[Die alloc] init];
			[dice replaceObjectAtIndex:i withObject:die];
		}
	}
 //   [self logRolled];
}

#pragma mark Console

- (void)logRolled {
    for (int i = 0; i < 6; i++) {
        if ((![[dice objectAtIndex:i] isLocked]) &&
            (![[dice objectAtIndex:i] isScored])) {
            NSLog(@"rolled: %@", [[dice objectAtIndex:i] sideUp]);
        }
    }
}

- (void)logLocked {
    
    for (int i = 0; i < 6; i++) {
        if ([[dice objectAtIndex:i] isLocked]) {
            NSLog(@"locked: %@", [[dice objectAtIndex:i] sideUp]);
        }
    }
}

- (void)logPoints {
    NSLog(@"=====================================");
    NSLog(@"rolledPoints %ld", (long)rolledPoints);
    NSLog(@"lockedPoints %ld", (long)lockedPoints);
    NSLog(@"scoredPoints %ld", (long)scoredPoints);
    NSLog(@"totalPoints  %ld", (long)totalPoints);
    NSLog(@"=====================================");
}

#pragma mark tutorial

// Tutorial, should probaby subclass or extend farkle with a Tutorial class that implements this
// be sure to initally call newDice and then clearDice so we get a nice blank array
- (NSMutableArray *)tutorialDice {
    
//	Die *die = [[Die alloc] init];
    
    NSArray *values = @[@1, @5, @3, @2, @2, @4, // 100010 roll
                                @2, @2, @2, @2, // 140010 diceHot, roll
                        @5, @5, @1, @6, @6, @4, // 100020 pass
                        @1, @1, @2, @2, @5, @5, // 220020 3pair, roll, farkle
                        @1, @2, @3, @4, @5, @6, // 111111 straight, roll
                        @1, @1, @1, @1, @4, @2  // 400000, pass, tutorial over
                        ];
    /*
    Die *die = [[Die alloc] init];
    [newDice addObject:die];
    */
    
    // need a loop that checks for locked & scored and adds the current i (position) to tutorialDice
    
    
    
    
    // the actual tutorial class should just step through the tutorial to avoid confusion. requiring specific things to be locked, unulocked, passed, rolled, etc...
    // pass and roll button are overridden, and only show up whenever tutorial wants
    
    // Player rolls 153324
    
    // replace unlocked and unscored dice
	for (int i = 0; i <= 5; i++) {
		if ([[dice objectAtIndex:i] isLocked]) {
			[[dice objectAtIndex:i] setScored:YES];
		} else {
//			Die *die = [[Die alloc] init];
            [dice replaceObjectAtIndex:i withObject:values[i]];
		}
	}
    
    // Player locks 1 and 5
    // Player unlocks 5
    // Player rolls 12522
    // diceAreHot = YES;
    // 
    
    
    
    
    return dice;
}

#pragma mark Sound

- (BOOL)increasedScore {
    if (totalPoints > previousPoints) {
        return YES;
    } return NO;
}


@end
