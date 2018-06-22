//
//  SorinNavigationBar.h
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/15.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SorinNavigationBar;
//导航栏代理协议声明
@protocol SorinNavigationBarDelegate<NSObject>
@optional
//导航栏左边按钮点击代理事件
- (void)leftClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavigationBar *)navigationbar;
//导航栏右边按钮点击代理事件
- (void)rightClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavigationBar *)navigationbar;
//导航栏标题视图的点击代理事件
- (void)titleViewClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavigationBar *)navigationbar;
@end

@protocol SorinNavigationBarDataSource<NSObject>
@optional
//导航栏左边视图的代理设置
- (UIView *)sorinNavagationbarLeftView:(SorinNavigationBar *)navigationBar;
//导航栏右边视图的代理设置
- (UIView *)sorinNavagationbarRightView:(SorinNavigationBar *)navigationBar;
//导航栏左边按钮的代理设置
- (UIImage *)sorinNavagationbarLeftBtn:(UIButton *)leftBtn navigationbar:(SorinNavigationBar *)navigationBar;
//导航栏右边按钮的代理设置
- (UIImage *)sorinNavagationbarRightBtn:(UIButton *)rightBtn navigationbar:(SorinNavigationBar *)navigationBar;
//导航栏中间视图的代理设置
- (UIView *)sorinNavagationbarMiddleView:(SorinNavigationBar *)navigationBar;
//是否隐藏导航栏底部线条
- (BOOL)isHiddenNavigationbarBottomline:(SorinNavigationBar *)navigationBar;
//导航栏背景色
- (UIColor *)SorinNavigationBarBackgroundColor:(SorinNavigationBar *)navigationBar;
//导航栏背景图片
- (UIImage *)SorinNavigationBarBackgroundImage:(SorinNavigationBar *)navigationBar;
//导航栏高度
- (CGFloat)SorinNavigationBarHeight:(SorinNavigationBar *)navigationBar;
//导航栏标题
- (NSMutableAttributedString*)SorinNavigationBarTitle:(SorinNavigationBar *)navigationBar;

@end
@interface SorinNavigationBar : UIView
//导航栏代理
@property (nonatomic,weak) id<SorinNavigationBarDelegate> barDelegate;
//导航栏数据代理
@property (nonatomic,weak) id<SorinNavigationBarDataSource> barDataSource;
//标题
@property (nonatomic,weak) NSMutableAttributedString *barTitle;
@end
