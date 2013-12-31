//
//  GCTurnBasedMatchHelper.m
//  spinningyarn
//
//  Created by Ray Wenderlich on 10/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "GCTurnBasedMatchHelper.h"

@implementation GCTurnBasedMatchHelper
@synthesize gameCenterAvailable;
@synthesize currentMatch;
@synthesize alternateMatch;
@synthesize delegate;

#pragma mark Initialization

static GCTurnBasedMatchHelper *sharedHelper = nil;
+ (GCTurnBasedMatchHelper *) sharedInstance {
    if (!sharedHelper) {
        sharedHelper = [[GCTurnBasedMatchHelper alloc] init];
    }
    return sharedHelper;
}

- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer     
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (id)init {
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = 
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self 
                   selector:@selector(authenticationChanged) 
                       name:GKPlayerAuthenticationDidChangeNotificationName 
                     object:nil];
        }
    }
    return self;
}

- (void)authenticationChanged {    
    
    if ([GKLocalPlayer localPlayer].isAuthenticated && 
        !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;           
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && 
               userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
    
}

#pragma mark User functions

- (void)authenticateLocalUser {
    
    if (!gameCenterAvailable) return;
    
    void (^setGKEventHandlerDelegate)(NSError *) = ^ (NSError *error){
        GKTurnBasedEventHandler *ev = [GKTurnBasedEventHandler sharedTurnBasedEventHandler];
        
        ev.delegate = self;
    };
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {     
        [[GKLocalPlayer localPlayer]
    //     authenticateHandler];
         authenticateWithCompletionHandler:setGKEventHandlerDelegate];
    } else {
        NSLog(@"Already authenticated!");
        setGKEventHandlerDelegate(nil);
    }
    //[GKTurnBasedMatch loadMatchesWithCompletionHandler:^(NSArray *matches, NSError *error){for (GKTurnBasedMatch *match in matches) { NSLog(@"%@", match.matchID); [match removeWithCompletionHandler:^(NSError *error){NSLog(@"%@", error);}]; }} ]; 
}
/*
- (void) authenticateLocalPlayer {
    self.gameCenterAuthenticationComplete = NO;
    
    if (!isGameCenterAPIAvailable()) {
        // Game Center is not available.
    } else {
        
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        
        /*
         The authenticateWithCompletionHandler method is like all completion handler methods and runs a block
         of code after completing its task. The difference with this method is that it does not release the
         completion handler after calling it. Whenever your application returns to the foreground after
         running in the background, Game Kit re-authenticates the user and calls the retained completion
         handler. This means the authenticateWithCompletionHandler: method only needs to be called once each
         time your application is launched. This is the reason the sample authenticates in the application
         delegate's application:didFinishLaunchingWithOptions: method instead of in the view controller's
         viewDidLoad method.
         
         Remember this call returns immediately, before the user is authenticated. This is because it uses
         Grand Central Dispatch to call the block asynchronously once authentication completes.
         */
/*
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
            // If there is an error, do not assume local player is not authenticated.
            if (localPlayer.isAuthenticated) {
                
                // Enable Game Center Functionality
                self.gameCenterAuthenticationComplete = YES;
                
                if (! self.currentPlayerID || ! [self.currentPlayerID isEqualToString:localPlayer.playerID]) {
                    
                    // Switching Users
                    if (!mainViewController.player || ![self.currentPlayerID isEqualToString:localPlayer.playerID]) {
                        // If there is an existing player, replace the existing PlayerModel object with a
                        // new object, and use it to load the new player's saved achievements.
                        // It is not necessary for the previous PlayerModel object to writes its data first;
                        // It automatically saves the changes whenever its list of stored
                        // achievements changes.
                        
                    }
                    [[mainViewController player] loadStoredScores];
                    [[mainViewController player] resubmitStoredScores];
                    
                    // Load new game instance around new player being logged in.
                    
                }
                [mainViewController enableGameCenter:YES];
            } else {
                // User has logged out of Game Center or can not login to Game Center, your app should run
				// without GameCenter support or user interface.
                self.gameCenterAuthenticationComplete = NO;
                [self.mainViewController enableGameCenter:NO];
            }
        }];
    }
 */
    /*
	 A quick reminder that at this point the user still hasn't been authenticated
	 until the Completion Hander block is called.
	 */
/*
    return YES;
}
*/
/*
- (void) authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
        if (localPlayer.isAuthenticated)
        {
            // Player was successfully authenticated.
            // Perform additional tasks for the authenticated player.
        }
    }];
}
*/
/*
- (void) authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil)
        {
            //showAuthenticationDialogWhenReasonable: is an example method name. Create your own method that displays an authentication view when appropriate for your app.
            [self showAuthenticationDialogWhenReasonable: viewController];
        }
        else if (localPlayer.isAuthenticated)
        {
            //authenticatedPlayer: is an example method name. Create your own method that is called after the loacal player is authenticated.
            NSLog(@"authenticated");
//            [self authenticatedPlayer: localPlayer];
        }
        else
        {
            NSLog(@"disableGameCenter");
            //[self disableGameCenter];
        }
    }];
}
*/

#pragma mark experimenting

- (void)showGameCenter
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
   //     [self presentViewController: gameCenterController animated: YES completion:nil];
        
    }
}

