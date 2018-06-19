//
//  SorinBaseViewController.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/15.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "SorinBaseViewController.h"

@interface SorinBaseViewController ()

@end

@implementation SorinBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidLayoutSubviews{
    [self viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:self.Navigationbar];
}
- (SorinNavigationBar *)Navigationbar{
    if (!_Navigationbar) {
        SorinNavigationBar *bar = [[SorinNavigationBar alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kStatusBarHeight + 44)];
        [self.view addSubview:bar];
        _Navigationbar = bar;
        bar.barDelegate = self;
        bar.barDataSource = self;
    }
    return _Navigationbar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    NSLog(@"给你最后的疼爱是手放开 %@",[self class]);
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
