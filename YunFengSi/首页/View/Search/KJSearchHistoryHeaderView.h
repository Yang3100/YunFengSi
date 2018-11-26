//
//  KJSearchHistoryHeaderView.h
//  UTrading
//
//  Created by lx on 2018/4/23.
//  Copyright © 2018年 cqgk.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KJSearchHistoryHeaderView;

@protocol KJSearchHistoryHeaderViewDelegate <NSObject>
/// 删除按钮
- (void)searchHistoryHeaderViewDidClickedDeleteItem:(KJSearchHistoryHeaderView *)searchHistoryHeaderView;
@end

@interface KJSearchHistoryHeaderView : UICollectionReusableView

/// delegate
@property (nonatomic , readwrite , weak)id <KJSearchHistoryHeaderViewDelegate>delegate;

@end
