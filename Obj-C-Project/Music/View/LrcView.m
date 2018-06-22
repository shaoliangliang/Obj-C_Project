//
//  LrcView.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/22.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "LrcView.h"
static NSString *const cellID = @"cellID";
@interface LrcView()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation LrcView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.lrcsList = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)style:UITableViewStylePlain];
        self.lrcsList.delegate = self;
        self.lrcsList.dataSource = self;
        [self.lrcsList registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        self.lrcsList.backgroundColor = [UIColor clearColor];
        self.lrcsList.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.lrcsList];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.LrcArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.LrcArray[indexPath.row].lrcLabel;
    return cell;
}
- (void)setLrcArray:(NSArray<LrcModel *> *)LrcArray{
    _LrcArray = LrcArray;
    [self.lrcsList reloadData];
}
- (void)setRow:(NSInteger)row{
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.lrcsList scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    UITableViewCell *cell = [self.lrcsList cellForRowAtIndexPath:path];
    cell.textLabel.textColor = [UIColor greenColor];
}


@end
