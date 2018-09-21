//
//  KJNumberSeletedView.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJNumberSeletedView.h"

@interface KJNumberSeletedView()

@property (nonatomic, weak)UIButton *leftBtn; //减小按钮
@property (nonatomic, weak)UIButton *rightBtn;// 增加按钮
@property (nonatomic, weak)UIView *topView;// N人以上区域
@property (nonatomic, weak)UILabel *lable;// N人以上文字

@end

@implementation KJNumberSeletedView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        //设置背景
        UIImageView *comeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        comeView.image = [UIImage imageNamed:@"bespeakBG"];
        [self addSubview:comeView];
        //设置显示内容
        UILabel *timeLable = [[UILabel alloc] initWithFrame:comeView.frame];
        self.timeLable = timeLable;
        timeLable.textAlignment = NSTextAlignmentCenter;
        timeLable.font = [UIFont systemFontOfSize:12];
        [self addSubview:timeLable];
        //设置减小按钮
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 31, 30)];
        self.leftBtn = leftBtn;
        leftBtn.userInteractionEnabled = NO;
        [leftBtn setImage:[UIImage imageNamed:@"delect_gragy"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"delect_gragy"] forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(leftBtn:)forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        //设置增大按钮
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 31, 0, 31, 30)];
        self.rightBtn = rightBtn;
        [rightBtn setImage:[UIImage imageNamed:@"add_gragy"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"add_gragy"] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(rightBtn:)forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(leftBtn.width, 0, self.width - leftBtn.width, self.height)];
        self.topView = topView;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.topView.width, self.topView.height)];
        imgView.image = [UIImage imageNamed:@"bespeakTopBG"];
        [self.topView addSubview:imgView];
        UILabel * lable = [[UILabel alloc] initWithFrame:imgView.frame];
        self.lable = lable;
        lable.font = [UIFont systemFontOfSize:14];
        lable.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:lable];
        [self addSubview:self.topView];
        self.topView.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.i = self.lowI;
    self.timeLable.text = [NSString stringWithFormat:@"%d%@",self.i,self.title];
    self.lable.text = [NSString stringWithFormat:@"%d人以上",(self.HighI - 1)];
}

#pragma mark - 点击减
- (void)leftBtn:(UIButton *)btn{
    self.i --;
    if (self.HighType == YES){
        if (self.i <= self.HighI){
            self.topView.hidden = YES;
        }
    }
    if (self.i <= self.lowI){
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"delect_gragy"] forState:UIControlStateNormal];
    } else {
        btn.userInteractionEnabled = YES;
        self.rightBtn.userInteractionEnabled = YES;
        [self.rightBtn setImage:[UIImage imageNamed:@"add_gragy"] forState:UIControlStateNormal];
    }
    self.timeLable.text = [NSString stringWithFormat:@"%d%@",self.i,self.title];
}

#pragma mark - 点击加
- (void)rightBtn:(UIButton *)btn{
    self.i ++;
    if (self.HighType == YES){
        if (self.i >= self.HighI){
            self.topView.hidden = NO;
        }
    }
    if (self.i >= self.HighI){
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"add_gragy"] forState:UIControlStateNormal];
    } else {
        self.leftBtn.userInteractionEnabled = YES;
        [self.leftBtn setImage:[UIImage imageNamed:@"delect_gragy"] forState:UIControlStateNormal];
    }
    self.timeLable.text = [NSString stringWithFormat:@"%d%@",self.i,self.title];
}


@end
