//
//  LADAppService.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADAppService.h"
#import <AFNetworking.h>
#define SERVICE_API @"http://api.union.meituan.com/data/api?key=GADfHn74Ct8mq6iwPWQBjZdl25LYE3NX"

//typedef NS_ENUM(NSInteger, kCategory) {
//    
//};

@interface LADAppService ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation LADAppService

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];

        AFXMLParserResponseSerializer *serializer = [[AFXMLParserResponseSerializer alloc] init];
        _manager.responseSerializer = serializer;
    }
    return _manager;
}

- (void)getXMLFromServiceWithLocation:(CLLocation *)location withRadius:(NSNumber *)radius withOffset:(NSNumber *)offset withLimit:(NSNumber *)limit withCategory:(NSString *)category withComepeletionHandler:(LADAppServiceBlock)handler
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"lat"] = @(location.coordinate.latitude);
    dict[@"lon"] = @(location.coordinate.longitude);
    dict[@"radius"] = radius;
    dict[@"offset"] = offset;
    dict[@"limit"] = limit;
    dict[@"category"] = category;
    
    [self.manager GET:SERVICE_API parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        handler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)getXMLFromServiceWithLocation:(CLLocation *)location withCategory:(NSString *)category withOffset:(NSNumber *)offset withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:offset withLimit:@(20) withCategory:category withComepeletionHandler:handler];
}

- (void)getFoodXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"西餐火锅自助餐烧烤湖北菜川湘菜" withComepeletionHandler:handler];
}

- (void)getDrinkXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"甜点饮品" withComepeletionHandler:handler];
}

- (void)getPlayXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"休闲娱乐" withComepeletionHandler:handler];
}

- (void)getBarXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"酒吧咖啡" withComepeletionHandler:handler];
}

- (void)getBathXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"洗浴" withComepeletionHandler:handler];
}

- (void)getEscapeXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"密室逃脱" withComepeletionHandler:handler];
}

- (void)getGameXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"桌游/电玩" withComepeletionHandler:handler];
}

- (void)getGymXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"健身" withComepeletionHandler:handler];
}

- (void)getKTVXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"KTV" withComepeletionHandler:handler];
}

- (void)getMassageXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"按摩" withComepeletionHandler:handler];
}

- (void)getMovieXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler
{
    [self getXMLFromServiceWithLocation:location withRadius:@(10) withOffset:@(0) withLimit:@(20) withCategory:@"电影" withComepeletionHandler:handler];
}

@end
