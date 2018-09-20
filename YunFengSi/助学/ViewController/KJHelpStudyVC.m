//
//  KJHelpStudyVC.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHelpStudyVC.h"
#import "KJNewDynamicView.h"
#import "KJHelpStudyTableView.h"

@interface KJHelpStudyVC ()

@property(nonatomic,strong) UIView *changeView;

@end

@implementation KJHelpStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DefaultBackgroudColor;
    
    [self setUI];
}

- (void)btnClick:(UIButton*)sender{
    NSLog(@"more");
}

- (void)setUI{
    __block CGSize HeaderViewSize;
    KJNewDynamicView *headerView = [KJNewDynamicView createNewDynamicViewFromData:nil Size:^(CGSize size) {
        HeaderViewSize = size;
    }];
    
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(Handle(64));
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(HeaderViewSize.width);
        make.height.mas_equalTo(HeaderViewSize.height);
    }];
    
    [self.changeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom).mas_offset(Handle(10));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    KJHelpStudyTableView *helpTableView = [[KJHelpStudyTableView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:helpTableView];
    [helpTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.changeView.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(Handle(5));
        make.right.mas_equalTo(self.view).mas_offset(-Handle(5));
        make.bottom.mas_equalTo(self.view).mas_offset(-Handle(40));
    }];
    
    // 先调用superView的layoutIfNeeded方法再获取frame
    [self.view layoutIfNeeded];
    CGFloat h = CGRectGetHeight(helpTableView.frame);
    [helpTableView getHeight:h];
}

- (UIView*)changeView{
    if (!_changeView) {
        _changeView = InsertView(self.view, CGRectZero, self.view.backgroundColor);
        
        UIButton*_moreButton = InsertImageButton(_changeView, CGRectZero, 520, nil, nil, self, @selector(btnClick:));
        _moreButton.adjustsImageWhenHighlighted = NO;
        _moreButton.backgroundColor = DefaultBackgroudColor;
        [_moreButton setTitle:@"换一换" forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_moreButton setTitleColor:UIColorFromHEXA(0x888888,1.0) forState:UIControlStateNormal];
        [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self->_changeView);
            make.centerY.mas_equalTo(self->_changeView);
        }];
    }
    return _changeView;
}


@end
