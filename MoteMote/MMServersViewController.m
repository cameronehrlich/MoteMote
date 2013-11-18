//
//  MMViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMServersViewController.h"

@implementation MMServersViewController {
    MMClient *theClient;
}


@synthesize servicesTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [MMModel sharedModel];
    theClient = (MMClient *)[[MMModel sharedModel] client];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"reloadTable"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"reloadTable"]){
        [servicesTableView reloadData];
    }
}



- (IBAction)reload:(id)sender {
    [[MMModel sharedModel] refreshServices];
    [servicesTableView reloadData];
}


#pragma mark UITableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
    [cell.textLabel setText:[MMModel humanizedNameForService:[[theClient services] objectAtIndex:indexPath.row]]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [theClient connectTo:[[theClient services] objectAtIndex:indexPath.row]];
    [self performSegueWithIdentifier:@"remote" sender:self];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [theClient services].count;
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
