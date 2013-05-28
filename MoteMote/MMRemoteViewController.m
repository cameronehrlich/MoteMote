//
//  MMRemoteViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/27/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMRemoteViewController.h"

@implementation MMRemoteViewController

- (IBAction)servers:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:sender.titleLabel.text sender:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
