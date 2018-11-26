//
//  KJNewActivityCell.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/21.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJNewActivityCell.h"

@interface KJNewActivityCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottom;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@end

@implementation KJNewActivityCell

- (void)setModel:(NSObject *)model{
    if (_model != model) {
        _model = model;
    }
    
    int i = [KJTools getRandomNumber:0 to:2];
    if (i==0) { // 有图片
        self.headerImageView.hidden = NO;
        self.headerImageView.image = GetImage(@"timg1");
        self.imageBottom.constant = 10;
        self.imageTop.constant = 10;
        self.imageHeight.constant = 100;
    }
    else if (i==1) { // 有图片
        self.headerImageView.hidden = NO;
        self.headerImageView.image = GetImage(@"tu2");
        self.imageBottom.constant = 20;
        self.imageTop.constant = 20;
        self.imageHeight.constant = 50;
    }
    else { // 没有图片
        self.headerImageView.hidden = NO;
        self.imageBottom.constant = 0;
        self.imageTop.constant = 0;
        self.imageHeight.constant = 0;
    }
    
}

@end
