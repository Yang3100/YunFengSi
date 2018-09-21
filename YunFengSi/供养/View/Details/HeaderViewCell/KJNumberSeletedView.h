//
//  KJNumberSeletedView.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//  加减选择器

#import <UIKit/UIKit.h>

@interface KJNumberSeletedView : UIView

@property (nonatomic, assign)int lowI;//最低数字
@property (nonatomic, assign)int HighI;//最高数字
@property (nonatomic, strong)NSString *title;//拼装文字
@property (nonatomic, strong)UILabel *timeLable;//显示数字的区域
@property (nonatomic, assign)int i;//数字b
@property (nonatomic, assign)BOOL HighType;//决定是否有 i人以上   YES为有  NO为没有

@end
