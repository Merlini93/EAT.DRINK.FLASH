//
//  LADAppService.h
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LADAppServiceBlock)(id data);
@interface LADAppService : NSObject

/**
 *  返回食物信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getFoodXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回饮品信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getDrinkXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回休闲娱乐信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getPlayXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回按摩信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getMassageXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回洗浴信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getBathXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回KTV信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getKTVXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回酒吧信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getBarXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回电玩信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getGameXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回电影信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getMovieXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回密室逃脱信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getEscapeXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  返回健身信息XML
 *
 *  @param location 定位信息
 *  @param handler  服务器返回数据处理
 */
- (void)getGymXMLFromServiceWithLocation:(CLLocation *)location withCompeletionHandler:(LADAppServiceBlock)handler;

/**
 *  根据偏移量返回XML信息
 *
 *  @param location 定位信息
 *  @param offset   偏移量
 *  @param handler  服务器返回数据处理
 */
- (void)getXMLFromServiceWithLocation:(CLLocation *)location withCategory:(NSString *)category withOffset:(NSNumber *)offset withCompeletionHandler:(LADAppServiceBlock)handler;

@end
