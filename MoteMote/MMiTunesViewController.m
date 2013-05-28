//
//  MMiTunesViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/28/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMiTunesViewController.h"

@implementation MMiTunesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backToRemotes:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)activate:(id)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":@"iTunes", @"command":@"activate"}];
}

- (IBAction)playPause:(id)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":@"iTunes", @"command":@"playpause"}];
}

- (IBAction)previous:(id)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":@"iTunes", @"command":@"previous track"}];
}

- (IBAction)next:(id)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":@"iTunes", @"command":@"next track"}];
}

- (IBAction)volume:(UISlider *)sender {
    NSString *commandString = [NSString stringWithFormat:@"set volume output volume %f", sender.value];
    [[MMModel sharedModel] sendCommand:@{@"application":@"System Events",@"command":commandString}];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *commandString = [NSString stringWithFormat:@"play track \"%@\"", trimmedString];
    [[MMModel sharedModel] sendCommand:@{@"application":@"iTunes", @"command": commandString}];
    [textField resignFirstResponder];
    return YES;
}

@end
