//
//  MMModel.m
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMModel.h"

@implementation MMModel

@synthesize client;

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
        client = [[MMClient alloc] init];
        [client searchForServers];
    }
    return self;
}

-(void) sendCommand:(NSDictionary *) dict{
    
}

-(NSString *) humanizedNameForService:(NSNetService *)service {
    NSString *connectedToText = [[service hostName] stringByReplacingOccurrencesOfString:@".local." withString:@""];
    return connectedToText;
}



@end
