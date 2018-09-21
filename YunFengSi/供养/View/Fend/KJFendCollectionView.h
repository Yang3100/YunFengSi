//
//  KJFendCollectionView.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//  供养CollectionView

#import <UIKit/UIKit.h>

@interface KJFendCollectionView : UIView

- (void)getHeight:(CGFloat)height Data:(NSObject*)model;

/// 点击回调
@property (nonatomic, readwrite, copy)void(^FendCollectionViewClicked)(NSInteger index);

@end
