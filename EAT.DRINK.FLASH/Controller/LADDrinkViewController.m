//
//  LADDrinkViewController.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADDrinkViewController.h"
#import "LADAppService.h"
#import "LADDealModel.h"
#import "LADXMLParser.h"
#import "LADTableViewCell.h"
#import "LADDeatailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <SDCycleScrollView.h>
#import <MBProgressHUD.h>
#import <MJRefresh.h>

#define kSCREENW [UIScreen mainScreen].bounds.size.width

static NSString * const reuseidentifier = @"LADTableViewCell";

@interface LADDrinkViewController () <SDCycleScrollViewDelegate, CLLocationManagerDelegate>{
    NSInteger _offset;
    CLLocation *_location;
}

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation LADDrinkViewController

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
        LADAppService *service = [[LADAppService alloc] init];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!self.category) {
                [service getDrinkXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                    _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    
                    [vc configCycleScrollViewWithArray:_dataArray];
                    
                    [vc.tableView reloadData];
                }];
            } else {
                if ([self.category isEqualToString:@"按摩"]) {
                    [service getMassageXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                        _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                        [vc.tableView reloadData];
                    }];
                } else if ([self.category isEqualToString:@"洗浴"]) {
                    [service getBathXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                        _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                        [vc.tableView reloadData];
                    }];
                } else if ([self.category isEqualToString:@"KTV"]) {
                    [service getKTVXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                        _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                        [vc.tableView reloadData];
                    }];
                } else if ([self.category isEqualToString:@"酒吧"]) {
                    [service getBarXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                        _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                        [vc.tableView reloadData];
                    }];
                } else if ([self.category isEqualToString:@"电玩/桌游"]) {
                    [service getGameXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                        _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                        [vc.tableView reloadData];
                    }];
                } else if ([self.category isEqualToString:@"电影"]) {
                    [service getMovieXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                        _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                        [vc.tableView reloadData];
                    }];
                } else if ([self.category isEqualToString:@"密室逃脱"]) {
                    [service getEscapeXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                        _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                        [vc.tableView reloadData];
                    }];
                } else if ([self.category isEqualToString:@"健身"]) {
                    [service getGymXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                        _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                        [vc.tableView reloadData];
                    }];
                }
            }
        });
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [hud hide:YES afterDelay:1];
    [self manager];
    [self configMJHeader];
    [self configMJFooter];
    if (self.dataArray.count < 6) {
        self.tableView.mj_footer.hidden = YES;
    }
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if (!self.category) {
        self.navigationItem.title = @"喝";
    } else {
        self.navigationItem.title = self.category;
    }
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.008 green:0.635 blue:0.992 alpha:1.000];
    
    [self.tableView registerClass:[LADTableViewCell class] forCellReuseIdentifier:reuseidentifier];
}

#pragma mark - 上拉加载更多

