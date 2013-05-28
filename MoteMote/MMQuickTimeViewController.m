//
//  MMQuickTimeViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/28/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMQuickTimeViewController.h"


@implementation MMQuickTimeViewController {
    bool playPause;
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

- (IBAction)backToRemotes:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)activate:(id)sender {
    [[MMModel sharedModel] sendCommand:@{@"application":@"QuickTime Player", @"command":@"activate"}];
}

- (IBAction)playPause:(id)sender {
    if (!playPause) {
        [[MMModel sharedModel] sendCommand:@{@"application":@"QuickTime Player", @"command":@"play"}];
    }else{
        [[MMModel sharedModel] sendCommand:@{@"application":@"QuickTime Player", @"command":@"pause"}];
    }
    playPause = !playPause;
}

- (IBAction)volume:(UISlider *)sender {
    NSString *commandString = [NSString stringWithFormat:@"set volume output volume %f", sender.value];
    [[MMModel sharedModel] sendCommand:@{@"application":@"System Events",@"command":commandString}];
}
@end
