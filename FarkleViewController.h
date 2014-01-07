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

@interface FarkleViewController : UIViewController <ADBannerViewDelegate, UIActionSheetDelegate, GCTurnBasedMatchHelperDelegate, GKGameCenterControllerDelegate>
{

}

@end
