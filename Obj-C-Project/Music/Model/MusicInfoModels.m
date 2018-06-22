//
//  MusicInfoModels.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/21.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicInfoModels.h"

@implementation MusicInfoModels
+ (instancetype)shareInstance{
    static MusicInfoModels *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[MusicInfoModels alloc] init];
    });
    return share;
}
- (NSMutableArray <MusicModel *>*)MusicList{
    if (!_MusicList) {
        _MusicList = [NSMutableArray array];
        NSString *list = [[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil];
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:list];
        for (int i = 0; i < array.count;i ++) {
            [_MusicList addObject:[MusicModel objModelWithData:array[i]]];
        }
    }
    return _MusicList;
}
@end
