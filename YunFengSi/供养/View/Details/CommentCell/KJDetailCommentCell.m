//
//  KJDetailCommentCell.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJDetailCommentCell.h"
//#import "KJDetailCommentView.h"

@interface KJDetailCommentCell()

@property(nonatomic,strong) UIView *line;  //
@property(nonatomic,strong) UIImageView *headerImageView;  //
@property(nonatomic,strong) UILabel *timeLabel;  // 时间
@property(nonatomic,strong) UILabel *nameLabel;  // 名字
@property(nonatomic,strong) UILabel *commentLabel;  // 标题

@end

@implementation KJDetailCommentCell

#pragma mark - setUI
-  (void)setUI{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(Handle(1));
    }];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).mas_offset(Handle(8));
        make.left.mas_equalTo(self).mas_offset(Handle(15));
        make.width.height.mas_equalTo(Handle(37));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).mas_offset(Handle(11));
        make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(Handle(6));
        make.right.mas_equalTo(self).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(15));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(Handle(6));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(Handle(10));
        make.right.mas_equalTo(self).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(15));
    }];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).mas_offset(Handle(6));
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(Handle(10));
        make.right.mas_equalTo(self).mas_offset(Handle(-15));
        make.bottom.mas_equalTo(self).mas_offset(Handle(-11));
    }];
}

- (UIView*)line{
    if (!_line) {
        _line = InsertView(self, CGRectZero, UIColorFromHEXA(0xe8e4e4,1.0));
    }
    return _line;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"77", SystemFontSize(14), UIColorFromHEXA(0x8b8b8b,1.0));
        _nameLabel.numberOfLines = 1;
    }
    return _nameLabel;
}

- (UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel = InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"2018:09:17", SystemFontSize(12), UIColorFromHEXA(0x8b8b8b,1.0));
        _timeLabel.numberOfLines = 1;
    }
    return _timeLabel;
}

- (UILabel*)commentLabel{
    if (!_commentLabel) {
        _commentLabel = InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"大卡司教大家师大计算机了", SystemFontSize(12), UIColorFromHEXA(0x8b8b8b,1.0));
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}

- (UIImageView*)headerImageView{
    if (!_headerImageView) {
        _headerImageView = InsertImageView(self, CGRectZero, DefaultHeaderImage);
        _headerImageView.layer.cornerRadius = Handle(37)/2;
        _headerImageView.layer.masksToBounds = YES;
    }
    return _headerImageView;
}


@end
