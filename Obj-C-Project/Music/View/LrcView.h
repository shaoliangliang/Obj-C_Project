//
//  LrcView.h
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/22.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LrcModel.h"
@interface LrcView : UIScrollView
@property (nonatomic,strong) UITableView *lrcsList;
@property (nonatomic,strong) NSArray <LrcModel *> *LrcArray;
@property (nonatomic,assign) NSInteger row;
@end
