//
//  KJFendCollectionView.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//  供养CollectionView

#import <UIKit/UIKit.h>

@interface KJFendCollectionView : UIView

//+ (instancetype)createFendCollectionViewFromData:(NSObject*)model Size:(void(^)(CGSize size))block;

- (void)getHeight:(CGFloat)height Data:(NSObject*)model;

@end
