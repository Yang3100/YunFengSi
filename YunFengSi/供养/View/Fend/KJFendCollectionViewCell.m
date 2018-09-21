//
//  KJFendCollectionViewCell.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJFendCollectionViewCell.h"

@interface KJFendCollectionViewCell()

@property (nonatomic, strong)UIImageView *headerImageView;//头像
@property (nonatomic, strong)UILabel  *nameLabel;//名称
@property (nonatomic, strong)UILabel  *priceLabel;//价格

@end

@implementation KJFendCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [KJTools makeCornerRadius:Handle(10)borderColor:MainColor layer:self.layer borderWidth:1];
        [self setUI];
    }
    
    return self;
}

- (void)setUI{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.contentView).mas_offset(Handle(10));
        make.centerX.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(self.contentView.frame.size.width/2);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.headerImageView.mas_bottom).mas_offset(Handle(10));
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.frame.size.width - 20);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(self.contentView).mas_offset(-Handle(10));
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
}

- (UIImageView*)headerImageView{
    if (!_headerImageView){
        _headerImageView = InsertImageView(self.contentView, CGRectZero, DefaultHeaderImage);
        [KJTools makeCornerRadius:Handle(20)borderColor:DefaultBackgroudColor layer:_headerImageView.layer borderWidth:0.5];
    }
    return _headerImageView;
}
- (UILabel*)nameLabel{
    if (!_nameLabel){
        _nameLabel=InsertLabel(self.contentView, CGRectZero, NSTextAlignmentCenter, @"这里显示名字很长很长的名字", SystemFontSize(14), DefaultTitleColor);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
- (UILabel*)priceLabel{
    if (!_priceLabel){
        _priceLabel=InsertLabel(self.contentView, CGRectZero, NSTextAlignmentCenter, @"￥500", SystemFontSize(12), MainColor);
    }
    return _priceLabel;
}


@end
