//
//  Score.h
//  spinninyarn
//
//  Created by Kern Jackson on 12/24/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject {
    NSInteger rolledPoints;
    NSInteger lockedPoints;
    NSInteger scoredPoints;
    BOOL nonScoring;
}


@property (nonatomic, assign) NSInteger rolledPoints;
@property (nonatomic, assign) NSInteger lockedPoints;
@property (nonatomic, assign) NSInteger scoredPoints;
@property (nonatomic, assign) BOOL nonScoring;

- (NSInteger)scoreRolled:(NSMutableArray *)dice;
- (NSInteger)scoreLocked:(NSMutableArray *)dice;
- (NSInteger)scoreScored:(NSMutableArray *)dice;

- (BOOL)nonScoringDice:(NSArray *)unscored;


@end
