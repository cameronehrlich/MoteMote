//
//  MMViewController.h
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMModel.h"

@interface MMServersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *servicesTableView;

- (IBAction)reload:(id)sender;

@end
