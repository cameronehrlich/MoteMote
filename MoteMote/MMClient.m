//
//  MMClient.m
//  NetworkingTest
//
//  Created by Cameron Ehrlich on 5/31/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMClient.h"

static NSString *_serviceType = @"_motemote._tcp.";
static NSString *_domain = @"local.";
static int _timeout = 20;

@implementation MMClient

@synthesize services;
@synthesize browser;
@synthesize connection;

- (id)init
{
    self = [super init];
    if (self) {
        [self searchForServers];
    }
    return self;
}

#pragma mark Class Methods

- (void) connectTo:(NSNetService *) service {
    connection = [[DTBonjourDataConnection alloc] initWithService:service];
    [connection setDelegate:self];
    [connection open];
}


- (void)sendObject:(id) object{
    NSError *error;
    [connection sendObject:object error:&error];
    if(error){
        NSLog(@"Error sending object : %@", error);
    }
}

-(void)searchForServers {
    services = [NSMutableArray new];
    browser = [[NSNetServiceBrowser alloc] init];
    [browser setDelegate:self];
    [browser searchForServicesOfType:_serviceType inDomain:_domain];
}

#pragma mark NSNetServiceBrowser Delegate methods

-(void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
    [aNetService startMonitoring];
    [aNetService setDelegate:self];
    [aNetService resolveWithTimeout:_timeout];
    if ([aNetService.domain isEqualToString:_domain]) {
        [services addObject:aNetService];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
    }
}

-(void)netServiceDidResolveAddress:(NSNetService *)sender{
    NSLog(@"Resolved: %@", sender.hostName);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
}

-(void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict{
    NSLog(@"Unable to resolve with errors: %@", errorDict.description);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
    NSLog(@"Service removed : %@", aNetService.hostName);
    [services removeObject:aNetService];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
}

#pragma mark DTBonjourDataConnectionDelegate

-(void)connection:(DTBonjourDataConnection *)connection didReceiveObject:(id)object{
}

-(void)connectionDidClose:(DTBonjourDataConnection *)connection{
}

-(void)connection:(DTBonjourDataConnection *)connection willStartSendingChunk:(DTBonjourDataChunk *)chunk{
}

-(void)connection:(DTBonjourDataConnection *)connection willStartReceivingChunk:(DTBonjourDataChunk *)chunk{
}

-(void)connection:(DTBonjourDataConnection *)connection didFinishSendingChunk:(DTBonjourDataChunk *)chunk{
}

-(void)connection:(DTBonjourDataConnection *)connection didFinishReceivingChunk:(DTBonjourDataChunk *)chunk{
}

@end
