//
//  LADMineViewController.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADMineViewController.h"
#import "CommonHelper.h"
#import "SDImageCache.h"
#import "LADFavoriteTableViewController.h"
#import <Masonry.h>
#define kSCREENW [UIScreen mainScreen].bounds.size.width

@interface LADMineViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation LADMineViewController

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"111"]];
        _headerView.frame = CGRectMake(0, 0, 0, 150);
        
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.008 green:0.635 blue:0.992 alpha:1.000];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                //  我的收藏
                LADFavoriteTableViewController *fvc = [[LADFavoriteTableViewController alloc] init];
                [self.navigationController pushViewController:fvc animated:YES];
                
            }
                break;
            case 1:{
                // 清理缓存
                SDImageCache *imageCache = [SDImageCache sharedImageCache];
                [imageCache clearDisk];
                UIAlertController *alVC = [UIAlertController alertControllerWithTitle:@"" message:@"清理成功!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alVC addAction:action];
                [self presentViewController:alVC animated:YES completion:nil];
                self.cacheLabel.text = [CommonHelper getByteString:[imageCache getSize]];
            }
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                NSString *evaluateString = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1094596055"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:evaluateString]];
            }
                
                break;
            default:
                break;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    self.cacheLabel.text = [CommonHelper getByteString:[imageCache getSize]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
