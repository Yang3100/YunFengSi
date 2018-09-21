//
//  KJDetailsHeaderView.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//  详情头像部分

#import "KJDetailsHeaderView.h"

#import "KJDisplayCollectionView.h"
#import "KJNumberSeletedView.h" // 加减选择器

@interface KJDetailsHeaderView()

@property (nonatomic, strong)UIImageView *headerImageView;//头像
@property (nonatomic, strong)UILabel  *nameLabel;//名称
@property (nonatomic, strong)UILabel  *priceLabel;//价格
@property (nonatomic, strong)KJDisplayCollectionView  *priceView;//价格
@property (nonatomic, strong)UIButton *moreButton;//随喜金额
@property (nonatomic, strong)UILabel  *numLabel;//数量
@property (nonatomic, strong)KJNumberSeletedView  *NumberSeletedView;//数量选择
@property (nonatomic, strong)UITextView  *remarkTextView;//备注
@property (nonatomic, strong)UIButton *fendButton;//供养
@property (nonatomic, strong)UILabel  *introLabel;//简介

@end

@implementation KJDetailsHeaderView

+ (instancetype)createDetailsHeaderViewFromData:(NSObject*)model Size:(void(^)(CGSize size))block{
    KJDetailsHeaderView *backView = [[self alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    
    if (block){
        block([backView getViewSizeFrom:model]);
    }
    return backView;
}

- (CGSize)getViewSizeFrom:(NSObject*)model{
    //    KJContentModel *k = (KJContentModel*)model;
    
    [self setUI];
    
    // 先调用superView的layoutIfNeeded方法再获取frame
    [self layoutIfNeeded];
    CGFloat h = CGRectGetHeight(self.introLabel.frame)+ self.introLabel.frame.origin.y;
    return CGSizeMake(SCREEN_WIDTH, h);
}

- (void)btnClick:(UIButton*)sender{
    NSLog(@"more");
}


- (void)setUI{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(15));
        make.width.height.mas_equalTo(Handle(100));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(Handle(10));
        make.right.mas_equalTo(self).mas_offset(-Handle(10));
        make.centerY.mas_equalTo(self.headerImageView);
        make.height.mas_equalTo(20);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(Handle(10));
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.headerImageView.mas_bottom).mas_offset(-Handle(2));
    }];
    [self addSubview:self.priceView];
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.headerImageView.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(Handle(100));
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.priceView.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.width.mas_equalTo(SCREEN_WIDTH-Handle(20));
        make.height.mas_equalTo(Handle(30));
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.moreButton.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(20));
    }];
    [self addSubview:self.NumberSeletedView];
    [self.NumberSeletedView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.numLabel.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(30));
        make.width.mas_equalTo(SCREEN_WIDTH/4);
    }];
    [self addSubview:self.remarkTextView];
    [self.remarkTextView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.moreButton.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.NumberSeletedView.mas_right).mas_offset(Handle(10));
        make.bottom.mas_equalTo(self.NumberSeletedView.mas_bottom).mas_offset(Handle(5));
        make.right.mas_equalTo(self).mas_offset(-Handle(10));
    }];
    [self.fendButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.NumberSeletedView.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.width.mas_equalTo(SCREEN_WIDTH-Handle(20));
        make.height.mas_equalTo(Handle(40));
    }];
    [self.introLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.fendButton.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.width.mas_equalTo(SCREEN_WIDTH-Handle(20));
    }];
}

- (UIImageView*)headerImageView{
    if (!_headerImageView){
        _headerImageView = InsertImageView(self, CGRectZero, GetImage(@"timg1"));
    }
    return _headerImageView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel){
        _nameLabel=InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"这里显示名字很长很长的名字", SystemFontSize(14), DefaultTitleColor);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
- (UILabel*)priceLabel{
    if (!_priceLabel){
        _priceLabel=InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"￥500", SystemFontSize(12), MainColor);
    }
    return _priceLabel;
}
- (KJDisplayCollectionView*)priceView{
    if (!_priceView){
        _priceView = [[KJDisplayCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Handle(100))];
    }
    return _priceView;
}
- (UIButton*)moreButton{
    if (!_moreButton){
        _moreButton = InsertImageButton(self, CGRectZero, 520, nil, nil, self, @selector(btnClick:));
        _moreButton.adjustsImageWhenHighlighted = NO;
        _moreButton.backgroundColor = DefaultBackgroudColor;
        [_moreButton setTitle:@"随喜捐赠(元)" forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_moreButton setTitleColor:UIColorFromHEXA(0x888888,1.0)forState:UIControlStateNormal];
    }
    return _moreButton;
}
- (UILabel*)numLabel{
    if (!_numLabel){
        _numLabel=InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"数量", SystemFontSize(15), MainColor);
    }
    return _numLabel;
}
- (KJNumberSeletedView*)NumberSeletedView{
    if (!_NumberSeletedView){
        //设置预约人数选择器
        KJNumberSeletedView *personView = [[KJNumberSeletedView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, Handle(30))];
        personView.lowI = 1;
        personView.HighI = 100;
        personView.title = @"";
        personView.HighType = YES;
        [KJTools makeCornerRadius:Handle(1)borderColor:DefaultBackgroudColor layer:personView.layer borderWidth:1];
        _NumberSeletedView = personView;
    }
    return _NumberSeletedView;
}
- (UITextView *)remarkTextView{
    if (!_remarkTextView){
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
        textView.font = [UIFont systemFontOfSize:14];
        //文字设置居右、placeHolder会跟随设置
        textView.textAlignment = NSTextAlignmentLeft;
        textView.zw_placeHolder = @"(请输入申请人和祈福内容,50字内)";
        textView.zw_limitCount = 50;
        textView.zw_labHeight = 12;
        textView.zw_labMargin = 5;
        textView.zw_labFont = [UIFont systemFontOfSize:12];
        textView.zw_placeHolderColor = [UIColor blackColor];
        [KJTools makeCornerRadius:Handle(5)borderColor:DefaultBackgroudColor layer:textView.layer borderWidth:1];
        _remarkTextView = textView;
    }
    return _remarkTextView;
}

- (UIButton*)fendButton{
    if (!_fendButton){
        _fendButton = InsertImageButton(self, CGRectZero, 521, nil, nil, self, @selector(btnClick:));
        _fendButton.adjustsImageWhenHighlighted = NO;
        _fendButton.backgroundColor = MainColor;
        [_fendButton setTitle:@"供养" forState:UIControlStateNormal];
        [_fendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _fendButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [KJTools makeCornerRadius:Handle(5)borderColor:DefaultBackgroudColor layer:_fendButton.layer borderWidth:0];
    }
    return _fendButton;
}
- (UILabel*)introLabel{
    if (!_introLabel){
        _introLabel=InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"简介:很长很长的简介,我也不想打了!!就随便打一些汉字来表示一下简介吧~~~~", SystemFontSize(14), [UIColor blackColor]);
        _introLabel.backgroundColor = DefaultBackgroudColor;
        _introLabel.numberOfLines = 0;
    }
    return _introLabel;
}



@end