- (void)configMJFooter
{
    __weak typeof(self) vc = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 重新定位, 发送请求
        LADAppService *service = [[LADAppService alloc] init];
        if (!self.category) {
            [service getDrinkXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                [vc.tableView reloadData];
            }];
        } else {
            if ([self.category isEqualToString:@"按摩"]) {
                [service getXMLFromServiceWithLocation:_location withCategory:@"按摩" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
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
            } else if ([self.category isEqualToString:@"洗浴"]) {
                [service getXMLFromServiceWithLocation:_location withCategory:@"洗浴" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
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
            } else if ([self.category isEqualToString:@"KTV"]) {
                [service getXMLFromServiceWithLocation:_location withCategory:@"KTV" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
                    NSArray *tempArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    if (tempArray) {
                        self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:tempArray];
                        _offset += 20;
                    }
                    
                    [vc.tableView reloadData];
                    if ([vc.tableView.mj_footer isRefreshing]) {
                        [vc.tableView.mj_footer endRefreshing];
                    }                }];
            } else if ([self.category isEqualToString:@"酒吧"]) {
                [service getXMLFromServiceWithLocation:_location withCategory:@"酒吧" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
                    NSArray *tempArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    if (tempArray) {
                        self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:tempArray];
                        _offset += 20;
                    }
                    
                    [vc.tableView reloadData];
                    if ([vc.tableView.mj_footer isRefreshing]) {
                        [vc.tableView.mj_footer endRefreshing];
                    }                }];
            } else if ([self.category isEqualToString:@"电玩/桌游"]) {
                [service getXMLFromServiceWithLocation:_location withCategory:@"电玩/桌游" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
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
            } else if ([self.category isEqualToString:@"电影"]) {
                [service getXMLFromServiceWithLocation:_location withCategory:@"电影" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
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
            } else if ([self.category isEqualToString:@"密室逃脱"]) {
                [service getXMLFromServiceWithLocation:_location withCategory:@"密室逃脱" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
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
            } else if ([self.category isEqualToString:@"健身"]) {
                [service getXMLFromServiceWithLocation:_location withCategory:@"健身" withOffset:[NSNumber numberWithInteger:_offset + 20] withCompeletionHandler:^(id data) {
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
            }
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.tableView.mj_footer isRefreshing]) {
                [self.tableView.mj_footer endRefreshing];
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

#pragma mark - 下拉刷新

- (void)configMJHeader
{
    __weak typeof(self) vc = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 重新定位, 发送请求
        LADAppService *service = [[LADAppService alloc] init];
        if (!self.category) {
            [service getDrinkXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                
                [vc configCycleScrollViewWithArray:_dataArray];
                
                [vc.tableView reloadData];
                if ([self.tableView.mj_header isRefreshing]) {
                    [self.tableView.mj_header endRefreshing];
                }
            }];
        } else {
            if ([self.category isEqualToString:@"按摩"]) {
                [service getMassageXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                    _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    [vc.tableView reloadData];
                }];
            } else if ([self.category isEqualToString:@"洗浴"]) {
                [service getBathXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                    _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    [vc.tableView reloadData];
                }];
            } else if ([self.category isEqualToString:@"KTV"]) {
                [service getKTVXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                    _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    [vc.tableView reloadData];
                }];
            } else if ([self.category isEqualToString:@"酒吧"]) {
                [service getBarXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                    _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    [vc.tableView reloadData];
                }];
            } else if ([self.category isEqualToString:@"电玩/桌游"]) {
                [service getGameXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                    _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    [vc.tableView reloadData];
                }];
            } else if ([self.category isEqualToString:@"电影"]) {
                [service getMovieXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                    _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    [vc.tableView reloadData];
                }];
            } else if ([self.category isEqualToString:@"密室逃脱"]) {
                [service getEscapeXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                    _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    [vc.tableView reloadData];
                }];
            } else if ([self.category isEqualToString:@"健身"]) {
                [service getGymXMLFromServiceWithLocation:_location withCompeletionHandler:^(id data) {
                    _dataArray = [[[LADXMLParser alloc] init] getModelArrayWithXMLData:data];
                    [vc.tableView reloadData];
                }];
            }
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.tableView.mj_header isRefreshing]) {
                [self.tableView.mj_header endRefreshing];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
                hud.labelText = @"网络不给力";
                hud.animationType = MBProgressHUDAnimationZoom;
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:1];
            }
        });
    }];
}

#pragma mark - configCycleScrollView
- (void)configCycleScrollViewWithArray:(NSArray *)array
{
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kSCREENW, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    NSMutableArray *cycleArrayM = [NSMutableArray array];
    NSMutableArray *titleArrayM = [NSMutableArray array];
    if(!self.category) {
    LADDealModel *model1 = array.firstObject;
    NSURL *imgUrl1 = [NSURL URLWithString:model1.deal_img];
    [cycleArrayM addObject:imgUrl1];
    [titleArrayM addObject:model1.deal_title];
    
    LADDealModel *model2 = array.lastObject;
    NSURL *imgUrl2 = [NSURL URLWithString:model2.deal_img];
    [cycleArrayM addObject:imgUrl2];
    [titleArrayM addObject:model2.deal_title];
    
    LADDealModel *model3 = array[2];
    NSURL *imgUrl3 = [NSURL URLWithString:model3.deal_img];
    [cycleArrayM addObject:imgUrl3];
    [titleArrayM addObject:model3.deal_title];
    
    }
    
    cycleView.imageURLStringsGroup = cycleArrayM;
    cycleView.titlesGroup = titleArrayM;
    cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    if (!self.category) {
        
        self.tableView.tableHeaderView = cycleView;
    }
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

#pragma mark - TableView点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LADDealModel *model = self.dataArray[indexPath.row];
    LADDeatailViewController *wVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LADDeatailViewController"];
    wVC.model = model;
    [self.navigationController pushViewController:wVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - cycleScorllView点击方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    LADDeatailViewController *wVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LADDeatailViewController"];
    
    switch (index) {
        case 0:
            wVC.model = self.dataArray.firstObject;
            break;
        case 1:
            wVC.model = self.dataArray.lastObject;
            break;
        case 2:
            wVC.model = self.dataArray[4];
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:wVC animated:YES];
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
