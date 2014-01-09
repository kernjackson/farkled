//
//  FarkleViewController.m
//  spinninyarn
//
//  Created by Kern Jackson on 12/8/13.
//  Copyright (c) 2013 Kern Jackson. All rights reserved.
//

#import "FarkleViewController.h"
#import "Farkle.h"
//#import "Settings.h"
#import "Sound.h"
#import "Player.h"

#import <AdSupport/AdSupport.h>
#import "GameCenterManager.h"

#import "TLContainmentViewController.h"

@interface FarkleViewController () {
    BOOL iap;
    BOOL sounds;
    
    BOOL isBannerVisible;
    
    
    NSInteger careerWins;
    NSInteger careerLossess;
    NSInteger careerFarkles;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *diceButtons;
@property (weak, nonatomic) IBOutlet UIButton *passButton;
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *HUD;
@property (weak, nonatomic) IBOutlet UIProgressView *turnsProgress;
@property (weak, nonatomic) IBOutlet ADBannerView *bannerAd;
@property (weak, nonatomic) IBOutlet UILabel *tapToPlayButton;
@property (strong, nonatomic) IBOutlet UIView *farkleView;
@property (weak, nonatomic) IBOutlet UIView *gamePlayView;
@property (weak, nonatomic) IBOutlet UILabel *swipeForMenu;

@end

#define TURNS 10

@implementation FarkleViewController

@synthesize bannerAd;


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
    
//    [[GameCenterManager sharedManager] setupManager]; // Or use setupManagerAndSetShouldCryptWithKey: for use with encryption
    [[GameCenterManager sharedManager] setDelegate:self];
    
    [[GCTurnBasedMatchHelper sharedInstance] authenticateLocalUser];
    [GCTurnBasedMatchHelper sharedInstance].delegate = self;
    
    self.bannerAd.delegate = self;
    
    [self checkSettings];
    
   // Farkle *farkle = [Farkle sharedManager];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  /*
    [self updateUI];
    [self enableRollButton]; // fixes newGame issue, but allows player to cheat
   */
 /*
    if (farkle.isGameOver) {
        [self clearDice];
        [self updateDice];
        [self redrawDice];
    }
    
    else {
*/
    [self togglePassButton];
    [self toggleRollButton];

    [self updateDice];
    [self redrawDice];
    [self toggleNavBar];
//    }
    //[self shakeView];
    
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
	// Do any additional setup after loading the view.

//    farkle.total = @1;
    
    // Setup gesture recoginizer
    

   // possibly use handle pan instead
   /*
    UISwipeGestureRecognizer *mSwipeRightRecognizer = [[UISwipeGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(pullDownMenu)];
    [mSwipeRightRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:mSwipeRightRecognizer];
    */
 /*
    UISwipeGestureRecognizer *mSwipeUpRecognizer = [[UISwipeGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(pullDownMenu)];
    [mSwipeUpRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:mSwipeUpRecognizer];
*/
    
  
    
//    self.navigationController.navigationBar.translucent = NO;
//    [[UINavigationBar appearance] setTranslucent:NO];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"TransparantNavBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //bannerView.delegate = self; // not sure if I need this
 /*
    if (iap) {
        [self disableBannerView:bannerAd];
    }
  */
    // new years
    Farkle *farkle = [Farkle sharedManager];
    if ((!farkle.areDiceCleared) && (farkle.isGameOver) ) {
        [self disableDice];
        [self newGame];
    }
    
    if (!farkle.nonScoring) {
        NSLog(@"unselect nonscoring dice");
    }
    
    if ( (!farkle.canPass) && (!farkle.canRoll) ) {
        [self disableDice];
    }
  
    //[self disableDice]; // just proving that it works
    //[self disableBannerView:bannerAd];
    
    // Shake to Rage Quit
    //[self becomeFirstResponder];
    
    //[self performSegueWithIdentifier:@"ModalMenuSegue" sender:self];
    
    //[self runSpinAnimationWithDuration:3];
    
 //   [self swipeForMenuAnimation];
    
