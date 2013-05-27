//
//  MMViewController.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMViewController.h"

@implementation MMViewController

@synthesize servicesTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MMModel sharedModel];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"reloadTable"
                                               object:nil];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"reloadTable"])
        [servicesTableView reloadData];
}


- (IBAction)reloadTable:(id)sender {
    [servicesTableView reloadData];
}

- (IBAction)play:(UIButton *)sender {
    [[MMModel sharedModel] sendCommand:sender.titleLabel.text];
}
- (IBAction)pause:(UIButton *)sender {
    [[MMModel sharedModel] sendCommand:sender.titleLabel.text];
}
- (IBAction)next:(UIButton *)sender {
    [[MMModel sharedModel] sendCommand:sender.titleLabel.text];
}
- (IBAction)previous:(UIButton *)sender {
    [[MMModel sharedModel] sendCommand:sender.titleLabel.text];
}

- (IBAction)reload:(id)sender {
    [[MMModel sharedModel] reloadBonjour];
}


#pragma mark UITableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSString *serviceName = [(NSNetService *)[[[MMModel sharedModel] offeredServices] objectAtIndex:indexPath.row] hostName];
    
    cell.textLabel.text = serviceName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", [[[[MMModel sharedModel] offeredServices] objectAtIndex:indexPath.row] description]);
    [[MMModel sharedModel] connectToNetService:[[[MMModel sharedModel] offeredServices] objectAtIndex:indexPath.row]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[MMModel sharedModel] offeredServices] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


@end
