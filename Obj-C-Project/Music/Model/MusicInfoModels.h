//
//  MusicInfoModels.h
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/21.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicModel.h"
#import "LrcModel.h"
@interface MusicInfoModels : NSObject
+ (instancetype)shareInstance;
@property (nonatomic,strong) MusicModel *currentMusicModel;

@property (nonatomic,copy) NSArray <LrcModel *> *LrcList;

@property (nonatomic,strong) NSMutableArray <MusicModel *>*MusicList;

@end
