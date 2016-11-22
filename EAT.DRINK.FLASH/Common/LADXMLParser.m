//
//  LADXMLParser.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/14.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADXMLParser.h"
#import "LADDealModel.h"

@interface LADXMLParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSString *tempString;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *website_Array;
@property (nonatomic, strong) NSMutableArray *deal_id_Array;
@property (nonatomic, strong) NSMutableArray *deal_title_Array;
@property (nonatomic, strong) NSMutableArray *reservation_Array;
@property (nonatomic, strong) NSMutableArray *deal_url_Array;
@property (nonatomic, strong) NSMutableArray *deal_wap_url_Array;
@property (nonatomic, strong) NSMutableArray *deal_img_Array;
@property (nonatomic, strong) NSMutableArray *deal_cate_id_Array;
@property (nonatomic, strong) NSMutableArray *deal_cate_Array;
@property (nonatomic, strong) NSMutableArray *deal_subcate_id_Array;
@property (nonatomic, strong) NSMutableArray *deal_subcate_Array;
@property (nonatomic, strong) NSMutableArray *deal_rating_Array;
@property (nonatomic, strong) NSMutableArray *deal_seller_Array;
@property (nonatomic, strong) NSMutableArray *value_Array;
@property (nonatomic, strong) NSMutableArray *price_Array;
@property (nonatomic, strong) NSMutableArray *rebate_Array;
@property (nonatomic, strong) NSMutableArray *sales_num_Array;
@property (nonatomic, strong) NSMutableArray *deal_name_Array;
@property (nonatomic, strong) NSMutableArray *deal_desc_Array;
@property (nonatomic, strong) NSMutableArray *city_name_Array;
@property (nonatomic, strong) NSMutableArray *start_time_Array;
@property (nonatomic, strong) NSMutableArray *end_time_Array;
@property (nonatomic, strong) NSMutableArray *deal_range_Array;
@property (nonatomic, strong) NSMutableArray *deal_district_name_Array;
@property (nonatomic, strong) NSMutableArray *deal_address_Array;
@property (nonatomic, strong) NSMutableArray *deal_phones_Array;
@property (nonatomic, strong) NSMutableArray *deal_distance_Array;
@property (nonatomic, strong) NSMutableArray *deal_lat_Array;
@property (nonatomic, strong) NSMutableArray *deal_lng_Array;

@end

@implementation LADXMLParser

