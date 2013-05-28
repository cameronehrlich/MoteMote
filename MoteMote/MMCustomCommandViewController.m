//
//  MMCustomCommandViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/28/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMCustomCommandViewController.h"

@implementation MMCustomCommandViewController

@synthesize application;
@synthesize command;

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

- (IBAction)backToRemotes:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)send:(id)sender {
    [self sendCommand];
    [application resignFirstResponder];
    [command resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendCommand];
    [application resignFirstResponder];
    [command resignFirstResponder];
    return YES;
}

-(void) sendCommand {
    NSString *appTrimmed = [application.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *comTrimmed = [command.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [[MMModel sharedModel] sendCommand:@{@"application": appTrimmed, @"command": comTrimmed }];
}

@end
