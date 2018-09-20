//
//  KJHelpSecondCell.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHelpSecondCell.h"

@interface KJHelpSecondCell()

@property (nonatomic, strong) UILabel  *nameLabel;//标题
@property (nonatomic, strong) UILabel  *helpLabel;//我要助学
@property (nonatomic, strong) UILabel  *targetLabel;//目标金额
@property (nonatomic, strong) UILabel  *targetDisplayLabel;//显示目标金额
@property (nonatomic, strong) UILabel  *completeLabel;//已达成
@property (nonatomic, strong) UILabel  *completeDisplayLabel;//显示已达成
@property (nonatomic, strong) UILabel  *surplusDayLabel;//剩余天数
@property (nonatomic, strong) UILabel  *surplusDayDisplayLabel;//显示剩余天数
@property (nonatomic, strong) UILabel  *helpNumLabel;//参与人数
@property (nonatomic, strong) UILabel  *helpNumDisplayLabel;//显示参与人数

@property (nonatomic, strong) UIView  *imaginaryLine;// 虚线

@end

@implementation KJHelpSecondCell

- (void)setUI{
    self.backgroundColor = [UIColor whiteColor];
    [KJTools makeCornerRadius:Handle(10) borderColor:MainColor layer:self.layer borderWidth:0.5];
    
    [self.helpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(Handle(10));
        make.right.mas_equalTo(self.contentView).mas_offset(-Handle(10));
        make.height.mas_equalTo(Handle(20));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(Handle(10));
        make.left.mas_equalTo(self.contentView).mas_offset(Handle(10));
        make.right.mas_equalTo(self.helpLabel.mas_left).mas_offset(-Handle(10));
    }];
    [self.imaginaryLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.contentView).mas_offset(Handle(10));
        make.right.mas_equalTo(self.contentView).mas_offset(Handle(25));
        make.height.mas_equalTo(Handle(1));
    }];
    [self.targetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imaginaryLine.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.contentView).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(20));
        make.width.mas_equalTo(Handle(65));
    }];
    [self.targetDisplayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.targetLabel);
        make.left.mas_equalTo(self.targetLabel.mas_right).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(20));
    }];
    [self.completeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.targetLabel.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.contentView).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(20));
        make.width.mas_equalTo(Handle(65));
        make.bottom.mas_equalTo(self.contentView).mas_offset(-Handle(10));
    }];
    [self.completeDisplayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.completeLabel);
        make.left.mas_equalTo(self.completeLabel.mas_right).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(20));
    }];
    [self.surplusDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imaginaryLine.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.contentView.centerX);
        make.height.mas_equalTo(Handle(20));
        make.width.mas_equalTo(Handle(65));
    }];
    [self.surplusDayDisplayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.surplusDayLabel);
        make.left.mas_equalTo(self.surplusDayLabel.mas_right).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(20));
    }];
    [self.helpNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.surplusDayLabel.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.contentView.centerX);
        make.height.mas_equalTo(Handle(20));
        make.width.mas_equalTo(Handle(65));
    }];
    [self.helpNumDisplayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.helpNumLabel);
        make.left.mas_equalTo(self.helpNumLabel.mas_right).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(20));
    }];
    
    [self layoutIfNeeded];
    [self drawImaginaryLine];
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel=InsertLabel(self.contentView, CGRectZero, NSTextAlignmentLeft, @"这里显示名字很长很长的名里显示名字很长很长的名里显示名字很长很长的名字", SystemFontSize(14), DefaultTitleColor);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
- (UILabel*)helpLabel{
    if (!_helpLabel) {
        _helpLabel=InsertLabel(self.contentView, CGRectZero, NSTextAlignmentCenter, @"我要助学", SystemFontSize(12), [UIColor redColor]);
    }
    return _helpLabel;
}
- (UILabel*)targetLabel{
    if (!_targetLabel) {
        _targetLabel = InsertLabel(self.contentView, CGRectZero, NSTextAlignmentCenter, @"目标金额", SystemFontSize(12), [UIColor whiteColor]);
        _targetLabel.backgroundColor = MainColor;
    }
    return _targetLabel;
}
- (UILabel*)completeLabel{
    if (!_completeLabel) {
        _completeLabel = InsertLabel(self.contentView, CGRectZero, NSTextAlignmentCenter, @"已达成", SystemFontSize(12), [UIColor whiteColor]);
        _completeLabel.backgroundColor = MainColor;
    }
    return _completeLabel;
}
- (UILabel*)targetDisplayLabel{
    if (!_targetDisplayLabel) {
        _targetDisplayLabel=InsertLabel(self.contentView, CGRectZero, NSTextAlignmentLeft, @"2000元", SystemFontSize(12), [UIColor blackColor]);
    }
    return _targetDisplayLabel;
}
- (UILabel*)completeDisplayLabel{
    if (!_completeDisplayLabel) {
        _completeDisplayLabel=InsertLabel(self.contentView, CGRectZero, NSTextAlignmentLeft, @"892元", SystemFontSize(12), [UIColor blackColor]);
    }
    return _completeDisplayLabel;
}
- (UILabel*)surplusDayLabel{
    if (!_surplusDayLabel) {
        _surplusDayLabel = InsertLabel(self.contentView, CGRectZero, NSTextAlignmentCenter, @"剩余天数", SystemFontSize(12), [UIColor whiteColor]);
        _surplusDayLabel.backgroundColor = MainColor;
    }
    return _surplusDayLabel;
}
- (UILabel*)surplusDayDisplayLabel{
    if (!_surplusDayDisplayLabel) {
        _surplusDayDisplayLabel=InsertLabel(self.contentView, CGRectZero, NSTextAlignmentLeft, @"100天", SystemFontSize(12), [UIColor blackColor]);
    }
    return _surplusDayDisplayLabel;
}
- (UILabel*)helpNumLabel{
    if (!_helpNumLabel) {
        _helpNumLabel = InsertLabel(self.contentView, CGRectZero, NSTextAlignmentCenter, @"参与人数", SystemFontSize(12), [UIColor whiteColor]);
        _helpNumLabel.backgroundColor = MainColor;
    }
    return _helpNumLabel;
}
- (UILabel*)helpNumDisplayLabel{
    if (!_helpNumDisplayLabel) {
        _helpNumDisplayLabel=InsertLabel(self.contentView, CGRectZero, NSTextAlignmentLeft, @"3000人", SystemFontSize(12), [UIColor blackColor]);
    }
    return _helpNumDisplayLabel;
}
- (UIView*)imaginaryLine{
    if (!_imaginaryLine) {
        _imaginaryLine = InsertView(self.contentView, CGRectZero, [UIColor clearColor]);
    }
    return _imaginaryLine;
}
// 画虚线
- (void)drawImaginaryLine{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:_imaginaryLine.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(_imaginaryLine.frame) / 2, CGRectGetHeight(_imaginaryLine.frame)/2)];
    [shapeLayer setStrokeColor:[UIColor redColor].CGColor];
    [shapeLayer setLineWidth:0.5];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:@[@5,@2]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (CGRectGetWidth(_imaginaryLine.frame) > CGRectGetHeight(_imaginaryLine.frame)) {
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(_imaginaryLine.frame),0);
    }else{
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(_imaginaryLine.frame));
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [_imaginaryLine.layer addSublayer:shapeLayer];
}

@end

