//
//  MMRemoteViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/27/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMRemoteViewController.h"

#define SPOTIFY 0
#define ITUNES 1
#define VLC 2

@implementation MMRemoteViewController {
    NSString *currentApplication;
}

@synthesize navBar;

@synthesize application;
@synthesize command;

- (IBAction)servers:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}


- (IBAction)play:(UIButton *)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":currentApplication, @"command": @"play"}];
}
- (IBAction)pause:(UIButton *)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":currentApplication, @"command": @"pause"}];
}
- (IBAction)next:(UIButton *)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":currentApplication, @"command": @"next track"}];
}
- (IBAction)previous:(UIButton *)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":currentApplication, @"command": @"previous track"}];
}

- (IBAction)volume:(UISlider *)sender {
    
    NSString *commandString = [NSString stringWithFormat:@"set volume output volume %f", sender.value];
    [[MMModel sharedModel] sendCommand:@{@"application":@"System Events", @"command": commandString}];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar.topItem setTitle:[[MMModel sharedModel] humanizedNameForService:[[MMModel sharedModel] serverService]]];
    currentApplication = @"Spotify";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)runCustomCommand:(id)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":application.text, @"command": command.text}];
}

- (IBAction)applicationChooser:(UISegmentedControl *)sender {
    currentApplication = [self nameOfServiceWithId:sender.selectedSegmentIndex];
    [[MMModel sharedModel] sendCommand:@{@"application":currentApplication, @"command": @"activate"}];
}

- (NSString *) nameOfServiceWithId:(int) serviceId {
    NSString *name;
    switch (serviceId) {
        case SPOTIFY:
            name = @"Spotify";
            break;
        case ITUNES:
            name = @"iTunes";
            break;
        case VLC:
            name = @"VLC";
            break;
        default:
            name = @"Error";
            NSLog(@"Error in nameOfServiceWithId");
            break;
    }
    return name;
}

@end
