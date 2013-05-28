//
//  MMModel.m
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMModel.h"

static NSString *serviceType = @"_motemote._tcp.";
static NSString *serviceDomain = @"local.";

@implementation MMModel

@synthesize netServiceBrowser;
@synthesize offeredServices;
@synthesize serverService;
@synthesize asyncSocket;

+ (id)sharedModel {
    static MMModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        [self reloadBonjour];
    }
    return self;
}

- (void) sendCommand: (NSDictionary *) dict {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {NSLog(@"JSON ERROR: %@", error);}
    
    NSString *commandString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Sending: %@", commandString);

    NSString *pad = [[NSString string] stringByPaddingToLength:(DATA_LENGTH - [commandString length])
                                                       withString:@" "
                                                  startingAtIndex:0];
    
    NSString *paddedCommandString = [NSString stringWithFormat:@"%@%@", commandString, pad];
    
	NSData *finalData = [paddedCommandString dataUsingEncoding:NSUTF8StringEncoding];
    
    [[[MMModel sharedModel] asyncSocket] writeData:finalData withTimeout:10 tag:0];
}

- (void) connectToNetService:(NSNetService *)netService {
    if ([[netService type] isEqualToString:serviceType]) {
        
        NSData * addr = [[netService addresses] objectAtIndex:0];
        NSLog(@"Attempting connection to %@", addr);
        
        asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSError *err = nil;
        if (![asyncSocket connectToAddress:addr error:&err]) {
            NSLog(@"Unable to connect: %@", err);
        }
	}
}

- (NSString *) humanizedNameForService:(NSNetService *)service {
    NSString *connectedToText = [[service hostName] stringByReplacingOccurrencesOfString:@".local." withString:@""];
    return connectedToText;
}

- (void) reloadBonjour {
    NSLog(@"%@", offeredServices.description);
    offeredServices = nil;
    serverService = nil;
    asyncSocket = nil;
    offeredServices = [NSMutableArray new];
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    netServiceBrowser = [[NSNetServiceBrowser alloc] init];
    [netServiceBrowser setDelegate:self];
    [netServiceBrowser searchForServicesOfType:serviceType inDomain:serviceDomain];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)sender didNotSearch:(NSDictionary *)errorInfo{
	NSLog(@"DidNotSearch: %@", errorInfo);
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)sender didFindService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing {

	NSLog(@"DidFindService: %@", [netService name]);
    
	if ([[netService type] isEqualToString:serviceType]){
		NSLog(@"Resolving...");
        [offeredServices addObject:netService];
		serverService = netService;
		[serverService setDelegate:self];
		[serverService resolveWithTimeout:10.0];
	}
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
}


- (void)netServiceDidResolveAddress:(NSNetService *)sender {
	NSLog(@"DidResolve: %@", [sender addresses]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)sender didRemoveService:(NSNetService *)netService moreComing:(BOOL) moreServicesComing {
	NSLog(@"DidRemoveService: %@", [netService name]);
    if ([offeredServices containsObject:netService]) {
        [offeredServices removeObject:netService];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
    }
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
    NSLog(@"DidStopSearch");
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict {
	NSLog(@"DidNotResolve");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];

}


# pragma mark GCDAsyncSocket Delegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
	NSLog(@"Socket:DidConnectToHost: %@ Port: %hu", host, port);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
	NSLog(@"SocketDidDisconnect:WithError: %@", err);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
    [self connectToNetService:serverService];
}


@end
