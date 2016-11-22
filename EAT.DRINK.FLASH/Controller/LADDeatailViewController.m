//
//  LADDeatailViewController.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/17.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADDeatailViewController.h"
#import "LADDealModel.h"
#import "LADDataBase.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <MBProgressHUD.h>

@interface LADDeatailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ValueLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation LADDeatailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.presentingViewController) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    self.title = self.model.deal_name;
    [self configUI];
    
//    UIBarButtonItem *itemShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(didClickShareBtn:)];
    UIBarButtonItem *itemFavor = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavor:)];
    itemFavor.tintColor = [UIColor whiteColor];
//    itemShare.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[itemFavor];
    
    NSArray *dataArray = [[[LADDataBase alloc] init] findAll];
    for (LADDealModel *model in dataArray) {
        if ([model.deal_id isEqualToString:self.model.deal_id]) {
            itemFavor.title = @"已收藏";
        }
    }

}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configUI
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.model.deal_img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.priceLabel.text = [@"￥" stringByAppendingString:self.model.price];
    self.ValueLabel.text = [@"门市价￥" stringByAppendingString:self.model.value];
    [self.buyBtn addTarget:self action:@selector(didClickBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.descLabel.text = self.model.deal_desc;
    self.sellerLabel.text = self.model.deal_seller;
    self.rangeLabel.text = self.model.deal_subcate;

    self.districtLabel.text = self.model.deal_district_name;
    self.addressLabel.text = self.model.deal_address;
    self.phoneLabel.text = self.model.deal_phones;
}

#pragma mark - 按钮点击方法
- (void)didClickBuyBtn:(UIButton *)btn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.deal_wap_url]];
}

//- (void)didClickShareBtn:(UIBarButtonItem *)btn
//{
//    
//}

- (void)didClickFavor:(UIBarButtonItem *)btn
{
//    NSLog(@"%@", NSHomeDirectory());
    if ([btn.title isEqualToString:@"收藏"]) {
        if([[[LADDataBase alloc] init] saveModel:self.model]) {
            btn.title = @"已收藏";
        }
    } else {
        NSArray *array = [[[LADDataBase alloc] init] findAll];
        for (LADDealModel *model in array) {
            if ([model.deal_id isEqualToString:self.model.deal_id]) {
                
                if ([[[LADDataBase alloc] init] deleteByRowid:[NSNumber numberWithInteger:model.rowid]]) {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"已取消收藏";
                    [hud hide:YES afterDelay:1];
                    btn.title = @"收藏";
                }
            }
        }
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
