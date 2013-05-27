//
//  MMModel.h
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@interface MMModel : NSObject <NSNetServiceBrowserDelegate, NSNetServiceDelegate>

@property (nonatomic, strong) NSNetServiceBrowser *netServiceBrowser;
@property (nonatomic, strong) NSNetService *serverService;
@property (nonatomic, strong) NSMutableArray *offeredServices;
@property (nonatomic, strong) GCDAsyncSocket *asyncSocket;

+ (id) sharedModel;

- (void) sendCommand: (NSString *) string;
- (void) reloadBonjour;
- (void) connectToNetService:(NSNetService *)netService;

@end
