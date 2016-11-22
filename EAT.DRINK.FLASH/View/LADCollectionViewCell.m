//
//  LADCollectionViewCell.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/14.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADCollectionViewCell.h"
#import "LADDealModel.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

static const CGFloat kScale = 388.0 / 640.0;

@interface LADCollectionViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIImageView *locationImageView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *rebateLabel;

@end

@implementation LADCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        
        self.rebateLabel = [[UILabel alloc] init];
        self.rebateLabel.font = [UIFont systemFontOfSize:11];
        [self.rebateLabel setTextColor:[UIColor redColor]];
        self.rebateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.rebateLabel];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.font = [UIFont systemFontOfSize:11];
        self.addressLabel.numberOfLines = 0;
        [self.contentView addSubview:self.addressLabel];
        
        self.locationImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.locationImageView];
        
        self.distanceLabel = [[UILabel alloc] init];
        self.distanceLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.distanceLabel];
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setModel:(LADDealModel *)model
{
    _model = model;
    self.titleLabel.text = model.deal_seller;
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width - 10, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:11]} context:nil].size;
    //    NSLog(@"%f", size.height);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.frame.size.width - 50);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
        make.height.mas_equalTo(size.height);
        make.leading.equalTo(self.contentView).offset(5);
//        make.right.equalTo(self.rebateLabel.mas_left).offset(-5);
    }];
    
    self.rebateLabel.text = [model.rebate stringByAppendingString:@"折"];
    [self.rebateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_top);
        make.trailing.equalTo(self.contentView).offset(-5);
        make.height.equalTo(self.titleLabel.mas_height);
        make.width.equalTo(@40);
    }];
    
    self.addressLabel.text = model.deal_address;
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.leading.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.locationImageView.mas_top);
        make.trailing.equalTo(self.contentView).offset(-5);
    }];
    
    
    if (model.deal_distance.length > 4) {
        self.distanceLabel.text = [[model.deal_distance substringToIndex:4] stringByAppendingString:@"km"];
    } else {
        self.distanceLabel.text = [model.deal_distance stringByAppendingString:@"km"];
        
    }
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationImageView.mas_right).offset(5);
        make.top.equalTo(self.locationImageView.mas_top);
        make.width.equalTo(@50);
//        make.trailing.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.deal_img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.frame.size.width );
        make.height.mas_equalTo(self.frame.size.width * kScale);
        make.leading.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
    }];
    
    self.locationImageView.image = [UIImage imageNamed:@"icon_distance_color"];
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(5);
        make.height.equalTo(@[self.locationImageView.mas_width, @15]);
        //        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

@end
