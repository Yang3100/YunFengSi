//
//  KJDetailsHeaderCell.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJDetailsHeaderCell.h"
#import "KJDetailsHeaderView.h"

@implementation KJDetailsHeaderCell

- (void)setModel:(KJDetailHeaderModel *)model{
    __block CGSize HeaderViewSize;
    KJDetailsHeaderView *headerView = [KJDetailsHeaderView createDetailsHeaderViewFromData:nil Size:^(CGSize size){
        HeaderViewSize = size;
    }];

    [self.contentView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.width.mas_equalTo(HeaderViewSize.width);
        make.height.mas_equalTo(HeaderViewSize.height);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

@end
