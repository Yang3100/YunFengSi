//
//  SUSearchBarView.m
//  KJDevelopExample
//
//  Created by senba on 2017/6/12.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "SUSearchBarView.h"



@interface SUSearchBarView()
/// icon
@property (nonatomic, readwrite, weak)  UIImageView *imageView;
/// tipsLabel
@property (nonatomic, readwrite, weak)  UILabel *tipsLabel;
@end

@implementation SUSearchBarView

+ (instancetype)searchBarView{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = UIColorFromHEXA(0xe8eaf1, 1);
        self.layer.cornerRadius = 6;
        self.clipsToBounds = YES;
        /// search icon
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
        [imageView sizeToFit];
        self.imageView = imageView;
        [self addSubview:imageView];
        /// tipsLabel
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.font = KJRegularFont_14;
        tipsLabel.textColor = UIColorFromHEXA(0x747a8e, 1);
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.text = self.tips;
        [self.tipsLabel sizeToFit];
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        self.tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];

        /// 添加手势
        @weakify(self);
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location){
            @strongify(self);
            !self.searchBarViewClicked?:self.searchBarViewClicked();
        }]];
        /// 设置数据
        self.tips = @"输入你要找的宝贝";
    }
    return self;
}

- (void)setTips:(NSString *)tips {
    _tips = tips;
    self.tipsLabel.text = tips;
    [self.tipsLabel setNeedsDisplay];
    [self.tipsLabel sizeToFit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageViewInset = 10;
    self.tipsLabel.centerX = ceil(self.width * 0.5)+ imageViewInset;
    self.tipsLabel.y = floor((self.height - self.tipsLabel.height)/2);
    
    self.imageView.centerY = self.tipsLabel.centerY;
    self.imageView.x = self.tipsLabel.x - imageViewInset - self.imageView.width;
}

@end
