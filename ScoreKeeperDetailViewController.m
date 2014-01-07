//
//  ScoreKeeperDetailViewController.m
//  farkled
//
//  Created by Kern Jackson on 1/3/14.
//  Copyright (c) 2014 Kern Jackson. All rights reserved.
//

#import "ScoreKeeperDetailViewController.h"

@interface ScoreKeeperDetailViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *diceButtons;
@property (weak, nonatomic) IBOutlet UIButton *passButton;

@end

@implementation ScoreKeeperDetailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedOne:(id)sender {
    NSLog(@"1");
}

- (IBAction)pressedTwo:(id)sender {
    NSLog(@"2");
}

- (IBAction)pressedThree:(id)sender {
    NSLog(@"3");
}

- (IBAction)pressedFour:(id)sender {
    NSLog(@"4");
}

- (IBAction)pressedFive:(id)sender {
    NSLog(@"5");
}

- (IBAction)pressedSix:(id)sender {
    NSLog(@"6");
}

- (IBAction)pressedBackspace:(id)sender {
    NSLog(@"backspace");
}

- (IBAction)pressedFarkled:(id)sender {
    NSLog(@"farkled");
}

- (IBAction)pressedRolled:(id)sender {
    NSLog(@"rolled");
}

@end
