//
//  MMCustomCommandViewController.h
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/28/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMModel.h"

@interface MMCustomCommandViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *application;
@property (strong, nonatomic) IBOutlet UITextField *command;

- (IBAction)backToRemotes:(id)sender;
- (IBAction)send:(id)sender;

@end
