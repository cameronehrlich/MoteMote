//
//  MMModel.h
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#define DATA_LENGTH 200

@interface MMModel : NSObject <NSNetServiceBrowserDelegate, NSNetServiceDelegate>

@property (nonatomic, strong) NSNetServiceBrowser *netServiceBrowser;
@property (nonatomic, strong) NSNetService *serverService;
@property (nonatomic, strong) NSMutableArray *offeredServices;
@property (nonatomic, strong) GCDAsyncSocket *asyncSocket;

+ (id) sharedModel;

- (void) sendCommand: (NSDictionary *) dict;
- (void) reloadBonjour;
- (void) connectToNetService:(NSNetService *)netService;
- (NSString *) humanizedNameForService:(NSNetService *)service;


@end
