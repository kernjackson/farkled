//
//  FarkleViewController.h
//  spinninyarn
//
//  Created by Kern Jackson on 12/8/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "GCTurnBasedMatchHelper.h"
#import "GameCenterManager.h"

@class FarkleViewController;

@protocol TLContentViewControllerDelegate <NSObject>

-(void)contentViewControllerDidPressBounceButton:(FarkleViewController *)viewController;

@end

@interface FarkleViewController : UIViewController <ADBannerViewDelegate, UIActionSheetDelegate, GameCenterManagerDelegate, GCTurnBasedMatchHelperDelegate, GKGameCenterControllerDelegate>
{

}

@property (nonatomic, weak) id<TLContentViewControllerDelegate> delegate;

@end