    [self hintMenu]; // this doesn't work
    
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(menuAppeared) name:@"MenuAppeared" object:nil];
    /*
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(settingsAppeared) name:@"SettingsAppeared" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(settingsWillDisapear) name:@"SettingsWillDisappear" object:nil];
   */ 
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(menuDissapeared) name:@"MenuDisappeared" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(menuAppeared) name:@"MenuAppeared" object:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:12.0
                                     target:self
                                   selector:@selector(hintNotification)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)menuAppeared {
    [self pauseScreen];
    NSLog(@"menuAppeared");
}
/*
- (void)settingsAppeared {
    [self checkSettings];
    [self resumeScreen];
    NSLog(@"settingAppeared");
}

- (void)settingsWillDisapear {
    [self checkSettings];
    NSLog(@"settingsWillDisappear");
}
*/
- (void)menuDissapeared {
    [self checkSettings];
    [self resumeScreen];
    NSLog(@"menuDissapeared");

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark AnimateSlideView
/*
- (CGRect)frameForPreviousViewWithTranslate:(CGPoint)translate
{
    return CGRectMake(-self.view.bounds.size.width + translate.x, translate.y, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (CGRect)frameForCurrentViewWithTranslate:(CGPoint)translate
{
    return CGRectMake(translate.x, translate.y, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (CGRect)frameForNextViewWithTranslate:(CGPoint)translate
{
    return CGRectMake(self.view.bounds.size.width + translate.x, translate.y, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    // transform the three views by the amount of the x translation
    
    CGPoint translate = [gesture translationInView:gesture.view];
    translate.y = 0.0; // I'm just doing horizontal scrolling
    
    prevView.frame = [self frameForPreviousViewWithTranslate:translate];
    currView.frame = [self frameForCurrentViewWithTranslate:translate];
    nextView.frame = [self frameForNextViewWithTranslate:translate];
    
    // if we're done with gesture, animate frames to new locations
    
    if (gesture.state == UIGestureRecognizerStateCancelled ||
        gesture.state == UIGestureRecognizerStateEnded ||
        gesture.state == UIGestureRecognizerStateFailed)
    {
        // figure out if we've moved (or flicked) more than 50% the way across
        
        CGPoint velocity = [gesture velocityInView:gesture.view];
        if (translate.x > 0.0 && (translate.x + velocity.x * 0.25) > (gesture.view.bounds.size.width / 2.0) && prevView)
        {
            // moving right (and/or flicked right)
            
            [UIView animateWithDuration:0.25
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 prevView.frame = [self frameForCurrentViewWithTranslate:CGPointZero];
                                 currView.frame = [self frameForNextViewWithTranslate:CGPointZero];
                             }
                             completion:^(BOOL finished) {
                                 // do whatever you want upon completion to reflect that everything has slid to the right
                                 
                                 // this redefines "next" to be the old "current",
                                 // "current" to be the old "previous", and recycles
                                 // the old "next" to be the new "previous" (you'd presumably.
                                 // want to update the content for the new "previous" to reflect whatever should be there
                                 
                                 UIView *tempView = nextView;
                                 nextView = currView;
                                 currView = prevView;
                                 prevView = tempView;
                                 prevView.frame = [self frameForPreviousViewWithTranslate:CGPointZero];
                             }];
        }
        else if (translate.x < 0.0 && (translate.x + velocity.x * 0.25) < -(gesture.view.frame.size.width / 2.0) && nextView)
        {
            // moving left (and/or flicked left)
            
            [UIView animateWithDuration:0.25
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 nextView.frame = [self frameForCurrentViewWithTranslate:CGPointZero];
                                 currView.frame = [self frameForPreviousViewWithTranslate:CGPointZero];
                             }
                             completion:^(BOOL finished) {
                                 // do whatever you want upon completion to reflect that everything has slid to the left
                                 
                                 // this redefines "previous" to be the old "current",
                                 // "current" to be the old "next", and recycles
                                 // the old "previous" to be the new "next". (You'd presumably.
                                 // want to update the content for the new "next" to reflect whatever should be there
                                 
                                 UIView *tempView = prevView;
                                 prevView = currView;
                                 currView = nextView;
                                 nextView = tempView;
                                 nextView.frame = [self frameForNextViewWithTranslate:CGPointZero];
                             }];
        }
        else
        {
            // return to original location
            
            [UIView animateWithDuration:0.25
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 prevView.frame = [self frameForPreviousViewWithTranslate:CGPointZero];
                                 currView.frame = [self frameForCurrentViewWithTranslate:CGPointZero];
                                 nextView.frame = [self frameForNextViewWithTranslate:CGPointZero];
                             }
                             completion:NULL];
        }
    }
}
*/
#pragma mark Nav Bar

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    Farkle *farkle = [Farkle sharedManager];
    /*
    if (!farkle.areDiceCleared) {
        [self disableDice];
    }
*/
    [self checkSettings];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
/*
- (void)slideUpMenu {
    [self performSegueWithIdentifier:@"ModalMenuSegue" sender:self];
}
*/
/*
- (void)popView {
    // Pop this view off the stack
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController pushViewController: animated:YES]
}

- (void) pullDownMenu {
    [self performSegueWithIdentifier:@"ModalMenuSegue" sender:self];
}
*/
/*
- (void)animationPush {
    MainView *nextView = [[MainView alloc] init];
    [UIView animateWithDuration:0.75
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [self.navigationController pushViewController:nextView animated:NO];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }];
}

- (void)popAnimated {
    [UIView animateWithDuration:0.75
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [UIView setAnimationTransition:pop forView:self.navigationController.view cache:NO];
                     }];
    [self.navigationController popViewControllerAnimated:NO];
}
*/
#pragma mark Actions

- (IBAction)rolled:(id)sender {
    
    Farkle *farkle = [Farkle sharedManager];
    
    // need to check the state of newGame, and then change it so that we don't get a crash or a bunch of deactivated controls here
    
   // Sound *sound = [[Sound alloc] init];
    /*
    if (sound) {
        [sound rollDice1];
    }
    */
   // Sound *playSound = [[Sound alloc] init];
    
  //  [playSound rolled];
    
	[self rollDice];
    [farkle rolled];
    [self showDice];
    
    //[farkle gameLoop];
	[self updateUI];
}

// change the name of this to toggleDie...
- (IBAction)selectDice:(UIButton *)sender {
    
    Farkle *farkle = [Farkle sharedManager];
    
    // hack
   // if (!farkle.turns) {
/*
    Sound *sound = [[Sound alloc] init];
    
    if (sounds) {
        [sound nonscoring1];
    }
*/
   // Sound *playSound = [[Sound alloc] init];
    
    if ((farkle.dice) && (!farkle.didFarkle)) {
        if ([sender isSelected]) {
            [self enableDie:sender];
         /*
            if (sounds) {
                [playSound nonscoring1];
            }
          */
        } else {
          /*
            if ( (sounds) && (![self.passButton.titleLabel.text isEqual:@"0"]) ) {
                [playSound coinUp];
            }
           */
            /*
            // check to see if current title is ==, <, or > new passTitle
            if (sounds) {
        //        if (farkle.increasedScore > 1) {
                [sound coinUp];
          //      }
            }*/
            [self disableDie:sender];
        }
        //[farkle gameLoop];
        [farkle toggleDie];
        [self updateUI];
    }
    
    // should just play a sound, but instead it disabl locked dice
    /*
    if (farkle.areDiceHot) {
        [playSound hotDice];
    }
     */
}
/*
- (void)coinUp {
    Farkle *farkle = [Farkle sharedManager];
    Sound *sound = [[Sound alloc] init];
    
    if (farkle.increasedScore) {
        // how and where do we check for die values to play different sounds?
        [sound coinUp];
    }
}
*/
- (IBAction)passed:(id)sender {
    
    Farkle *farkle = [Farkle sharedManager];
    Sound *playSound = [[Sound alloc] init];
    
    [self passedAnimation];
    
    if (sounds) {
        [playSound passedSmall];
    }
    
    [self disableDice]; // new years
    [farkle passed];
    
//    NSLog(@"turns: %@", farkle.turns);
    
    [self hideDice];
    
    //[self clearDice];
    [self enableRollButton]; // hack
    [self updateUI];
    
}

// Don't really like this method name
- (IBAction)startedNewGame:(id)sender {
    
	[self.HUD setTitle:[NSString stringWithFormat:@"new game"]
              forState:UIControlStateNormal];
    
	[self newGame];
}

- (void)endGame {
    Sound *sound = [[Sound alloc] init];
    [self disableDice];
    
    if (sounds) {
        [sound gameOver];
    }
    [self reportScore]; // GC
    [self gameOver];

    }

#pragma mark not sure if controller or model

- (void)newGame {
    Farkle *farkle = [Farkle sharedManager];
    
    
	[self.HUD setEnabled:NO];
	[self.HUD setTitle:[NSString stringWithFormat:@""]
              forState:UIControlStateNormal];
    [self.rollButton setSelected:NO];
	[self.rollButton setEnabled:YES];
	[self clearScreen];
	self.scoreLabel.textColor = [UIColor blackColor];
	[self clearDice];
   // [self disableDice];
    [farkle newGame];
    
	[self updateUI]; // hotDice causes a crash because there is nothing in the array
 //   [self hideBannerAd];
    /*
    TLContainmentViewController *containment = [[TLContainmentViewController alloc] init];
    [containment bounceOnAppear];
     */
}

#pragma mark Pass

- (void)enablePassButton {
	[self.passButton setEnabled:YES];
	[self.passButton setAlpha:1.0];
    [self.passButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)disablePassButton {
	[self.passButton setEnabled:NO];
    [self.passButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	self.passButton.alpha = .4;
}

- (IBAction)pressedButton:(id)sender {
    [UIView transitionWithView:sender
                      duration:0.2
                       options:
     UIViewAnimationOptionAllowUserInteraction animations:^{
         [self.passButton setTransform:CGAffineTransformMakeScale(0.95, 0.95  )];
     } completion:nil];

}

- (IBAction)releasedButton:(id)sender {
    [UIView transitionWithView:sender
                      duration:0.2
                       options:
     UIViewAnimationOptionAllowUserInteraction animations:^{
         [self.passButton setTransform:CGAffineTransformMakeScale(1.0, 1.0  )];
     } completion:nil];
    
}

#pragma mark Dice

- (void)newDice {
    Farkle *farkle = [Farkle sharedManager];
    [farkle newDice];
    for (int i = 0; i <= 5; i++) {
        [self flipDiceButtons:i];
    }
}

- (void)rollDice {
    Farkle *farkle = [Farkle sharedManager];
    [farkle rollDice];
	for (int i = 0; i <= 5; i++) {
		if ([[farkle.dice objectAtIndex:i] isLocked]) {
            [[self.diceButtons objectAtIndex:i] setAlpha:.1];
            [[self.diceButtons objectAtIndex:i] setEnabled:NO];
			
		} else [self flipDiceButtons:i];
	}
}

- (void)enableDie:(UIButton *)sender {
    
    Farkle *farkle = [Farkle sharedManager];

    [[farkle.dice objectAtIndex:[self.diceButtons indexOfObject:sender]] setLocked:NO];
	[sender setSelected:NO];
	[sender setAlpha:1];
    // call animation here?
}

- (void)disableDie:(UIButton *)sender {
    
    Farkle *farkle = [Farkle sharedManager];
    
    [[farkle.dice objectAtIndex:[self.diceButtons indexOfObject:sender]] setLocked:YES];
	[sender setSelected:YES];
	[UIView animateWithDuration:0.10 animations:^{sender.alpha = 0.4;}];
}

- (void)hideDice {
    
	for (int i = 0; i <= 5; i++) {
		[[self.diceButtons objectAtIndex:i] setAlpha:0.0];
		[[self.diceButtons objectAtIndex:i] setEnabled:NO];
		[[self.diceButtons objectAtIndex:i] setSelected:NO];
		//[[self.diceButtons objectAtIndex:i] setTitle:@""
        //                                    forState:UIControlStateNormal];
	}
}

- (void)disableDice {
    for (int i = 0; i <= 5; i++) {
		[[_diceButtons objectAtIndex:i] setAlpha:.1];
		[[self.diceButtons objectAtIndex:i] setEnabled:NO];
		[[self.diceButtons objectAtIndex:i] setSelected:YES];
    }
}


- (void)showDice {
    Farkle *farkle = [Farkle sharedManager];
	for (int i = 0; i <= 5; i++) {
        if (![[farkle.dice objectAtIndex:i] isLocked]) {
            [[_diceButtons objectAtIndex:i] setAlpha:1];
            [[self.diceButtons objectAtIndex:i] setEnabled:YES];
            [[self.diceButtons objectAtIndex:i] setSelected:NO];
            [[self.diceButtons objectAtIndex:i] setTitle:@"s"
                                                forState:UIControlStateNormal];
        }
	}
}

- (void)clearDice {
    
	for (int i = 0; i <= 5; i++) {
		[[_diceButtons objectAtIndex:i] setAlpha:1];
		[[self.diceButtons objectAtIndex:i] setEnabled:NO];
		[[self.diceButtons objectAtIndex:i] setSelected:NO];
		[[self.diceButtons objectAtIndex:i] setTitle:@"c"
                                            forState:UIControlStateNormal];
		[[self.diceButtons objectAtIndex:i] setEnabled:NO]; // ???
	}
}

- (void)logDiceButtons {
    for (int i = 0; i < 6; i++) {
        if ([self.diceButtons[i] isEnabled]) {
            NSLog(@"enabled %d", i);
        } else NSLog(@"disabled %d", i);
    }
}

- (void)redrawDice {
    Farkle *farkle = [Farkle sharedManager];
 //   [farkle passed];
  //  [self logDiceButtons];
 //   NSLog(@"#####################");
    [self hideDice];
 //   [self logDiceButtons];
    [self updateScoreLabel];
    [self updatePassButton];
    [self updateTurnsProgress];
  //  [self enableRollButton]; // hack
  
	for (int i = 0; i <= 5; i++) {
        if ([[farkle.dice objectAtIndex:i] isLocked] && ![[farkle.dice objectAtIndex:i] isScored] ) {
            [[self.diceButtons objectAtIndex:i] setAlpha:0.4];
            [[self.diceButtons objectAtIndex:i] setEnabled:YES];
            [[self.diceButtons objectAtIndex:i] setSelected:YES];
            [[self.diceButtons objectAtIndex:i] setTitle:[[farkle.dice objectAtIndex:i] sideUp]
                                                forState:UIControlStateNormal];
        }
        else if ([[farkle.dice objectAtIndex:i] isScored]) {
            [[self.diceButtons objectAtIndex:i] setAlpha:0.1];
            [[self.diceButtons objectAtIndex:i] setEnabled:NO];
            [[self.diceButtons objectAtIndex:i] setSelected:YES];
            [[self.diceButtons objectAtIndex:i] setTitle:[[farkle.dice objectAtIndex:i] sideUp]
                                                forState:UIControlStateNormal];
        }

//        else if ([self.diceButtons objectAtIndex:i])
        
        else if ( (!farkle.isNewGame) || (!farkle.isGameOver) ) {
            [[self.diceButtons objectAtIndex:i] setAlpha:1];
            [[self.diceButtons objectAtIndex:i] setEnabled:YES];
            [[self.diceButtons objectAtIndex:i] setSelected:NO];
            [[self.diceButtons objectAtIndex:i] setTitle:[[farkle.dice objectAtIndex:i] sideUp]
                                                forState:UIControlStateNormal];
        }
        
        else if (![farkle.dice[i] sideUp]) {
            [[self.diceButtons objectAtIndex:i] setAlpha:0.0];
            [[self.diceButtons objectAtIndex:i] setEnabled:NO];
            [[self.diceButtons objectAtIndex:i] setSelected:NO];
           //NSLog(@"%d is nil", i);
        } //NSLog(@"%@", farkle.dice[i]);
   /*
        else {
            [[self.diceButtons objectAtIndex:i] setAlpha:0.0];
            [[self.diceButtons objectAtIndex:i] setEnabled:NO];
            [[self.diceButtons objectAtIndex:i] setSelected:NO];
        }
   */
        
        
	}
    // pretty sure this BOOL is backwards
    if (!farkle.isNewGame) {
        [self enableRollButton];
    //    [self hintRollButton];
       // NSLog(@"enableRollButton");
    }

}

// replace this with 3d cubes behind, etc...
- (void)flipDiceButtons:(int)index {
	if (index == 0) {
        [UIView transitionWithView:[self.diceButtons objectAtIndex:index]
                          duration:0.25
                           options:UIViewAnimationOptionTransitionFlipFromBottom |
         UIViewAnimationOptionAllowUserInteraction animations:^{
         } completion:nil];
	}
	if (index == 1) {
		[UIView transitionWithView:[self.diceButtons objectAtIndex:index]
                          duration:0.25
                           options:UIViewAnimationOptionTransitionFlipFromTop |
		 UIViewAnimationOptionAllowUserInteraction animations:^{
		 } completion:nil];
	}
	if ((index == 2) || (index == 3)) {
		[UIView transitionWithView:[self.diceButtons objectAtIndex:index]
                          duration:0.25
                           options:UIViewAnimationOptionTransitionFlipFromLeft |
		 UIViewAnimationOptionAllowUserInteraction animations:^{
		 } completion:nil];
	}
	if ((index == 4) || (index == 5)) {
		
		[UIView transitionWithView:[self.diceButtons objectAtIndex:index]
                          duration:0.25
                           options:UIViewAnimationOptionTransitionFlipFromRight |
		 UIViewAnimationOptionAllowUserInteraction
                        animations:^{
                        } completion:nil];
	} //else NSLog(@"flipDiceButtons: error %d", index);
}

#pragma mark Roll

- (void)disableRollButton {
	
	[self.rollButton setEnabled:NO];
	[self.rollButton setAlpha:0.0];
 //   NSLog(@"Disable rollButton");
}

- (void)enableRollButton {
	
	[self.rollButton setEnabled:YES];
	[self.rollButton setAlpha:1.0];
}


- (IBAction)pressedRollButton:(id)sender {
    /*
    [UIView transitionWithView:sender
                      duration:0.2
                       options:
     UIViewAnimationOptionAllowUserInteraction animations:^{
         [self.rollButton setTransform:CGAffineTransformMakeScale(0.95, 1.0  )];
     } completion:nil];
    */
}

- (IBAction)releasedRollButton:(id)sender {
    /*
    [UIView transitionWithView:sender
                      duration:0.2
                       options:
     UIViewAnimationOptionAllowUserInteraction animations:^{
         [self.rollButton setTransform:CGAffineTransformMakeScale(1.0, 1.0  )];
     } completion:nil];
    */
}

- (void)hintRollButton {
    [UIView animateWithDuration:0.9
                          delay:1.2 // otherwise we will see disabled die flip
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat
                     animations:^{
                         [self.rollButton setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                         [self.rollButton setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
                     }
                     completion:nil];
}

#pragma mark HUD

- (void)cycleColorsScreen {
	[UIView animateWithDuration:0.2
                          delay:0.2 // otherwise we will see disabled die flip
                        options:
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAutoreverse
                     animations:^{
                         self.HUD.backgroundColor = [UIColor yellowColor];
                         self.HUD.alpha = 0.5;
                         self.HUD.alpha = 0.0;
                     }
                     completion:nil];
}

- (void)passedAnimation {
	[UIView animateWithDuration:0.2
                          delay:0.2 // otherwise we will see disabled die flip
                        options: UIViewAnimationOptionCurveEaseIn // | UIViewAnimationOptionAutoreverse
                     animations:^{
                         self.HUD.backgroundColor = [UIColor greenColor];
                         self.HUD.alpha = 0.5;
                         self.HUD.backgroundColor = [UIColor whiteColor];
                         self.HUD.alpha = 0.0;
                     }
                     completion:nil];
}

- (void)hotDiceAnimation {
	[UIView animateWithDuration:0.2
                          delay:0.2 // otherwise we will see disabled die flip
                        options: UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAutoreverse
                     animations:^{
                         self.HUD.backgroundColor = [UIColor greenColor];
                         self.HUD.alpha = 0.5;
                         self.HUD.backgroundColor = [UIColor whiteColor];
                         self.HUD.alpha = 0.0;
                     }
                     completion:nil];
}

- (void)flashScreen {
	[UIView animateWithDuration:0.4
                          delay:0.2 // otherwise we will see disabled die flip
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                            self.HUD.backgroundColor = [UIColor redColor];
                            self.HUD.alpha = 1.0;
                            self.HUD.alpha = 0.0;
                        }
                     completion:nil];
}

- (void)clearScreen {
	[UIView animateWithDuration:0.6
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut |
	 UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.HUD.backgroundColor = [UIColor whiteColor];
                         self.HUD.alpha = 0.0;
                         [self.tapToPlayButton setAlpha:0.0];
                         self.bannerAd.alpha = 0.0;
                         //		 [self.HUD setTitle:[NSString stringWithFormat:@""]
                         //							 forState:UIControlStateNormal];
                     }
                     completion:nil];
}

- (void)deathScreen {
	[UIView animateWithDuration:1.6
                          delay:0.6
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.HUD.backgroundColor = [UIColor redColor];
                         self.HUD.alpha = 1.0;
                         self.tapToPlayButton.alpha = 1.0;
                       //  [self.tapToPlayButton setAlpha:1.0];
                         if ( (!iap) && (!isBannerVisible) )
                         {
                             [self enableBannerView:bannerAd];
                         //    [self.bannerAd setAlpha:1];
                         }
                         
                         // self.HUD.tintColor = [UIColor whiteColor];
                         self.scoreLabel.textColor = [UIColor blackColor];
                     }
                     completion:nil];
}

- (void)victoryScreen {
	[UIView animateWithDuration:.8
                          delay:0.6
                        options:
     UIViewAnimationOptionCurveEaseIn |
     UIViewAnimationOptionCurveEaseOut |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.HUD.backgroundColor = [UIColor purpleColor];
                         self.HUD.alpha = 1.0;
                         if ( (!iap) && (isBannerVisible) ) {
                             [self enableBannerView:bannerAd];
                         }
                         // self.HUD.tintColor = [UIColor whiteColor];
                         self.scoreLabel.textColor = [UIColor blackColor];
                     }
                     completion:nil];
}

- (void)pauseScreen {
	[UIView animateWithDuration:0.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
 //                        self.HUD.backgroundColor = [UIColor groupTableViewBackgroundColor];
 //                        self.HUD.alpha = 1.0;
                         self.HUD.enabled = NO;
                         [self disableRollButton];
                         [self disablePassButton];
                         //[self disableDice];
                        // self.tapToPlayButton.alpha = 1.0;
                         //  [self.tapToPlayButton setAlpha:1.0];
                         /*
                         if ( (!iap) && (!isBannerVisible) )
                         {
                             [self enableBannerView:bannerAd];
                             //    [self.bannerAd setAlpha:1];
                         }
                         */
                         // self.HUD.tintColor = [UIColor whiteColor];
           //              self.scoreLabel.textColor = [UIColor blackColor];
                     }
                     completion:nil];
}

