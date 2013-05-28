//
//  MMSpotifyViewController.h
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/28/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMModel.h"

@interface MMSpotifyViewController : UIViewController
- (IBAction)backToRemotes:(id)sender;
- (IBAction)activate:(id)sender;
- (IBAction)playPause:(id)sender;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)volume:(id)sender;

@end
