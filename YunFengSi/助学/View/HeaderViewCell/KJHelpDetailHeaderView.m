//
//  KJHelpDetailHeaderView.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHelpDetailHeaderView.h"
#import "KJAnnularProgressView.h"

@interface KJHelpDetailHeaderView()<SDCycleScrollViewDelegate>

@property(nonatomic,strong) SDCycleScrollView *bannerView;
@property(nonatomic,strong) KJAnnularProgressView *annularProgressView;

@end

@implementation KJHelpDetailHeaderView

+ (instancetype)createHelpDetailHeaderViewFromData:(NSObject*)model Size:(void(^)(CGSize size))block{
    KJHelpDetailHeaderView *backView = [[self alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    
    if (block) {
        block([backView getViewSizeFrom:model]);
    }
    return backView;
}

- (CGSize)getViewSizeFrom:(NSObject*)model{
    //    KJContentModel *k = (KJContentModel*)model;
    
    [self setUI];
    
    // 先调用superView的layoutIfNeeded方法再获取frame
    [self layoutIfNeeded];
    CGFloat h = Handle(10) + CGRectGetHeight(self.bannerView.frame) + Handle(10) + CGRectGetHeight(self.annularProgressView.frame);
    return CGSizeMake(SCREEN_WIDTH, h);
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}


#pragma mark - setUI
- (void)setUI{
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.right.mas_equalTo(self).mas_offset(Handle(-10));
        make.height.mas_equalTo((SCREEN_WIDTH-20)/2);
    }];
    
    __block CGSize ViewSize;
    self.annularProgressView = [KJAnnularProgressView createViewFromData:nil Size:^(CGSize size) {
        ViewSize = size;
    }];
    [self addSubview:_annularProgressView];
    [_annularProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerView.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(ViewSize.width);
        make.height.mas_equalTo(ViewSize.height);
    }];
    

}

- (SDCycleScrollView *)bannerView{
    if (!_bannerView) {
        // 情景一：采用本地图片实现
        NSArray *imageNames = @[@"tu1",
                                @"tu2",
                                @"tu3" // 本地图片请填写全名
                                ];
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        _bannerView.delegate = self;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
         //  轮播时间间隔，默认1.0秒，可自定义
        _bannerView.autoScrollTimeInterval = 2.0;
        [self addSubview:_bannerView];
    }
    return _bannerView;
}

@end
