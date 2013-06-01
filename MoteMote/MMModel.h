//
//  MMModel.h
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMClient.h"

@interface MMModel : NSObject

@property (nonatomic, retain) MMClient *client;

+ (id) sharedModel;

-(void) sendCommand:(NSDictionary *) dict;

- (NSString *) humanizedNameForService:(NSNetService *)service;


@end
