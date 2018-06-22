//
//  MusicOpreationTool.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/21.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicOpreationTool.h"
#import "MusicInfoModels.h"
@interface MusicOpreationTool()
@property (nonatomic,assign)NSInteger MusicIndex;


@end
@implementation MusicOpreationTool
+ (instancetype)shareInstance{
    static MusicOpreationTool *musicTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicTool = [[MusicOpreationTool alloc] init];
    });
    return musicTool;
}
- (void)playMusic:(MusicModel *)model{
    self.MusicIndex = [[MusicInfoModels shareInstance].MusicList indexOfObject:model];
    NSString *path = [[NSBundle mainBundle] pathForResource:model.name ofType:@"mp3"];
    NSURL *locaPath = [NSURL fileURLWithPath:path];
    
    if ([locaPath isEqual:[self urlOfCurrentlyPlayingInPlayer:self.musicPlayer]]) {
        [self.musicPlayer play];
    }else{
        self.musicPlayer = nil;
        self.musicPlayer = [[AVPlayer alloc] initWithURL:locaPath];
        [self.musicPlayer play];
    }
}
- (BOOL)isPlaying{
    if ((self.musicPlayer.rate = 1.000000)) {
        _isPlaying = YES;
    }else{
        _isPlaying = NO;
    }
    return _isPlaying;
}
-(NSURL *)urlOfCurrentlyPlayingInPlayer:(AVPlayer *)player{
    
    AVAsset *currentPlayerAsset = player.currentItem.asset;
    
    if (![currentPlayerAsset isKindOfClass:AVURLAsset.class]){
        return nil;
    }
    
    return [(AVURLAsset *)currentPlayerAsset URL];
}
- (void)playMusic{
    [self.musicPlayer play];
}

- (void)pauseMusic{
    [self.musicPlayer pause];
}

- (void)playNext{
    self.MusicIndex ++;
    MusicModel *model = [[MusicInfoModels shareInstance].MusicList objectAtIndexedSubscript:self.MusicIndex];
    [self playMusic:model];
    [self changePlayData];
}
- (void)setMusicIndex:(NSInteger)MusicIndex{
    _MusicIndex = MusicIndex;
    if (MusicIndex < 0) {
        _MusicIndex = [MusicInfoModels shareInstance].MusicList.count - 1;
    }else if( MusicIndex > [MusicInfoModels shareInstance].MusicList.count - 1){
        _MusicIndex = 0;
    }
}

- (void)changePlayData{
    [MusicInfoModels shareInstance].currentMusicModel = [MusicInfoModels shareInstance].MusicList[self.MusicIndex];
    [MusicInfoModels shareInstance].LrcList = [[MusicOpreationTool shareInstance] getLrcData:[MusicInfoModels shareInstance].currentMusicModel.name];
}
- (void)playPrevious{
    self.MusicIndex --;
    MusicModel *model = [[MusicInfoModels shareInstance].MusicList objectAtIndexedSubscript:self.MusicIndex];
    [self playMusic:model];
    [self changePlayData];
}

- (NSArray <LrcModel *> *)getLrcData:(NSString *)lrcName{
    NSString *lrcPath = [[NSBundle mainBundle] pathForResource:lrcName ofType:@"lrc"];
    NSString *lrcStr = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
    __block NSArray *tempArr = [lrcStr componentsSeparatedByString:@"\n"];
    __block NSMutableArray <LrcModel *>*lrcModelArray = [NSMutableArray array];
    [tempArr enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL contains = [str containsString:@"[ti"] || [str containsString:@"[ar"] || [str containsString:@"[al"];
        if (!contains) {
            LrcModel *lrcModel = [[LrcModel alloc] init];
            NSString *resultStr = [str stringByReplacingOccurrencesOfString:@"[" withString:@""];
            tempArr = [resultStr componentsSeparatedByString:@"]"];
            if (tempArr.count  == 2) {
                lrcModel.lrcLabel = tempArr[1];
                lrcModel.startTime = [self getTimewithStr:tempArr[0]];
                [lrcModelArray addObject:lrcModel];
            }
        }
    }];
    NSInteger count = lrcModelArray.count;
    [lrcModelArray enumerateObjectsUsingBlock:^(LrcModel  *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != count - 1) {
            lrcModelArray[idx].endTime = lrcModelArray[idx + 1].startTime;
        }
    }];
    return lrcModelArray;
}
+ (void)getLrcInfo:(NSTimeInterval)currentTime LrcsData:(NSArray<LrcModel *> *)modelData complete:(void (^)(LrcModel *, NSInteger))complete{
    __block LrcModel *model = [[LrcModel alloc] init];
    __block NSInteger row = 0;
    [modelData enumerateObjectsUsingBlock:^(LrcModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (currentTime >= obj.startTime && currentTime <= obj.endTime) {
            row = idx;
            model = obj;
            *stop = YES;
        }
    }];
    complete(model,row);
}
- (NSTimeInterval)getTimewithStr:(NSString *)timeStr{
    NSArray *timeArr = [timeStr componentsSeparatedByString:@":"];
    if (timeArr.count == 2) {
        NSTimeInterval S = [timeArr[0] doubleValue];
        NSTimeInterval M = [timeArr[1] doubleValue];
        return S * 60 + M;
    }
    return 0;
}
@end
