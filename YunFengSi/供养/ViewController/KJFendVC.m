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

#import "KJDetailsVC.h"

@interface KJFendVC ()

@end

@implementation KJFendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DefaultBackgroudColor;
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI{
    __block CGSize HeaderViewSize;
    KJNewDynamicView *headerView = [KJNewDynamicView createNewDynamicViewFromData:nil Size:^(CGSize size){
        HeaderViewSize = size;
    }];
    
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.view).mas_offset(Handle(64));
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(HeaderViewSize.width);
        make.height.mas_equalTo(HeaderViewSize.height);
    }];
    
    KJFendCollectionView *fendCollectionView = [[KJFendCollectionView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:fendCollectionView];
    [fendCollectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(headerView.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_equalTo(self.view).mas_offset(-Handle(40));
    }];
    
    // 点击item的事件 - 跳转到详情界面
    @weakify(self);
    fendCollectionView.FendCollectionViewClicked = ^(NSInteger index) {
        @strongify(self);
        KJDetailsVC *vc = [[KJDetailsVC alloc]init];
        vc.view.backgroundColor = DefaultBackgroudColor;
        vc.navigationItem.title = [NSString stringWithFormat:@"%ld",(long)index];
        
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    // 先调用superView的layoutIfNeeded方法再获取frame
    [self.view layoutIfNeeded];
    CGFloat h = CGRectGetHeight(fendCollectionView.frame);
    [fendCollectionView getHeight:h Data:nil];
}

@end