- (NSArray *)getModelArrayWithXMLData:(NSXMLParser *)parser
{
    self.parser = parser;
    self.parser.delegate = self;
    [self.parser parse];
    
    return [self.dataArray copy];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@", parseError);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
//    NSLog(@"开始解析文档");
    
    self.website_Array = [NSMutableArray array];
    self.deal_id_Array = [NSMutableArray array];
    self.deal_title_Array = [NSMutableArray array];
    self.reservation_Array = [NSMutableArray array];
    self.deal_url_Array = [NSMutableArray array];
    self.deal_wap_url_Array = [NSMutableArray array];
    self.deal_img_Array = [NSMutableArray array];
    self.deal_cate_Array = [NSMutableArray array];
    self.deal_cate_id_Array = [NSMutableArray array];
    self.deal_subcate_Array = [NSMutableArray array];
    self.deal_subcate_id_Array = [NSMutableArray array];
    self.deal_rating_Array = [NSMutableArray array];
    self.deal_seller_Array = [NSMutableArray array];
    self.value_Array = [NSMutableArray array];
    self.price_Array = [NSMutableArray array];
    self.rebate_Array = [NSMutableArray array];
    self.sales_num_Array = [NSMutableArray array];
    self.deal_name_Array = [NSMutableArray array];
    self.deal_desc_Array = [NSMutableArray array];
    self.city_name_Array = [NSMutableArray array];
    self.start_time_Array = [NSMutableArray array];
    self.end_time_Array = [NSMutableArray array];
    self.deal_range_Array = [NSMutableArray array];
    self.deal_district_name_Array = [NSMutableArray array];
    self.deal_address_Array = [NSMutableArray array];
    self.deal_phones_Array = [NSMutableArray array];
    self.deal_distance_Array= [NSMutableArray array];
    self.deal_lat_Array = [NSMutableArray array];
    self.deal_lng_Array = [NSMutableArray array];
    
    self.tempString = [NSString string];
    self.dataArray = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
//    NSLog(@"---%@", elementName);
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
//    NSLog(@"===%@", string);
    self.tempString = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"deal_title"]) {
        [self.deal_title_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"sales_num"]) {
        [self.sales_num_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_name"]) {
        [self.deal_name_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_range"]) {
        [self.deal_range_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"reservation"]) {
        [self.reservation_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_seller"]) {
        [self.deal_seller_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_img"]) {
        [self.deal_img_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_address"]) {
        [self.deal_address_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_desc"]) {
        [self.deal_desc_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_cate"]) {
        [self.deal_cate_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_wap_url"]) {
        [self.deal_wap_url_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"city_name"]) {
        [self.city_name_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_distance"]) {
        [self.deal_distance_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_subcate"]) {
        [self.deal_subcate_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_lng"]) {
        [self.deal_lng_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"website"]) {
        [self.website_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_subcate_id"]) {
        [self.deal_subcate_id_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_rating"]) {
        [self.deal_rating_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_district_name"]) {
        [self.deal_district_name_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_lat"]) {
        [self.deal_lat_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"value"]) {
        [self.value_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"start_time"]) {
        [self.start_time_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_phones"]) {
        [self.deal_phones_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"end_time"]) {
        [self.end_time_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"price"]) {
        [self.price_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_id"]) {
        [self.deal_id_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_url"]) {
        [self.deal_url_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"deal_cate_id"]) {
        [self.deal_cate_id_Array addObject:self.tempString];
    } else if ([elementName isEqualToString:@"rebate"]) {
        [self.rebate_Array addObject:self.tempString];
    }
    
    /**
     *  清空临时字符串
     */
    self.tempString = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
//    NSLog(@"解析结束");
    for (int i = 0; i < self.deal_id_Array.count; i++) {
        LADDealModel *model = [[LADDealModel alloc] init];
        
        model.deal_title = self.deal_title_Array[i];
        model.sales_num = self.sales_num_Array[i];
        model.deal_name = self.deal_name_Array[i];
        model.deal_range = self.deal_rating_Array[i];
        model.reservation = self.reservation_Array[i];
        model.deal_seller = self.deal_seller_Array[i];
        model.deal_img = self.deal_img_Array[i];
        model.deal_address = self.deal_address_Array[i];
        model.deal_desc = self.deal_desc_Array[i];
        model.deal_cate = self.deal_cate_Array[i];
        model.deal_wap_url = self.deal_wap_url_Array[i];
        model.city_name = self.city_name_Array[i];
        model.deal_distance = self.deal_distance_Array[i];
        model.deal_subcate = self.deal_subcate_Array[i];
        model.deal_subcate_id = self.deal_subcate_id_Array[i];
        model.deal_lng = self.deal_lng_Array[i];
        model.website = self.website_Array[i];
        model.deal_rating = self.deal_rating_Array[i];
        model.deal_district_name = self.deal_district_name_Array[i];
        model.deal_lat = self.deal_lat_Array[i];
        model.value = self.value_Array[i];
        model.start_time = self.start_time_Array[i];
        model.deal_phones = self.deal_phones_Array[i];
        model.end_time = self.end_time_Array[i];
        model.price = self.price_Array[i];
        model.deal_id = self.deal_id_Array[i];
        model.deal_url = self.deal_url_Array[i];
        model.deal_cate_id = self.deal_cate_id_Array[i];
        model.rebate = self.rebate_Array[i];
        
        [self.dataArray addObject:model];
    }
//    NSLog(@"%@", self.dataArray);
}

@end
