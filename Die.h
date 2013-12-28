//
//  Die.h
//  Farkle
//
//  Created by Kern Jackson on 5/25/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Die : NSObject {
    
}

@property (nonatomic) NSNumber *sideValue;
@property (strong, nonatomic) NSString *sideUp;

@property (nonatomic, getter = isLocked) BOOL locked;
@property (nonatomic, getter = isScored) BOOL scored;

- (id)blankDie;
- (id)rollDie;
- (id)tutorialDie:(NSInteger)side;

@end
