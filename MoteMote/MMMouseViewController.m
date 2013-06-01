//
//  MMMouseViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/31/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMMouseViewController.h"

@implementation MMMouseViewController

@synthesize thisClient;
@synthesize mouse;

- (void)viewDidLoad
{
    [super viewDidLoad];
    thisClient = [[MMModel sharedModel] client];
    mouse = [[MMMouse alloc] init];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateMouse {
    NSString *x = [NSString stringWithFormat:@"%f", ([mouse xAxis] * 1440)];
    NSString *y = [NSString stringWithFormat:@"%f", ([mouse yAxis] * 1000)];
    [thisClient sendObject:@{@"x": x, @"y":y}];
}

- (IBAction)send:(id)sender {
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateMouse) userInfo:nil repeats:YES];
}

- (IBAction)openConnection:(id)sender {
    if ([[thisClient services] count] >= 1) {
        bool connected = [thisClient connectTo:[[thisClient services] objectAtIndex:0]]; //[[client services] objectAtIndexPath:indexPath.row]
        if (connected) {
            NSLog(@"Opened connection successfully");
            return;
        }
    }
    NSLog(@"Unable to open a connection =(");
}

- (IBAction)calibrate:(id)sender {
    [mouse calibrate];
}
@end
