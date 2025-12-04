//
//  LADDataBase.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/17.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADDataBase.h"
#import "LADDealModel.h"

@implementation LADDataBase

- (BOOL)saveModel:(LADDealModel *)model
{
    
    return [model saveToDB];
}

- (NSArray *)findAll
{
    return [LADDealModel searchWithWhere:nil];
}

- (BOOL)deleteByRowid:(NSNumber *)rowid
{
    return [[self findByRowid:rowid] deleteToDB];
}

- (LADDealModel *)findByRowid:(NSNumber *)rowid
{
    return [LADDealModel searchSingleWithWhere:@{@"rowid" : rowid} orderBy:nil];
}

@end
