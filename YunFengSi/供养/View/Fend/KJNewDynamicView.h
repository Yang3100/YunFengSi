//
//  KJNewDynamicView.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//  最新动态

#import <UIKit/UIKit.h>

@interface KJNewDynamicView : UIView

+ (instancetype)createNewDynamicViewFromData:(NSObject*)model Size:(void(^)(CGSize size))block;

@end
