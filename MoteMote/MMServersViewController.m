//
//  MMViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMServersViewController.h"

@implementation MMServersViewController

@synthesize servicesTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MMModel sharedModel];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"reloadTable"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"reloadTable"])
        [servicesTableView reloadData];
}



- (IBAction)reload:(id)sender {
    [[MMModel sharedModel] reloadBonjour];
    [servicesTableView reloadData];

}


#pragma mark UITableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
    [cell.textLabel setText:[[MMModel sharedModel] humanizedNameForService:(NSNetService *)[[[MMModel sharedModel] offeredServices] objectAtIndex:indexPath.row]]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", [[[[MMModel sharedModel] offeredServices] objectAtIndex:indexPath.row] description]);
    [[MMModel sharedModel] connectToNetService:[[[MMModel sharedModel] offeredServices] objectAtIndex:indexPath.row]];
    [self performSegueWithIdentifier:@"remote" sender:self];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[MMModel sharedModel] offeredServices] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"remote"]) {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


@end
