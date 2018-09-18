//
//  KJHelpStudyVC.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHelpStudyVC.h"

@interface KJHelpStudyVC ()

@property(nonatomic,strong) UIView *kj_navigationView;

@end

@implementation KJHelpStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.kj_navigationView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView*)kj_navigationView{
    if (!_kj_navigationView) {
        _kj_navigationView = InsertView(self.view, CGRectMake(0, 0, SCREEN_WIDTH, 64), MainColor);
        UILabel *tit = InsertLabel(nil, CGRectMake(0, 20, SCREEN_WIDTH, 43), NSTextAlignmentCenter, @"助学", SystemFontSize(18), DefaultTitleColor);
        UIView *line = InsertView(nil, CGRectMake(0, 63, SCREEN_WIDTH, 1), DefaultBackgroudColor);
        [_kj_navigationView addSubview:tit];
        [_kj_navigationView addSubview:line];
    }
    return _kj_navigationView;
}


@end