- (void)presentViewController {
    
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark GKLeaderBoardController?

-(void)leaderBoardController: (GKTurnBasedMatchmakerViewController *)viewController didFindMatch:(GKTurnBasedMatch *)match {
    for (GKTurnBasedParticipant *part in match.participants) {
        NSLog(@"%@ part outcome %d, part status %d, game status %d", part.playerID, part.matchOutcome, part.status, match.status);
    }
    
    [presentingViewController dismissModalViewControllerAnimated:YES];
    self.currentMatch = match;
    GKTurnBasedParticipant *firstParticipant = [match.participants objectAtIndex:0];
    if (firstParticipant.lastTurnDate == NULL) {
        // It's a new game!
        [delegate enterNewGame:match];
    } else {
        if ([match.currentParticipant.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
            // It's your turn!
            [delegate takeTurn:match];
        } else {
            // It's not your turn, just display the game state.
            [delegate layoutMatch:match];
        }
    }
}


- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController {
    if (!gameCenterAvailable) return;               
    
    presentingViewController = viewController;
    
    GKMatchRequest *request = [[GKMatchRequest alloc] init]; 
    request.minPlayers = minPlayers;     
    request.maxPlayers = maxPlayers;
    
    GKTurnBasedMatchmakerViewController *mmvc = [[GKTurnBasedMatchmakerViewController alloc] initWithMatchRequest:request];    
    mmvc.turnBasedMatchmakerDelegate = self;
    mmvc.showExistingMatches = YES;
    
    [presentingViewController presentModalViewController:mmvc animated:YES];
}

#pragma mark GKTurnBasedMatchmakerViewControllerDelegate

-(void)turnBasedMatchmakerViewController: (GKTurnBasedMatchmakerViewController *)viewController didFindMatch:(GKTurnBasedMatch *)match {
    for (GKTurnBasedParticipant *part in match.participants) {
        NSLog(@"%@ part outcome %d, part status %d, game status %d", part.playerID, part.matchOutcome, part.status, match.status);
    }
    [presentingViewController dismissModalViewControllerAnimated:YES];
    self.currentMatch = match;
    GKTurnBasedParticipant *firstParticipant = [match.participants objectAtIndex:0];
    if (firstParticipant.lastTurnDate == NULL) {
        // It's a new game!
        [delegate enterNewGame:match];
    } else {
        if ([match.currentParticipant.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
            // It's your turn!
            [delegate takeTurn:match];
        } else {
            // It's not your turn, just display the game state.
            [delegate layoutMatch:match];
        }        
    }
}

-(void)turnBasedMatchmakerViewControllerWasCancelled: (GKTurnBasedMatchmakerViewController *)viewController {
    [presentingViewController dismissModalViewControllerAnimated:YES];
    NSLog(@"has cancelled");
}

- (void)leaderboardViewControllerDidFinish:(GKGameCenterViewController *)viewController
{
    [presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)achievementViewControllerDidFinish:(GKGameCenterViewController *)viewController;
{
    [presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)turnBasedMatchmakerViewController: (GKTurnBasedMatchmakerViewController *)viewController didFailWithError:(NSError *)error {
    [presentingViewController dismissModalViewControllerAnimated:YES];
    NSLog(@"Error finding match: %@", error.localizedDescription);
}

-(void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController playerQuitForMatch:(GKTurnBasedMatch *)match {
    NSUInteger currentIndex = [match.participants indexOfObject:match.currentParticipant];
    GKTurnBasedParticipant *part;
    
    for (int i = 0; i < [match.participants count]; i++) {
        part = [match.participants objectAtIndex:(currentIndex + 1 + i) % match.participants.count];
        if (part.matchOutcome != GKTurnBasedMatchOutcomeQuit) {
            break;
        } 
    }
    NSLog(@"playerquitforMatch, %@, %@", match, match.currentParticipant);

    [match participantQuitInTurnWithOutcome:GKTurnBasedMatchOutcomeQuit nextParticipant:part matchData:match.matchData completionHandler:nil];
}

#pragma mark GKTurnBasedEventHandlerDelegate

-(void)handleInviteFromGameCenter:(NSArray *)playersToInvite {
    [presentingViewController dismissModalViewControllerAnimated:YES];
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.playersToInvite = playersToInvite;
    request.maxPlayers = 12;
    request.minPlayers = 2;
    GKTurnBasedMatchmakerViewController *viewController =
    [[GKTurnBasedMatchmakerViewController alloc] initWithMatchRequest:request];
    viewController.showExistingMatches = NO;
    viewController.turnBasedMatchmakerDelegate = self;
    [presentingViewController presentModalViewController:viewController animated:YES];
}

-(void)handleTurnEventForMatch:(GKTurnBasedMatch *)match {
    NSLog(@"Turn has happened");
    if ([match.matchID isEqualToString:currentMatch.matchID]) {
        if ([match.currentParticipant.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
            // it's the current match and it's our turn now
            self.currentMatch = match;
            [delegate takeTurn:match];
        } else {
            // it's the current match, but it's someone else's turn
            self.currentMatch = match;
            [delegate layoutMatch:match];
        }
    } else {
        if ([match.currentParticipant.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
            // it's not the current match and it's our turn now
            [delegate sendNotice:@"It's your turn for another match" forMatch:match];
        } else {
            // it's the not current match, and it's someone else's turn
        }
    }
}

-(void)handleMatchEnded:(GKTurnBasedMatch *)match {
    NSLog(@"Game has ended");
    if ([match.matchID isEqualToString:currentMatch.matchID]) {
        [delegate recieveEndGame:match];
    } else {
        [delegate sendNotice:@"Another Game Ended!" forMatch:match];
    }
}

@end