- (void)resumeScreen {
	[UIView animateWithDuration:0.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
     //                    self.HUD.backgroundColor = [UIColor whiteColor];
//                         self.HUD.alpha = 0.0;
                         self.HUD.enabled = YES;
                         [self enableRollButton];
                         [self togglePassButton];
            /*
                         Farkle *farkle = [Farkle sharedManager];
                         
                         if (farkle.isGameOver) {
                             [self endGame];
                         }
             */
                         //[self showDice];
                         // self.tapToPlayButton.alpha = 1.0;
                         //  [self.tapToPlayButton setAlpha:1.0];
                         /*
                         if ( (!iap) && (!isBannerVisible) )
                         {
                             [self enableBannerView:bannerAd];
                             //    [self.bannerAd setAlpha:1];
                         }
                         */
                         // self.HUD.tintColor = [UIColor whiteColor];
             //            self.scoreLabel.textColor = [UIColor blackColor];
                     }
                     completion:nil];
}

- (void)gameOver {
  //  [self showBannerAd];
    [self disableRollButton];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
	[self.rollButton setEnabled:NO];
	[self.HUD setTitle:[NSString stringWithFormat:@"game over"]
              forState:UIControlStateNormal];
	[self deathScreen];
	// prevent the user from clicking the HUD for 1.6 seconds
	[NSTimer scheduledTimerWithTimeInterval:1.6
                                     target:self
                                   selector:@selector(enableHUD:)
                                   userInfo:nil
                                    repeats:NO];
    
    
    [NSTimer scheduledTimerWithTimeInterval:12.0
                                     target:self
                                   selector:@selector(hintNotification)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)hintNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hintMenu" object:nil];
}

