//
//  MMMouseViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/31/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMMouseViewController.h"

@implementation MMMouseViewController{
    NSTimer *timer;
    MMClient *thisClient;
}

@synthesize mouse;

- (void)viewDidLoad
{
    [super viewDidLoad];
    thisClient = (MMClient *)[[MMModel sharedModel] client];
    mouse = [[MMMouse alloc] init];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(updateMouse) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void) updateMouse {
    NSString *x = [NSString stringWithFormat:@"%f", ([mouse xAxis] * 1440)];
    NSString *y = [NSString stringWithFormat:@"%f", ([mouse yAxis] * 1000)];
    [thisClient sendObject:@{@"type": @"mouseMove", @"x": x, @"y":y}];
}
- (IBAction)rightClick:(id)sender {
    [thisClient sendObject:@{@"type":@"mouseClick", @"button": @"right"}];
}

- (IBAction)click:(UITapGestureRecognizer *)sender {
    [thisClient sendObject:@{@"type":@"mouseClick", @"button": @"left"}];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [timer invalidate];
}

- (IBAction)calibrate:(id)sender {
    [mouse calibrate];
}
@end
