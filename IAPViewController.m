//
//  IAPViewController.m
//  farkled
//
//  Created by Kern Jackson on 12/31/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import "IAPViewController.h"

@interface IAPViewController () {
    BOOL iap;
}

@property (weak, nonatomic) IBOutlet UISwitch *iapSwitch;

@end

@implementation IAPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    iap = [defaults boolForKey:@"iap"];
    
    [self updateControls];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark switch

- (IBAction)iapSwitched:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (iap) {
        iap = NO;
        [defaults setBool:iap forKey:@"iap"];
    } else {
        iap = YES;
        [defaults setBool:iap forKey:@"iap"];
    }
}

- (void)updateControls {
    
    // Switches
    
    if (iap) {
        [self.iapSwitch setOn:YES animated:YES];
        //       NSLog(@"sounds is TRUE");
    } else {
        [self.iapSwitch setOn:NO animated:YES];
        //      NSLog(@"sounds is FALSE");
    }
}

#pragma mark Nav Bar

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}

@end
