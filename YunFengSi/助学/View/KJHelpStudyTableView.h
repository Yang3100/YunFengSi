//
//  KJHelpStudyTableView.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJHelpStudyTableView : UIView

- (void)getHeight:(CGFloat)height;

/// 点击回调
@property (nonatomic, readwrite, copy)void(^HelpStudyTableViewClicked)(NSInteger index);


@end
