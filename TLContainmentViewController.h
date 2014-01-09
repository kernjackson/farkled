//
//  TLContainmentViewController.h
//  UIKit-Dynamics-Example
//
//  Created by Ash Furrow on 2013-07-09.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface TLContainmentViewController : UIViewController <ADBannerViewDelegate>

// want to access this from farklecontroller
- (void)bounceOnAppear;

@end
