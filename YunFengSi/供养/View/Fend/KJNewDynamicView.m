//
//  KJNewDynamicView.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJNewDynamicView.h"

@interface KJNewDynamicView()

@property (nonatomic, strong) UIImageView *newDynamicImageView;//头像

@end

@implementation KJNewDynamicView

+ (instancetype)createNewDynamicViewFromData:(NSObject*)model Size:(void(^)(CGSize size))block{
    KJNewDynamicView *backView = [[self alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    
    [KJTools makeCornerRadius:Handle(10) borderColor:DefaultBackgroudColor layer:backView.layer borderWidth:0.5];
    
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
    CGFloat h = Handle(10) + CGRectGetHeight(self.newDynamicImageView.frame) + Handle(9);
    return CGSizeMake(SCREEN_WIDTH, h);
}

- (void)setUI{
    [self.newDynamicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(15));
        make.width.height.mas_equalTo(Handle(40));
    }];
}

- (UIImageView*)newDynamicImageView{
    if (!_newDynamicImageView) {
        _newDynamicImageView = InsertImageView(self, CGRectZero, GetImage(@"zuixindongtai"));
    }
    return _newDynamicImageView;
}


@end
