//
//  LADLocation.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/14.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADLocation.h"


@interface LADLocation () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;


@end

@implementation LADLocation

- (CLLocationManager *)manager
{
    if (!_manager) {
        if ([CLLocationManager locationServicesEnabled]) {
            _manager = [[CLLocationManager alloc] init];
            _manager.delegate = self;
            // 精度大约100米
            _manager.desiredAccuracy = kCLLocationAccuracyBest;
            _manager.distanceFilter = 100;
            [_manager requestWhenInUseAuthorization];
            [_manager startUpdatingLocation];
        }
    }
    return _manager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"%@", locations.lastObject);
}

@end
