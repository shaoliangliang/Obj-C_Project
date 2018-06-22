//
//  MusicOpreationTool.h
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/21.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicModel.h"
#import "LrcModel.h"
#import <AVFoundation/AVFoundation.h>
@interface MusicOpreationTool : NSObject
@property (nonatomic,strong) AVPlayer *musicPlayer;
@property (nonatomic,assign) BOOL isPlaying;
+ (instancetype)shareInstance;
- (void)playMusic:(MusicModel *)model;

- (void)playMusic;

- (void)pauseMusic;

- (void)playNext;

- (void)playPrevious;


- (NSArray <LrcModel *> *)getLrcData:(NSString *)lrcName;

+ (void)getLrcInfo:(NSTimeInterval)currentTime LrcsData:(NSArray <LrcModel *>*)modelData complete:(void(^)(LrcModel *model,NSInteger currentRow))complete;
@end
