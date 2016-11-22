//
//  LADDealModel.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADDealModel.h"

@implementation LADDealModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n", self.deal_address, self.deal_cate, self.deal_cate_id, self.deal_desc, self.deal_distance, self.deal_district_name, self.deal_id, self.deal_img, self.deal_lat, self.deal_lng, self.deal_name, self.deal_phones, self.deal_range, self.deal_rating, self.deal_seller, self.deal_subcate, self.deal_subcate_id, self.deal_title, self.deal_url, self.deal_wap_url, self.rebate, self.reservation, self.price, self.sales_num, self.start_time, self.end_time, self.city_name, self.website, self.value];
}

@end
