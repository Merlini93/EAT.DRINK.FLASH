//
//  LADEatViewController.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADEatViewController.h"
#import "LADAppService.h"
#import "LADDealModel.h"
#import "LADLocation.h"
#import "LADXMLParser.h"
#import "LADCollectionViewCell.h"
#import "LADDeatailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MJRefresh.h>
#import <MBProgressHUD.h>

#define SCREENW [UIScreen mainScreen].bounds.size.width

@interface LADEatViewController () <UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate>
{
    NSInteger _offset;
    CLLocation *_location;
}

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) NSArray *dataArray;

@end

static NSString * const reuseidentifier = @"myCollectionViewCell";

@implementation LADEatViewController

- (CLLocationManager *)manager
{
    if (!_manager) {
        if ([CLLocationManager locationServicesEnabled]) {
            _manager = [[CLLocationManager alloc] init];
            _manager.delegate = self;
            // 精度大约100米
            _manager.desiredAccuracy = kCLLocationAccuracyBest;
            _manager.distanceFilter = 100;
            [_manager requestWhenInUseAuthorization];
            [_manager startUpdatingLocation];
        }
    }
    return _manager;
}

#pragma mark - 定位数据
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//    NSLog(@"%@", locations.lastObject);
    _location = locations.lastObject;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[LADAppService alloc] init] getFoodXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                [self.collectionView reloadData];
            }];
            
        });
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self manager];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    [hud hide:YES afterDelay:1];
    self.navigationItem.title = @"吃";
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.008 green:0.635 blue:0.992 alpha:1.000];
    [self.collectionView registerClass:[LADCollectionViewCell class] forCellWithReuseIdentifier:reuseidentifier];
    [self configMJHeader];
    [self configMJFooter];
}

#pragma mark - 上拉加载更多

- (void)configMJFooter
{
    __weak typeof(self) vc = self;
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 重新定位, 发送请求
        [[[LADAppService alloc] init]  getXMLFromServiceWithLocation:_location withCategory:@"西餐火锅自助餐烧烤湖北菜川湘菜" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
            NSArray *tempArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
            if (tempArray) {
                self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:tempArray];
                _offset += 20;
            }
            
            [vc.collectionView reloadData];
            if ([vc.collectionView.mj_footer isRefreshing]) {
                [vc.collectionView.mj_footer endRefreshing];
            }
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.collectionView.mj_footer isRefreshing]) {
                [self.collectionView.mj_footer endRefreshing];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
                hud.labelText = @"网络不给力";
                hud.animationType = MBProgressHUDAnimationZoom;
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:1];
                [hud removeFromSuperview];
            }
        });

    }];
}

#pragma mark - 下拉刷新

- (void)configMJHeader
{
    __weak typeof(self) vc = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 重新定位, 发送请求
        [[[LADAppService alloc] init] getFoodXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
            vc.dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
            
            [vc.collectionView reloadData];
            if ([vc.collectionView.mj_header isRefreshing]) {
                [vc.collectionView.mj_header endRefreshing];
            }
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.collectionView.mj_header isRefreshing]) {
                [self.collectionView.mj_header endRefreshing];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
                hud.labelText = @"网络不给力";
                hud.animationType = MBProgressHUDAnimationZoom;
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:1];
            }
        });
    }];
}

#pragma mark - CollectionView代理方法
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseidentifier forIndexPath:indexPath];
    LADDealModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREENW - 30) / 2, (SCREENW - 30) / 2 );
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

#pragma mark - CollecitonView点击方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LADDealModel *model = self.dataArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LADDeatailViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"LADDeatailViewController"];
    dvc.model = model;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
