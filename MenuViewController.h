//
//  MenuViewController.h
//  spinninyarn
//
//  Created by Kern Jackson on 11/25/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>

#import "GCTurnBasedMatchHelper.h"
@class GameCenterManager;

@interface MenuViewController : UITableViewController <UIActionSheetDelegate, GCTurnBasedMatchHelperDelegate, GKGameCenterControllerDelegate>
{
//	ADBannerView *bannerView;
}

@property (nonatomic, retain) GameCenterManager *gameCenterManager;

@end
