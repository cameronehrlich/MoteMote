//
//  MMRemoteViewController.h
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/27/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMModel.h"

@interface MMRemoteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *application;
@property (weak, nonatomic) IBOutlet UITextField *command;


@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
- (IBAction)runCustomCommand:(id)sender;

- (IBAction)applicationChooser:(id)sender;
- (IBAction)servers:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;
- (IBAction)volume:(id)sender;

@end