- (void)playerWon {
    
    Farkle *farkle = [Farkle sharedManager];
    
    //[[UINavigationBar appearance] setBarTintColor:[UIColor purpleColor]];
	[self.rollButton setEnabled:NO];
//	[self.HUD setTitle:[NSString stringWithFormat:@"you  won"]
//              forState:UIControlStateNormal];
    [self.HUD setTitle:[NSString stringWithFormat:@"you  won"]
              forState:UIControlStateNormal];
//    [self.HUD setTitle:[NSString stringWithFormat:@"%@", [farkle scoreTitle]] forState:UIControlStateNormal];
    [self disableRollButton];
	[self victoryScreen];
    
	// prevent the user from clicking the HUD for 1.6 seconds
	[NSTimer scheduledTimerWithTimeInterval:1.6
                                     target:self
                                   selector:@selector(enableHUD:)
                                   userInfo:nil
                                    repeats:NO];
}


- (void)enableHUD:(id)sender {
	[self.HUD setEnabled:YES];
}

- (void)highScoreScreen {
	[UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn |
	 UIViewAnimationOptionRepeat |
	 UIViewAnimationOptionAutoreverse |
	 UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.HUD.backgroundColor = [UIColor whiteColor];
                         self.HUD.alpha = 1.0;
                         self.HUD.backgroundColor = [UIColor redColor];
                         self.HUD.backgroundColor = [UIColor blueColor];
                         self.HUD.backgroundColor = [UIColor yellowColor];
                         self.HUD.backgroundColor = [UIColor greenColor];
                         // self.scoreLabel.textColor = [UIColor blackColor];
                     }
                     completion:nil];
}

