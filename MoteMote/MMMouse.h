//
//  MMMouse.h
//  GyroMouseTest
//
//  Created by Cameron Ehrlich on 5/31/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface MMMouse : NSObject

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (assign) double xAxis;
@property (assign) double yAxis;

- (void)calibrate;

@end
