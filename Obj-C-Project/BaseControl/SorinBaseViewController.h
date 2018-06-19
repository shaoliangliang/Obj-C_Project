//
//  SorinBaseViewController.h
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/15.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SorinBaseViewController : UIViewController<SorinNavigationBarDelegate,SorinNavigationBarDataSource>
@property (nonatomic,weak) SorinNavigationBar *Navigationbar;

@end
