//
//  MusicModel.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/21.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel
+ (MusicModel *)objModelWithData:(id)DataSource{
    if (DataSource) {
        NSDictionary *musicData = (NSDictionary *)DataSource;
        MusicModel *musicModel = [[MusicModel alloc] init];
        musicModel.name = musicData[@"name"];
        musicModel.icon = musicData[@"singerIcon"];
        musicModel.lrcname = musicData[@"lrcname"];
        musicModel.singer = musicData[@"singer"];
        musicModel.filename = musicData[@"filename"];
        musicModel.singerIcon = musicData[@"icon"];
        return musicModel;
    }
    return nil;
}
@end
