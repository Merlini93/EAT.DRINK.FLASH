//
//  LADFlashViewController.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADFlashViewController.h"
#import "LADCustomHeaderView.h"
#import "LADAppService.h"
#import "LADXMLParser.h"
#import "LADDealModel.h"
#import "LADTableViewCell.h"
#import "LADDeatailViewController.h"
#import "LADSearchTableViewController.h"
#import "LADDrinkViewController.h"
#import <MBProgressHUD.h>
#import <MJRefresh.h>
#import <CoreLocation/CoreLocation.h>
#define kSCREENW [UIScreen mainScreen].bounds.size.width

static NSString * const reuseidentifier = @"LADTableViewCell";

@interface LADFlashViewController () <CLLocationManagerDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>
{
    NSInteger _offset;
    CLLocation *_location;
}

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) UISearchController *svc;
@end

@implementation LADFlashViewController

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
        __weak typeof(self) vc = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[LADAppService alloc] init] getPlayXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                
                [vc.tableView reloadData];
            }];
            
        });
    }
    return _dataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [hud hide:YES afterDelay:1];
    [self manager];
    self.tableView.tableHeaderView = [[LADCustomHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, 220)];
    
    [self configMJHeader];
    [self configMJFooter];
    [self configNotification];
    self.navigationItem.title = @"闪";
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.008 green:0.635 blue:0.992 alpha:1.000];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(didClickSearch)];
    
    [self.tableView registerClass:[LADTableViewCell class] forCellReuseIdentifier:reuseidentifier];
}

- (void)configNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:@"CHOOSE_CATEGORY" object:nil];
}

- (void)didReceiveNotification:(NSNotification *)noti
{
    LADDrinkViewController *dvc = [[LADDrinkViewController alloc] init];
    dvc.category = noti.userInfo[@"category"];
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CHOOSE_CATEGORY" object:nil];
}

#pragma mark - 上拉加载更多

- (void)configMJFooter
{
    __weak typeof(self) vc = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 重新定位, 发送请求
        [[[LADAppService alloc] init]  getXMLFromServiceWithLocation:_location withCategory:@"休闲娱乐" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
            NSArray *tempArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
            if (tempArray) {
                self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:tempArray];
                _offset += 20;
            }
            
            [vc.tableView reloadData];
            if ([vc.tableView.mj_footer isRefreshing]) {
                [vc.tableView.mj_footer endRefreshing];
            }
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.tableView.mj_footer isRefreshing]) {
                [self.tableView.mj_footer endRefreshing];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
                hud.labelText = @"网络不给力";
                hud.animationType = MBProgressHUDAnimationZoom;
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:1];
            }
        });
        
    }];
}

#pragma mark - 配置下拉刷新
- (void)configMJHeader
{
    __weak typeof(self) vc = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 重新定位, 发送请求
        [[[LADAppService alloc] init] getPlayXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
            vc.dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
            [vc.tableView reloadData];
            if ([vc.tableView.mj_header isRefreshing]) {
                [vc.tableView.mj_header endRefreshing];
            }
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.tableView.mj_header isRefreshing]) {
                [self.tableView.mj_header endRefreshing];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
                hud.labelText = @"网络不给力";
                hud.animationType = MBProgressHUDAnimationZoom;
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:1];
                [hud removeFromSuperview];
            }
        });
    }];
}

#pragma mark - TableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LADTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentifier forIndexPath:indexPath];
    LADDealModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - Tableview点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LADDealModel *model = self.dataArray[indexPath.row];
    LADDeatailViewController *dvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LADDeatailViewController"];
    dvc.model = model;
    [self.navigationController pushViewController:dvc animated:YES];
}


- (void)didClickSearch
{
    NSLog(@"点击");
    LADSearchTableViewController *resultVc = [[LADSearchTableViewController alloc] init];
    self.svc = [[UISearchController alloc] initWithSearchResultsController:resultVc];
    self.svc.searchResultsUpdater = self;
    self.svc.delegate = self;
    resultVc.block = ^(LADDealModel *resultModel){
        self.tableView.tableHeaderView = [[LADCustomHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, 220)];
        
        LADDeatailViewController *dvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LADDeatailViewController"];
        dvc.model = resultModel;
        [self.navigationController pushViewController:dvc animated:YES];
    };
    
    self.tableView.tableHeaderView = self.svc.searchBar;
    [self.svc.searchBar becomeFirstResponder];
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    self.tableView.tableHeaderView = [[LADCustomHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, 220)];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *str = searchController.searchBar.text;
    if (str.length > 0) {
        [[[LADAppService alloc] init] getXMLFromServiceWithLocation:_location withCategory:str withOffset:@(0) withCompeletionHandler:^(id data) {
            LADSearchTableViewController *testVc = (LADSearchTableViewController *)searchController.searchResultsController;
            testVc.searchResultArray = [[[[LADXMLParser alloc] init] getModelArrayWithXMLData:data] mutableCopy];
            if (testVc.searchResultArray.count == 0) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:testVc.tableView animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"对不起，没有您要搜索的结果!";
                [hud hide:YES afterDelay:1];
                return;
            }
            [testVc.tableView reloadData];
        }];
        
    }
}

- (void)didReceiveMemoryWarning
{
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
