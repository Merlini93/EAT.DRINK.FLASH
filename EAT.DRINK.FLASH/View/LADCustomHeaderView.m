//
//  LADCustomHeaderView.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/16.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#define kSCREENW [UIScreen mainScreen].bounds.size.width

#import "LADCustomHeaderView.h"
#import "LADDrinkViewController.h"

@interface LADCustomHeaderView ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *iconArray;
@end

@implementation LADCustomHeaderView

- (NSArray *)iconArray
{
    if (!_iconArray) {
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0; i < 8; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
            [arrayM addObject:imageView];
        }
        _iconArray = [arrayM copy];
    }
    return _iconArray;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"按摩", @"洗浴", @"KTV", @"酒吧/咖啡厅", @"电玩/桌游", @"电影", @"密室逃脱", @"健身"];
    }
    return _titleArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat kWidth = kSCREENW / 4;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 4; j++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(j * kWidth, i * kWidth, kWidth, kWidth);
                UIImageView *imageView = self.iconArray[i * 4 + j];
                imageView.frame = CGRectMake(25, 10, kWidth - 50, kWidth - 50);
                [btn addSubview:imageView];
                UILabel *titleLabel = [[UILabel alloc] init];
                titleLabel.text = self.titleArray[i * 4 + j];
                titleLabel.frame = CGRectMake(0, kWidth - 20, kWidth, 20);
                [btn addSubview:titleLabel];
                titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabel.font = [UIFont systemFontOfSize:13];
                [titleLabel setTextColor:[UIColor colorWithWhite:0.400 alpha:1.000]];
                btn.tag = 1000 + i * 4 + j;
                [btn addTarget:self action:@selector(didClickCategory:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                
            }
            
        }
    }
    return self;
}

- (void)didClickCategory:(UIButton *)btn
{
    NSInteger tag = btn.tag - 1000;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    switch (tag) {
        case 0:{
            [center postNotificationName:@"CHOOSE_CATEGORY" object:nil userInfo:@{@"category" : @"按摩"}];
        }
            break;
        case 1:{
            [center postNotificationName:@"CHOOSE_CATEGORY" object:nil userInfo:@{@"category" : @"洗浴"}];
        }
            break;
        case 2:{
            [center postNotificationName:@"CHOOSE_CATEGORY" object:nil userInfo:@{@"category" : @"KTV"}];
        }
            break;
        case 3:{
            [center postNotificationName:@"CHOOSE_CATEGORY" object:nil userInfo:@{@"category" : @"酒吧"}];
        }
            break;
        case 4:{
            [center postNotificationName:@"CHOOSE_CATEGORY" object:nil userInfo:@{@"category" : @"电玩/桌游"}];
        }
            break;
        case 5:{
            [center postNotificationName:@"CHOOSE_CATEGORY" object:nil userInfo:@{@"category" : @"电影"}];
        }
            break;
        case 6:{
            [center postNotificationName:@"CHOOSE_CATEGORY" object:nil userInfo:@{@"category" : @"密室逃脱"}];
        }
            break;
        case 7:{
            [center postNotificationName:@"CHOOSE_CATEGORY" object:nil userInfo:@{@"category" : @"健身"}];
        }
            break;
            
        default:
            NSLog(@"opps,something bad happend");
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
