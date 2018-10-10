//
//  SUSearchBarView.h
//  KJDevelopExample
//
//  Created by 杨科军 on 2017/6/12.
//  Copyright © 2017年 杨科军. All rights reserved.
//  商品首页的搜索view -- V

#import <UIKit/UIKit.h>

@interface SUSearchBarView : UIView
+ (instancetype)searchBarView;
/// 内容tips
@property (nonatomic, readwrite, copy)NSString *tips;
/// 点击回调
@property (nonatomic, readwrite, copy)void(^searchBarViewClicked)(void);

@end