#pragma mark updateUI

- (void)updateDice {
    Farkle *farkle = [Farkle sharedManager];
    for (int i = 0; i <= 5; i++) {
        if (![[farkle.dice objectAtIndex:i] isLocked]) {
            [[self.diceButtons objectAtIndex:i] setTitle:[[farkle.dice objectAtIndex:i] sideUp]
                                                forState:UIControlStateNormal];
        }
    }
}

- (void)updateUI {
    
    Farkle *farkle = [Farkle sharedManager];
    Sound *playSound = [[Sound alloc] init];
    

    // update Dice
    [self updateDice];
    

    if ([farkle didFarkle]) {
        if (sounds) {
            [playSound didFarkle];
        }
        [self disableDice];
        [self flashScreen];
        //[self enableRollButton]; // hack
    }

    // is Game Over?
    if ([farkle isGameOver]) {
        
        [self disableDice];
        
    // did this make it slow?
        if ([farkle didPlayerWin]) {
            
            [self playerWon];
        } else {
      //      [self disableDice];
           // [self redrawDice]; // new years
            [self endGame];
          //  [self disableDice];
        }
    }

    [self togglePassButton];
    [self toggleRollButton];
/*
    if ([farkle didFarkle]) {
        [self enableRollButton]; // this feels like a hack
    }
*/
    
    
//    NSLog(@"canRoll: %hhd", [farkle canRoll]);

    //[self toggleNavBar]; // we want to do this after the deathScreen Animation fires
  //  [self delayedToggleNavBar];
    
    [self updateScoreLabel];
    [self updatePassButton];
    [self updateTurnsProgress];
    
    // duplicate code?
    if ([farkle didFarkle]) {
        [self disableDice];
   //     [self hintRollButton]; // hack
        [self enableRollButton]; // hack
    }
    
    if ([farkle isGameOver]) {
        [self hideDice];
        [self disableRollButton];
        [self disableDice];
    }
 /*
    if ([farkle.turns isEqual: @10]) {
      //  [self disableDice];
    }
*/
/*
    // hmm
    if ( (farkle.areDiceHot) && (![farkle.scoreTitle isEqual:@"0"]) ) {
        [self hotDiceAnimation];
        [playSound hotDice];
    }
 */
}

