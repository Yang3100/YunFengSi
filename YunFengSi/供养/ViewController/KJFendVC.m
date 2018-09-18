//
//  KJFendVC.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJFendVC.h"

#import "KJNewDynamicView.h"
#import "KJFendCollectionView.h"

@interface KJFendVC ()

@property(nonatomic,strong) UIView *kj_navigationView;

@end

@implementation KJFendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DefaultBackgroudColor;
    [self.view addSubview:self.kj_navigationView];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI{
    __block CGSize HeaderViewSize;
    KJNewDynamicView *headerView = [KJNewDynamicView createNewDynamicViewFromData:nil Size:^(CGSize size) {
        HeaderViewSize = size;
    }];
    
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.kj_navigationView.bottom);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(HeaderViewSize.width);
        make.height.mas_equalTo(HeaderViewSize.height);
    }];
    
    KJFendCollectionView *fendCollectionView = [[KJFendCollectionView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:fendCollectionView];
    [fendCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_equalTo(self.view).mas_offset(-Handle(40));
    }];
    
    // 先调用superView的layoutIfNeeded方法再获取frame
    [self.view layoutIfNeeded];
    CGFloat h = CGRectGetHeight(fendCollectionView.frame);
    [fendCollectionView getHeight:h Data:nil];
    
}

- (UIView*)kj_navigationView{
    if (!_kj_navigationView) {
        _kj_navigationView = InsertView(self.view, CGRectMake(0, 0, SCREEN_WIDTH, 64), MainColor);
        UILabel *tit = InsertLabel(nil, CGRectMake(0, 20, SCREEN_WIDTH, 43), NSTextAlignmentCenter, @"供养", SystemFontSize(18), DefaultTitleColor);
        UIView *line = InsertView(nil, CGRectMake(0, 63, SCREEN_WIDTH, 1), DefaultBackgroudColor);
        [_kj_navigationView addSubview:tit];
        [_kj_navigationView addSubview:line];
    }
    return _kj_navigationView;
}


@end
