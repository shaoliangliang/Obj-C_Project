//
//  SorinNavigationBar.m
//  Obj-C-Project
//
//  Created by 邵亮亮 on 2018/6/15.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "SorinNavigationBar.h"
@interface SorinNavigationBar ()
@property (nonatomic,weak) UIView *leftView;
@property (nonatomic,weak) UIView *rightView;
@property (nonatomic,weak) UIView *titleView;
@property (nonatomic,weak) UIImage *backgroundImage;
@property (nonatomic,weak) UIView *bottomLine;


@end
@implementation SorinNavigationBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)layoutSubviews{
    self.leftView.frame = CGRectMake(0, kStatusBarHeight, self.leftView.frame.size.width, self.leftView.frame.size.height);
    self.rightView.frame = CGRectMake(KScreenWidth - self.rightView.frame.size.width, kStatusBarHeight, self.rightView.frame.size.width, self.rightView.frame.size.height);
    self.titleView.frame = self.titleView.frame;
    self.titleView.center = CGPointMake(self.center.x, self.center.y + kStatusBarHeight / 2);
    self.bottomLine.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5);
}
- (void)setLeftView:(UIView *)leftView{
    [_leftView removeFromSuperview];
    [self addSubview:leftView];
    _leftView = leftView;
    if ([leftView isKindOfClass:[UIButton class]]) {
        UIButton *leftBtn = (UIButton *)leftView;
        [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self layoutIfNeeded];
}
- (void)setRightView:(UIView *)rightView{
    [_rightView removeFromSuperview];
    [self addSubview:rightView];
    _rightView = rightView;
    if ([rightView isKindOfClass:[UIButton class]]) {
        UIButton *rightBtn = (UIButton *)rightView;
        [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self layoutIfNeeded];
}
- (void)setTitleView:(UIView *)titleView{
    [_titleView removeFromSuperview];
    [self addSubview:titleView];
    _titleView = titleView;
    __block BOOL existGesture = NO;
    [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            existGesture = YES;
            *stop = YES;
        }
    }];
    if (!existGesture) {
        UITapGestureRecognizer *tapGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitleView:)];
        [titleView addGestureRecognizer:tapGusture];
    }
    [self layoutIfNeeded];
}
- (void)setBarTitle:(NSMutableAttributedString *)barTitle{
    if ([self respondsToSelector:@selector(sorinNavagationbarMiddleView:)]) {
        return;
    }
    UILabel *Title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.5, 44)];
    Title.backgroundColor = [UIColor clearColor];
    Title.textAlignment = NSTextAlignmentCenter;
    Title.numberOfLines = 0;
    Title.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [Title setAttributedText:barTitle];
    self.titleView = Title;
}
- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    self.layer.contents = backgroundImage;
}
- (UIView *)bottomLine{
    if (!_bottomLine) {
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5)];
        [self addSubview:bottomLine];
        _bottomLine = bottomLine;
        bottomLine.backgroundColor = [UIColor redColor];
    }
    return _bottomLine;
}
- (void)setBarDataSource:(id<SorinNavigationBarDataSource>)barDataSource{
    _barDataSource = barDataSource;
    
    [self setDataSource];
}
- (void)setDataSource{
    if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarLeftView:)]) {
        self.leftView = [self.barDataSource sorinNavagationbarLeftView:self];
    }else if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarLeftBtn:navigationbar:)]){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [btn setImage:[self.barDataSource sorinNavagationbarLeftBtn:btn navigationbar:self] forState:UIControlStateNormal];
        self.leftView = btn;
    }
    
    if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarMiddleView:)]) {
        self.titleView = [self.barDataSource sorinNavagationbarMiddleView:self];
    }else if ([self.barDataSource respondsToSelector:@selector(SorinNavigationBarTitle:)]){
        self.barTitle = [self.barDataSource SorinNavigationBarTitle:self];
    }
    
    if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarRightView:)]) {
        self.rightView = [self.barDataSource sorinNavagationbarRightView:self];
    }else if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarRightBtn:navigationbar:)]){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [btn setImage:[self.barDataSource sorinNavagationbarRightBtn:btn navigationbar:self] forState:UIControlStateNormal];
        self.rightView = btn;
    }
    
    if ([self.barDataSource respondsToSelector:@selector(SorinNavigationBarHeight:)]) {
        CGRect frame = self.frame;
        frame.size.height = [self.barDataSource SorinNavigationBarHeight:self];
        self.frame = frame;
    }else{
        CGRect frame = self.frame;
        frame.size.height = kStatusBarHeight + 44;
        self.frame = frame;
    }
    
    if ([self.barDataSource respondsToSelector:@selector(isHiddenNavigationbarBottomline:)]) {
        self.bottomLine.hidden = [self.barDataSource isHiddenNavigationbarBottomline:self];
    }
    
    if ([self.barDataSource respondsToSelector:@selector(SorinNavigationBarBackgroundColor:)]) {
        self.backgroundColor = [self.barDataSource SorinNavigationBarBackgroundColor:self];
    }
    
    if ([self.barDataSource respondsToSelector:@selector(SorinNavigationBarBackgroundImage:)]) {
        self.backgroundImage = [self.barDataSource SorinNavigationBarBackgroundImage:self];
    }
}
- (void)clickLeftBtn:(UIButton *)sender{
    if ([self.barDelegate respondsToSelector:@selector(leftClickEvent:navigationbar:)]) {
        [self.barDelegate leftClickEvent:sender navigationbar:self];
    }
}
- (void)clickRightBtn:(UIButton *)sender{
    if ([self.barDelegate respondsToSelector:@selector(rightClickEvent:navigationbar:)]) {
        [self.barDelegate rightClickEvent:sender navigationbar:self];
    }
}
- (void)tapTitleView:(UITapGestureRecognizer *)Gusture{
    UIButton *btn = (UIButton *)Gusture.view;
    if ([self.barDelegate respondsToSelector:@selector(titleViewClickEvent:navigationbar:)]) {
        [self.barDelegate titleViewClickEvent:btn navigationbar:self];
    }
}
- (void)initUI{
    self.backgroundColor = [UIColor lightGrayColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