- (void)updateScoreLabel {
    Farkle *farkle = [Farkle sharedManager];
    [self.scoreLabel setText:[NSString stringWithFormat:@"%@", [farkle scoreTitle]]];
}

- (void)updatePassButton {
    Farkle *farkle = [Farkle sharedManager];
    Sound *playSound = [[Sound alloc] init];
 
    [self.passButton setTitle:[NSString stringWithFormat:@"+ %@", [farkle passTitle]] forState:UIControlStateNormal];
    [self.passButton setTitle:[NSString stringWithFormat:@"%@", [farkle passTitle]] forState:UIControlStateDisabled];
    
    // check to see if current title is ==, <, or > new passTitle
    if (sounds) {
 
        if (![self.passButton.titleLabel.text isEqual:@"0"]) {
           [playSound coinUp];
        }
  }
  
 /*
        if ( (farkle.increasedScore) && (!farkle.nonScoring) ) {
            [playSound coinUp];
        }
  */
    /*
    if ([farkle.passTitle  isEqual: @100]) {
        [self cycleColorsScreen];
    }
     */
}

- (void)updateTurnsProgress {
    Farkle *farkle = [Farkle sharedManager];
    [self.turnsProgress setProgress:((float)([farkle.turns integerValue] ) / 10) animated:YES];
}

