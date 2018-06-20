//
//  MainTabbarViewController.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/20.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MainTabbarViewController.h"

@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setControllerInfo];
    
    [self setViewControler];
    // Do any additional setup after loading the view.
}
- (void)setControllerInfo{
    NSDictionary *mainInfoDic = @{SorinTabbarItemTitle:@"main",
                                  SorinTabbarItemImage:@"main",
                                  SorinTabbarItemSelectImage:@"main_click"};
    NSDictionary *musicInfoDic = @{SorinTabbarItemTitle:@"music",
                                   SorinTabbarItemImage:@"music",
                                   SorinTabbarItemSelectImage:@"music_click"};
    NSDictionary *newsInfoDic = @{SorinTabbarItemTitle:@"news",
                                  SorinTabbarItemImage:@"news",
                                  SorinTabbarItemSelectImage:@"news_click"};
    self.viewcontrollerInfo = @[mainInfoDic,musicInfoDic,newsInfoDic];
}
- (void)setViewControler{
    SorinNavigationBaseViewController *MainVC = [[SorinNavigationBaseViewController alloc] initWithRootViewController:[MainViewController new]];
    
    SorinNavigationBaseViewController *MusicVC = [[SorinNavigationBaseViewController alloc] initWithRootViewController:[MusicViewController new]];
    
    SorinNavigationBaseViewController *NewsVC = [[SorinNavigationBaseViewController alloc] initWithRootViewController:[NewsViewController new]];
    
    self.viewControllers = @[MainVC,MusicVC,NewsVC];
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
