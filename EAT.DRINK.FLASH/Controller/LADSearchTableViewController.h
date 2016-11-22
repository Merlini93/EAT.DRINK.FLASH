//
//  LADSearchTableViewController.h
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/18.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class LADDealModel;
typedef void(^LADSearchTableViewControllerBlock)(LADDealModel *selectedModel);

@interface LADSearchTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *searchResultArray;
@property (nonatomic, copy) LADSearchTableViewControllerBlock block;

@end
