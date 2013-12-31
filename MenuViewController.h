//
//  MenuViewController.h
//  spinninyarn
//
//  Created by Kern Jackson on 11/25/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

#import "GCTurnBasedMatchHelper.h"
@class GameCenterManager;

@interface MenuViewController : UITableViewController <UIActionSheetDelegate, GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GCTurnBasedMatchHelperDelegate>
{
	
}

@property (nonatomic, retain) GameCenterManager *gameCenterManager;

@end
