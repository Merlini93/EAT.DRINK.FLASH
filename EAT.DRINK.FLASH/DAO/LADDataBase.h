//
//  LADDataBase.h
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/17.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LKDBHelper.h>

@class LADDealModel;
@interface LADDataBase : NSObject

- (BOOL)saveModel:(LADDealModel *)model;
- (BOOL)deleteByRowid:(NSNumber *)rowid;
- (NSArray *)findAll;

@end
