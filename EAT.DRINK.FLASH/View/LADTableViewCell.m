//
//  LADTableViewCell.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/15.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADTableViewCell.h"
#import "LADDealModel.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

static const CGFloat kScale = 0.618;

@interface LADTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *districtLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *rebatePriceLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation LADTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.layer.cornerRadius = 5;
        self.iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.iconImageView];
        
        self.descLabel = [[UILabel alloc] init];
        self.descLabel.font = [UIFont systemFontOfSize:11];
        [self.descLabel setTextColor:[UIColor colorWithWhite:0.706 alpha:1.000]];
        [self.contentView addSubview:self.descLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.font = [UIFont systemFontOfSize:11];
        [self.addressLabel setTextColor:[UIColor colorWithWhite:0.706 alpha:1.000]];
        [self.contentView addSubview:self.addressLabel];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.nameLabel];
        
        self.distanceLabel = [[UILabel alloc] init];
        self.distanceLabel.textAlignment = NSTextAlignmentRight;
        self.distanceLabel.font = [UIFont systemFontOfSize:11];
        [self.distanceLabel setTextColor:[UIColor colorWithWhite:0.706 alpha:1.000]];
        [self.contentView addSubview:self.distanceLabel];
        
        self.districtLabel = [[UILabel alloc] init];
        self.districtLabel.font = [UIFont systemFontOfSize:11];
        [self.districtLabel setTextColor:[UIColor colorWithWhite:0.706 alpha:1.000]];
        [self.contentView addSubview:self.districtLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.font = [UIFont systemFontOfSize:11];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [self.priceLabel setTextColor:[UIColor colorWithWhite:0.706 alpha:1.000]];
        [self.contentView addSubview:self.priceLabel];
        
        self.rebatePriceLabel = [[UILabel alloc] init];
        self.rebatePriceLabel.font = [UIFont systemFontOfSize:11];
        self.rebatePriceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.rebatePriceLabel];
//        [self.rebatePriceLabel setTextColor:[UIColor colorWithWhite:0.706 alpha:1.000]];
        
    }
    return self;
}

- (void)setModel:(LADDealModel *)model
{
    _model = model;
    
    NSString *valueStr = [@"原价:" stringByAppendingString:[model.value stringByAppendingString:@"元"]];
    CGSize valueSize = [valueStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.deal_img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80/kScale);
    }];
    
    self.nameLabel.text = model.deal_title;
    CGSize size = [self.nameLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.iconImageView.mas_top).offset(5);
//        make.trailing.equalTo(self.contentView).offset(-80);
//        make.trailing.mas_greaterThanOrEqualTo(-10 - valueSize.width);
        make.right.equalTo(self.priceLabel.mas_left).offset(-5);
        make.height.mas_equalTo(size.height);
    }];
    
    self.descLabel.text = model.deal_seller;
    CGSize sales_numSize = [self.descLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size;
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(sales_numSize.height);
//        make.width.mas_equalTo(sales_numSize.width);
    }];
    
    self.addressLabel.text = model.deal_address;
    CGSize descLabelSize = [self.addressLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size;
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(descLabelSize.height);
//        make.width.mas_equalTo(descLabelSize.width);
        make.top.equalTo(self.descLabel.mas_bottom).offset(10);
    }];
    
    self.districtLabel.text = model.deal_district_name;
    CGSize districtLabelSize = [self.districtLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size;
    [self.districtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(5);
        make.top.equalTo(self.addressLabel.mas_top);
        make.height.mas_equalTo(districtLabelSize.height);
        make.right.equalTo(self.distanceLabel.mas_left).offset(-5);
//        make.width.mas_equalTo(districtLabelSize.width);
    }];
    
    if (model.deal_distance.length > 4) {
        self.distanceLabel.text = [[model.deal_distance substringToIndex:4] stringByAppendingString:@"km"];
    } else {
        self.distanceLabel.text = [model.deal_distance stringByAppendingString:@"km"];
    }
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.districtLabel.mas_right).offset(5);
        make.top.equalTo(self.districtLabel.mas_top);
        make.bottom.equalTo(self.districtLabel.mas_bottom);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.width.equalTo(@40);
    }];
    
    self.priceLabel.text = valueStr;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.priceLabel.text attributes:@{NSStrikethroughStyleAttributeName : @1}];
    [self.priceLabel setAttributedText:str];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.trailing.equalTo(self.contentView).offset(-10);
//        make.left.equalTo(self.nameLabel.mas_right).offset(5);
//        make.bottom.equalTo(self.nameLabel.mas_bottom);
        make.height.mas_equalTo(valueSize.height);
        make.width.mas_equalTo(75);
    }];
    
    self.rebatePriceLabel.text = [@"现在只需:" stringByAppendingString:[model.price stringByAppendingString:@"元"]];
    [self.rebatePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descLabel.mas_right).offset(5);
        make.top.equalTo(self.descLabel.mas_top);
        make.bottom.equalTo(self.descLabel.mas_bottom);
        make.trailing.equalTo(self.contentView).offset(-10);
    }];
}

@end
