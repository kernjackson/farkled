//
//  MenuTestViewController.m
//  farkled
//
//  Created by Kern Jackson on 1/7/14.
//  Copyright (c) 2014 Kern Jackson. All rights reserved.
//

#import "MenuTestViewController.h"

@interface MenuTestViewController ()

@end

@implementation MenuTestViewController

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

- (IBAction)dismissButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
