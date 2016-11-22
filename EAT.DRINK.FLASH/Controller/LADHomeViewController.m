//
//  LADHomeViewController.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/10.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADHomeViewController.h"
#import "LADEatViewController.h"
#import "LADDrinkViewController.h"
#import "LADFlashViewController.h"
#import "LADMineViewController.h"

@interface LADHomeViewController ()

@end

@implementation LADHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configTabbar];
}
/**
 *  配置tabbar 图标 文字
 */
- (void)configTabbar
{
    UINavigationController *eatVC = [[UINavigationController alloc] initWithRootViewController:[[LADEatViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]];
    eatVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"吃" image:[[UIImage imageNamed:@"icon_tabbar_homepage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"pizza"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UINavigationController *drinkVC = [[UINavigationController alloc] initWithRootViewController:[[LADDrinkViewController alloc] init]];
    drinkVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"喝" image:[[UIImage imageNamed:@"icon_tabbar_merchant_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"drink"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UINavigationController *flashVC = [[UINavigationController alloc] initWithRootViewController:[[LADFlashViewController alloc] init]];
    flashVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"闪" image:[[UIImage imageNamed:@"icon_tabbar_onsite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"eat"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LADMineViewController *sbVC = [storyBoard instantiateViewControllerWithIdentifier:@"LADMineViewController"];
    
    UINavigationController *mineVC = [[UINavigationController alloc] initWithRootViewController:sbVC];
    mineVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"icon_tabbar_mine"] selectedImage:[[UIImage imageNamed:@"icon_tabbar_mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.tabBar.tintColor = [UIColor colorWithRed:0.008 green:0.635 blue:0.992 alpha:1.000];
    
    self.viewControllers = @[eatVC, drinkVC, flashVC, mineVC];

    
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
