//
//  SorinTbabarBaseViewController.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/15.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "SorinTbabarBaseViewController.h"
NSString *const SorinTabbarItemTitle = @"SorinTabbarItemTitle";
NSString *const SorinTabbarItemImage = @"SorinTabbarItemImage";
NSString *const SorinTabbarItemSelectImage = @"SorinTabbarItemSelectImage";
@interface SorinTbabarBaseViewController ()

@end

@implementation SorinTbabarBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark 重写setViewControllers方法
- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    NSString *exceptionReason = @"viewControllers count id different viewcontrollerInfo count";
    NSString *exceptionName = @"crash";
    NSDictionary *exceptionInfo = @{@"key":@"value"};
    NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionInfo];
    if (viewControllers.count != self.viewcontrollerInfo.count) {
        @throw exception;
    }else{
        NSUInteger idx = 0;
        for (UIViewController *controller in viewControllers) {
            NSString *barItemTitle = nil;
            id barItemImage = nil;
            id barItemSelectImage = nil;
            barItemTitle = self.viewcontrollerInfo[idx][SorinTabbarItemTitle];
            barItemImage = self.viewcontrollerInfo[idx][SorinTabbarItemImage];
            barItemSelectImage = self.viewcontrollerInfo[idx][SorinTabbarItemSelectImage];
            [self addChildViewController:controller itemTitle:barItemTitle itemImage:barItemImage ItemSelectImage:barItemSelectImage];
            idx ++;
        }
    }
    
}
#pragma mark 添加子控制
/**
 添加子控制
 
 @param controller    控制器
 @param title         标题
 @param image         图片
 @param selectImage   选中图片
 */
- (void)addChildViewController:(UIViewController *)controller itemTitle:(NSString *)title itemImage:(id)image ItemSelectImage:(id)selectImage{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [self getItemImage:image];
    controller.tabBarItem.selectedImage = [self getItemImage:selectImage];
    [self addChildViewController:controller];
}
- (UIImage *)getItemImage:(id)image{
    UIImage *ima = nil;
    if ([image isKindOfClass:[UIImage class]]) {
        ima = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else if ([image isKindOfClass:[NSString class]]){
        ima = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return ima;
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