#pragma mark Toggle Controls

- (void)shakeView {

    CAKeyframeAnimation * anim = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
    anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(50.0f, 0.0f, 0.0f) ] ];
    anim.autoreverses = YES ;
    anim.repeatCount = 1.0f ;
    anim.duration = 0.7f ;
    
    [self.farkleView.layer addAnimation:anim forKey:nil];
}



- (void)hintSlide {
    UIView* view = [self.view viewWithTag:100];
    [UIView animateWithDuration:3.0
                          delay:0.4
                        options: UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGRect frame = view.frame;
                         frame.origin.y = 0;
                         frame.origin.x = (100);
                         view.frame = frame;
                        } completion:nil];
}

- (void)delayedToggleNavBar {
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(toggleNavBar)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)toggleNavBar {
    Farkle *farkle = [Farkle sharedManager];
    
    // not working correctly
    
 //   NSLog(@"isNewGame: %@", farkle.isNewGame);
    
    if ([farkle isNewGame] || [farkle isGameOver]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)togglePassButton {
    
    Farkle *farkle = [Farkle sharedManager];
    
    if ([farkle canPass]) {
        [self enablePassButton];
    } else [self disablePassButton];
}

- (void)toggleRollButton {
    
    Farkle *farkle = [Farkle sharedManager];
    
    if ([farkle canRoll]) {
        [self enableRollButton];
    } else [self disableRollButton];
}

#pragma mark iAd Delegate Methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
        [self enableBannerView:banner];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    if (isBannerVisible) {
        [self disableBannerView:banner];
    }
}

