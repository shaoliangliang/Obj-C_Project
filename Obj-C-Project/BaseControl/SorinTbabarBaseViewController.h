//
//  SorinTbabarBaseViewController.h
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/15.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
//供外部调用 设置的参数
//tabbar标题
FOUNDATION_EXTERN NSString *const SorinTabbarItemTitle;
//tabbar图片
FOUNDATION_EXTERN NSString *const SorinTabbarItemImage;
//tabbar选中图片
FOUNDATION_EXTERN NSString *const SorinTabbarItemSelectImage;
@interface SorinTbabarBaseViewController : UITabBarController
//子控制器信息集合
@property (nonatomic,copy) NSArray<NSDictionary *> *viewcontrollerInfo;
@end
