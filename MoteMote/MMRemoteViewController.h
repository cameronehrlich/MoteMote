//
//  MMRemoteViewController.h
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/27/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMModel.h"

#define ITUNES 0
#define QUICKTIME 1
#define SAFARI 2
#define VLC 3
#define SPOTIFY 4
#define CUSTOM 5


@interface MMRemoteViewController : UIViewController

- (IBAction)servers:(id)sender;
- (IBAction)buttonPressed:(id)sender;
- (IBAction)singleTap:(id)sender;

@end