- (void)enableBannerView:(ADBannerView *)banner {
    Farkle *farkle = [Farkle sharedManager];
    // Only show the ad if it's invisible, the game is over, and the ad is loaded
    if ( (!isBannerVisible) && (farkle.isGameOver) && (bannerAd.isBannerLoaded) )
    {
        [UIView beginAnimations:Nil context:nil];
        [UIView setAnimationDuration:1];
        [banner setAlpha:1];
    [UIView commitAnimations];
    }
}

- (void)disableBannerView:(ADBannerView *)banner {
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}
/*
- (void)loadSound {
    self.alarmSoundPlayer = [[AVAudioPlayer alloc]
                             initWithContentsOfURL:[[NSBundle mainBundle]
                                                    URLForResource:@"alarm"
                                                    withExtension:@"caf"]
                             error:0];

}
*/
/*
#pragma mark Shake to RageQuit

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        // User was shaking the device. Post a notification named "shake."
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:@"Quit Current Game?"
                                                        otherButtonTitles:nil];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self];
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];

    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self clearDice];
        [self hideDice];
        [self disableDice];
        [self gameOver];
        [self newGame];
    }
}
*/

#pragma mark check settings

- (void)checkSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    iap = [defaults boolForKey:@"iap"];
    sounds = [defaults boolForKey:@"sounds"];
}

- (void)runSpinAnimationWithDuration:(CGFloat) duration;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 1 * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1.0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.gamePlayView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)swipeForMenuAnimation {
    [UIView animateWithDuration:3.0
                          delay:0.0 // otherwise we will see disabled die flip
                        options: UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAutoreverse
                     animations:^{
//                         self.swipeForMenu.alpha = 1.0;
                         self.swipeForMenu.alpha = 1.0;
                     }
                     completion:nil];
}

-(IBAction)userPressedBounceButton:(id)sender {
    [self.delegate contentViewControllerDidPressBounceButton:self];
}

// This doesn't appear to work, hmm...
- (void)hintMenu {
    Farkle *farkle = [Farkle sharedManager];
    if ( (farkle.isGameOver) || (farkle.isNewGame) ){
        TLContainmentViewController *containment = [[TLContainmentViewController alloc] init];
        [containment bounceOnAppear];
    }
}

- (IBAction)pressedScore:(id)sender {
    NSLog(@"pressedScore");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hintMenu" object:nil];
}

#pragma mark game center

- (void)reportScore {
    Farkle *farkle = [Farkle sharedManager];
    
    NSInteger myInteger = [farkle.scoreTitle integerValue];
    
    NSLog(@"highscore: %d", myInteger);
    
    [[GameCenterManager sharedManager] saveAndReportScore:myInteger leaderboard:@"com.kernjackson.most.points.solitaire.defaults" sortOrder:GameCenterSortOrderHighToLow];
    
}

@end
