//
//  KJHelpDetailHeaderView.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface KJHelpDetailHeaderView : UIView

+ (instancetype)createHelpDetailHeaderViewFromData:(NSObject*)model Size:(void(^)(CGSize size))block;

@end

