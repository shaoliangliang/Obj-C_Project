//
//  MusicViewController.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/20.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicInfoModels.h"
#import "MusicPlayerViewController.h"
#import "MusicOpreationTool.h"
static NSString *const listCell = @"cell";
@interface MusicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *musicTableview;

@end

@implementation MusicViewController
- (UITableView *)musicTableview{
    if (!_musicTableview) {
        _musicTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.Navigationbar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
        _musicTableview.delegate = self;
        _musicTableview.dataSource = self;
        [_musicTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:listCell];
        IOS_11_ADJUST(_musicTableview);
    }
    return _musicTableview;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [MusicInfoModels shareInstance].MusicList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [MusicInfoModels shareInstance].MusicList[indexPath.row].name;
    cell.detailTextLabel.text = [MusicInfoModels shareInstance].MusicList[indexPath.row].singer;
    cell.imageView.image = [UIImage imageNamed:[MusicInfoModels shareInstance].MusicList[indexPath.row].icon];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MusicInfoModels shareInstance].currentMusicModel = [MusicInfoModels shareInstance].MusicList[indexPath.row];
    
    [MusicInfoModels shareInstance].LrcList = [[MusicOpreationTool shareInstance] getLrcData:[MusicInfoModels shareInstance].currentMusicModel.name];
    
    [self presentViewController:[MusicPlayerViewController new] animated:YES completion:^{
        [[MusicOpreationTool shareInstance] playMusic:[MusicInfoModels shareInstance].currentMusicModel];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:self.musicTableview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
