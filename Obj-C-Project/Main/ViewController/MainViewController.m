//
//  MainViewController.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/20.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
}
- (NSMutableAttributedString *)SorinNavigationBarTitle:(SorinNavigationBar *)navigationBar{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Main"];
    return str;
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
