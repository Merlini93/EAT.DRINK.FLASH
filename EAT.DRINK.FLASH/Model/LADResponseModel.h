//
//  LADResponseModel.h
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LADDealsModel.h"

@interface LADResponseModel : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) LADDealsModel *deals;

@end
