//
//  LADDealModel.h
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LADDealModel : NSObject
/**
 *  项目标题
 */
@property (nonatomic, copy) NSString *deal_title;
/**
 *  销量
 */
@property (nonatomic, copy) NSString *sales_num;
/**
 *  项目名称
 */
@property (nonatomic, copy) NSString *deal_name;
/**
 *  商圈名称
 */
@property (nonatomic, copy) NSString *deal_range;
/**
 *  是否需要预约
 */
@property (nonatomic, copy) NSString *reservation;
/**
 *  商家品牌
 */
@property (nonatomic, copy) NSString *deal_seller;
/**
 *  项目主图地址（图像尺寸可调）
 */
@property (nonatomic, copy) NSString *deal_img;
/**
 *  商家地址
 */
@property (nonatomic, copy) NSString *deal_address;
/**
 *  商家地址
 */
@property (nonatomic, copy) NSString *deal_desc;
/**
 *  品类名称
 */
@property (nonatomic, copy) NSString *deal_cate;
/**
 *  项目i版地址（H5页面）
 */
@property (nonatomic, copy) NSString *deal_wap_url;
/**
 *  项目所在城市名
 */
@property (nonatomic, copy) NSString *city_name;
/**
 *  项目与所在地距离（KM）
 */
@property (nonatomic, copy) NSString *deal_distance;
/**
 *  细分品类名称
 */
@property (nonatomic, copy) NSString *deal_subcate;
/**
 *  经度
 */
@property (nonatomic, copy) NSString *deal_lng;
/**
 *  网站名称（美团网）
 */
@property (nonatomic, copy) NSString *website;
/**
 *  细分品类id
 */
@property (nonatomic, copy) NSString *deal_subcate_id;
/**
 *  评分
 */
@property (nonatomic, copy) NSString *deal_rating;
/**
 *  区域名称（多poi单每个区域间逗号隔开，下同）
 */
@property (nonatomic, copy) NSString *deal_district_name;
/**
 *  纬度
 */
@property (nonatomic, copy) NSString *deal_lat;
/**
 *  原价
 */
@property (nonatomic, copy) NSString *value;
/**
 *  项目开始时间
 */
@property (nonatomic, copy) NSString *start_time;
/**
 *  商家电话
 */
@property (nonatomic, copy) NSString *deal_phones;
/**
 *  项目结束时间
 */
@property (nonatomic, copy) NSString *end_time;
/**
 *  美团价
 */
@property (nonatomic, copy) NSString *price;
/**
 *  项目编号
 */
@property (nonatomic, copy) NSString *deal_id;
/**
 *  项目主站地址
 */
@property (nonatomic, copy) NSString *deal_url;
/**
 *  品类id
 */
@property (nonatomic, copy) NSString *deal_cate_id;
/**
 *  折扣
 */
@property (nonatomic, copy) NSString *rebate;

@end
