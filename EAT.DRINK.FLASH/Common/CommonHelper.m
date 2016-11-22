//
//  CommonHelper.m
//  TestDownload
//
//  Created by wangliang on 16/3/2.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import "CommonHelper.h"

@implementation CommonHelper
+(NSString *)getByteString:(long long)bytes{
    if (bytes < 1024) {
        return [NSString stringWithFormat:@"%lldB", bytes];
    }else if (bytes < 1024 * 1024){
        return [NSString stringWithFormat:@"%.1lfK", bytes / 1024.0];
    }else if (bytes < 1024 * 1024 * 1024){
        return [NSString stringWithFormat:@"%.2lfM", bytes / (1024 * 1024.0)];
    }else{
        return [NSString stringWithFormat:@"%.3lfG", bytes / (1024 * 1024 * 1024.0)];
    }
}
@end
