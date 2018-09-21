//
//  KJHelpDetailHeaderCell.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHelpDetailHeaderCell.h"
#import "KJHelpDetailHeaderView.h"

@implementation KJHelpDetailHeaderCell

- (void)setModel:(NSObject *)model{
    __block CGSize HeaderViewSize;
    KJHelpDetailHeaderView *headerView = [KJHelpDetailHeaderView createHelpDetailHeaderViewFromData:nil Size:^(CGSize size){
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
