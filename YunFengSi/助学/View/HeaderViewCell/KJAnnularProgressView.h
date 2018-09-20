//
//  KJAnnularProgressView.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//  助学 - 详情 - 环形进度条展示界面

#import <UIKit/UIKit.h>

@interface KJAnnularProgressView : UIView

+ (instancetype)createViewFromData:(NSObject*)model Size:(void(^)(CGSize size))block;

@end
