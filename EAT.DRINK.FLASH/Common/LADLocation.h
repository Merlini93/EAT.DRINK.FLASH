//
//  LADLocation.h
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/14.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LADLocationBlock)(CLLocation *location);
@interface LADLocation : NSObject

@property (nonatomic, copy) LADLocationBlock block;

@end
