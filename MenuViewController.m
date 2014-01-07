//
//  MenuViewController.m
//  spinninyarn
//
//  Created by Kern Jackson on 11/25/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import "MenuViewController.h"
#import "GameCenterManager.h"

@interface MenuViewController () {

    BOOL iap;

}
@property (weak, nonatomic) IBOutlet UITableViewCell *settingsCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *spacerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *gameCenter;
@property (weak, nonatomic) IBOutlet ADBannerView *bannerAd;

@property (weak, nonatomic) IBOutlet UITableViewCell *iapHeaderCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *iapCell;

@end

@implementation MenuViewController

@synthesize gameCenterManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //bannerView.delegate = self;

 //   [self performSegueWithIdentifier:@"SolitaireSegue" sender:self];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[GCTurnBasedMatchHelper sharedInstance] authenticateLocalUser];
    [GCTurnBasedMatchHelper sharedInstance].delegate = self;
    
    
    // Will have to write iap to defaults when user purchases upgrade
    if (iap) {
    // hide stuff that's for iap purchasers here
        [self.iapHeaderCell setHidden:YES];
        [self.iapCell setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Nav Bar
/*
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
*/
#pragma mark Game Center

- (IBAction)gameCenter:(id)sender {
    [[GCTurnBasedMatchHelper sharedInstance]
     findMatchWithMinPlayers:2 maxPlayers:2 viewController:self];
}

- (IBAction)gameCenter2:(id)sender {
    [self showGameCenter];
}


#pragma mark - GCTurnBasedMatchHelperDelegate

-(void)enterNewGame:(GKTurnBasedMatch *)match {
}

-(void)takeTurn:(GKTurnBasedMatch *)match {
}

-(void)layoutMatch:(GKTurnBasedMatch *)match {
}

-(void)sendNotice:(NSString *)notice forMatch:(GKTurnBasedMatch *)match {
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
}

-(void)recieveEndGame:(GKTurnBasedMatch *)match {
    [self layoutMatch:match];
}


#pragma mark from GC docs

- (void) showGameCenter
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        [self presentViewController: gameCenterController animated: YES completion:nil];
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark iAd Delegate Methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}
*/

- (IBAction)singlePlayer:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
