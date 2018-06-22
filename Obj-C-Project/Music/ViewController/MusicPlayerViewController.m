//
//  MusicPlayerViewController.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/22.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "MusicInfoModels.h"
#import "LrcView.h"
#import "MusicOpreationTool.h"
@interface MusicPlayerViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *backgroundIma;

@property (nonatomic,strong) UIImageView *singerIma;

@property (nonatomic,strong) LrcView *lrcView;

@property (nonatomic,strong) UIVisualEffectView *effectView;

@property (nonatomic,strong) UIButton *pauseBtn;

@property (nonatomic,strong) CADisplayLink *displayLink;

@end
enum {
    preMucic = 0,
    pauseMusic,
    nextMusic
};
@implementation MusicPlayerViewController

- (UIImageView *)backgroundIma{
    if (!_backgroundIma) {
        _backgroundIma = [[UIImageView alloc] initWithFrame:self.view.frame];
        [_backgroundIma addSubview:self.effectView];
    }
    return _backgroundIma;
}
- (UIVisualEffectView *)effectView{
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithFrame:self.backgroundIma.frame];
        _effectView.effect = effect;
    }
    return _effectView;
}
- (UIImageView *)singerIma{
    if (!_singerIma) {
        CGFloat width = (self.view.frame.size.width - 20 );
        _singerIma = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.Navigationbar.frame.size.height + 10, width, width)];
        _singerIma.layer.masksToBounds = YES;
        _singerIma.layer.cornerRadius = width / 2;
        _singerIma.center = self.view.center;
    }
    return _singerIma;
}
- (LrcView *)lrcView{
    if (!_lrcView) {
        _lrcView = [[LrcView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
        _lrcView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
        _lrcView.pagingEnabled = YES;
        _lrcView.showsHorizontalScrollIndicator = NO;
    }
    return _lrcView;
}
- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrc)];
    }
    return _displayLink;
}
- (void)updateLrc{
    NSTimeInterval currentTime = CMTimeGetSeconds([MusicOpreationTool shareInstance].musicPlayer.currentTime);
    [MusicOpreationTool getLrcInfo:currentTime LrcsData:[MusicInfoModels shareInstance].LrcList complete:^(LrcModel *model, NSInteger currentRow) {
        self.lrcView.row = currentRow;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundIma];
    
    [self.view addSubview:self.singerIma];
    
    [self.view addSubview:self.lrcView];
    
    self.lrcView.delegate = self;
    
    [self addControlKey];
    
    [self updateMusicUI];
    
}

- (void)addControlKey{
    UIButton *preBtn = [self creatBtnWithFrame:CGRectMake(50, self.view.frame.size.height - 80, 30, 30) normalIma:@"上一首" hightIma:@"nil" selectIma:@"nil"];
    preBtn.tag = preMucic;
    [self.view addSubview:preBtn];
    
    UIButton *nextBtn = [self creatBtnWithFrame:CGRectMake(self.view.frame.size.width - 80, self.view.frame.size.height - 80, 30, 30) normalIma:@"下一首" hightIma:@"nil" selectIma:@"nil"];
    nextBtn.tag = nextMusic;
    [self.view addSubview:nextBtn];
    
    self.pauseBtn = [self creatBtnWithFrame:CGRectMake((self.view.frame.size.width - 48) / 2, self.view.frame.size.height - 89, 48, 48) normalIma:@"播放" hightIma:@"nil" selectIma:@"暂停"];
    self.pauseBtn.tag = pauseMusic;
    [self.view addSubview:self.pauseBtn];
}
- (UIButton *)creatBtnWithFrame:(CGRect)frame normalIma:(NSString *)imaName hightIma:(NSString *)hightName selectIma:(NSString *)selectName{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:imaName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hightName] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:selectName] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clickMusicStatus:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)clickMusicStatus:(UIButton *)sender{
    if (sender.tag == preMucic) {
        [[MusicOpreationTool shareInstance] playPrevious];
        [self updateMusicUI];
    }if (sender.tag == nextMusic) {
        [[MusicOpreationTool shareInstance] playNext];
        [self updateMusicUI];
    }if (sender.tag == pauseMusic) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            [[MusicOpreationTool shareInstance] playMusic];
            [self resumeAnimation];
        }else{
            [[MusicOpreationTool shareInstance] pauseMusic];
            [self pauseAnimation];
        }
    }
}
- (void)startAnimation{
    [self.singerIma.layer removeAnimationForKey:@"key"];
    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    transform.fromValue = 0;
    transform.toValue = @(M_PI * 2);
    transform.duration = 60;
    transform.repeatCount = MAXFLOAT;
    transform.removedOnCompletion = NO;
    self.singerIma.layer.speed = 1;
    [self.singerIma.layer addAnimation:transform forKey:@"key"];
}
- (void)pauseAnimation{
    CFTimeInterval pauseTime = [self.singerIma.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.singerIma.layer.timeOffset = pauseTime;
    self.singerIma.layer.speed = 0;
}
-(void)resumeAnimation{
    CFTimeInterval pauseTime = self.singerIma.layer.timeOffset;
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    [self.singerIma.layer setTimeOffset:0];
    [self.singerIma.layer setBeginTime:begin];
    self.singerIma.layer.speed = 1;
}
- (void)updateMusicUI{
    self.backgroundIma.image = [UIImage imageNamed:[[MusicInfoModels shareInstance] currentMusicModel].icon];
    
    self.singerIma.image = [UIImage imageNamed:[[MusicInfoModels shareInstance] currentMusicModel].singerIcon];
    
    [self.lrcView setLrcArray:[MusicInfoModels shareInstance].LrcList];
    
    self.Navigationbar.barTitle = [self barTitle];
    
    self.pauseBtn.selected = [MusicOpreationTool shareInstance].isPlaying;
    
    [self startAnimation];
    
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat alpha = scrollView.contentOffset.x / self.view.frame.size.width;
    self.singerIma.alpha = 1 - alpha;
    self.lrcView.lrcsList.alpha =  alpha;
}
- (UIView *)sorinNavagationbarLeftView:(SorinNavigationBar *)navigationBar{
    UIButton *pop = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 30, 30)];
    [pop setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    return pop;
}
- (void)leftClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavigationBar *)navigationbar{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSMutableAttributedString *)SorinNavigationBarTitle:(SorinNavigationBar *)navigationBar{
    
    return [self barTitle];
}
- (NSMutableAttributedString *)barTitle{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[[MusicInfoModels shareInstance] currentMusicModel].name,[[MusicInfoModels shareInstance] currentMusicModel].singer]];
    [title addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:16.0]
                  range:NSMakeRange(0, [[MusicInfoModels shareInstance] currentMusicModel].name.length)];
    [title addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:10.0]
                  range:NSMakeRange([[MusicInfoModels shareInstance] currentMusicModel].name.length + 1,[[MusicInfoModels shareInstance] currentMusicModel].singer.length)];
    return title;
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
