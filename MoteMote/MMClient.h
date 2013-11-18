//
//  MMClient.h
//  NetworkingTest
//
//  Created by Cameron Ehrlich on 5/31/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "DTBonjourServer.h"
#import "DTBonjourDataConnection.h"
#import "DTBonjourDataChunk.h"

@interface MMClient : NSObject <DTBonjourDataConnectionDelegate, NSNetServiceBrowserDelegate, NSNetServiceDelegate>

@property (nonatomic, strong) NSNetServiceBrowser *browser;
@property (nonatomic, strong) NSMutableArray *services;
@property (nonatomic, strong) DTBonjourDataConnection *connection;

- (void)connectTo:(NSNetService *) service;
- (void)sendObject:(id) object;
- (void)searchForServers;

@end
