//
//  KJSearchTitleView.m
//  UTrading
//
//  Created by lx on 2018/4/23.
//  Copyright © 2018年 cqgk.com. All rights reserved.
//

#import "KJSearchTitleView.h"

@interface KJSearchTitleView ()

/// textField
@property (nonatomic , readwrite , weak)UITextField *textField;
@end

@implementation KJSearchTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        // 初始化
        [self _setup];
        // 创建自控制器
        [self _setupSubViews];
        // 布局子控件
        [self _makeSubViewsConstraints];
    }
    return self;
}


#pragma mark - Private Method
- (void)_setup{
    
}

#pragma mark - 创建自控制器
- (void)_setupSubViews{
    /// 搜索框
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = UIColorHexFromRGB(0xF9F9F9);
    textField.placeholder = @"搜索";
    textField.font = KJRegularFont_14;
    textField.textColor = UIColorHexFromRGB(0x333333);
    textField.textAlignment = NSTextAlignmentLeft;
    UIButton *leftView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    [leftView setImage:GetImage(@"add_gragy")forState:UIControlStateNormal];
    leftView.backgroundColor = textField.backgroundColor;
    textField.layer.cornerRadius = leftView.layer.cornerRadius = 14;
    textField.layer.masksToBounds = leftView.layer.masksToBounds = YES;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField = textField;
    [self addSubview:textField];
    
    textField.returnKeyType = UIReturnKeySearch;
    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(28);
    }];
}

/// 适配 IOS 11
-(CGSize)intrinsicContentSize{ return UILayoutFittingExpandedSize; }


@end
