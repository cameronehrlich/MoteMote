//
//  MMMouse.m
//  GyroMouseTest
//
//  Created by Cameron Ehrlich on 5/31/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMMouse.h"

double _currentYaw = 0;
double _axisXCorrection = 0;
double _currentPitch = 0;
double _axisYCorrection = 0;

@implementation MMMouse

@synthesize motionManager;
@synthesize xAxis;
@synthesize yAxis;


- (id)init
{
    self = [super init];
    if (self) {
        [self setUpMotionManager];
    }
    return self;
}

-(void) setUpMotionManager{
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 0.03;
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        if (error) {
            NSLog(@"ERROR");
        }
        [self handleMotionData:motion];
    }];
}

- (void) calibrate {
    _axisXCorrection = 0 - _currentYaw;
    _axisYCorrection = 0 - _currentPitch;
}

-(void)handleMotionData:(CMDeviceMotion *) motion {
    _currentYaw = motion.attitude.yaw;
    _currentPitch = motion.attitude.pitch;

    xAxis = 0.5 - (_currentYaw + _axisXCorrection);
    yAxis = 0.5 - (_currentPitch + _axisYCorrection);
}


@end
