//
//  KJNewDynamicView.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJNewDynamicView.h"
#import "KJScrollTextView.h"

@interface KJNewDynamicView()<KJScrollTextViewDelegate>

@property (nonatomic, strong) UIImageView *newDynamicImageView;//头像
@property (nonatomic, strong) KJScrollTextView *scrollTextView;
@property (nonatomic, strong) KJScrollTextView *scrollTextView2;

@end

@implementation KJNewDynamicView

+ (instancetype)createNewDynamicViewFromData:(NSObject*)model Size:(void(^)(CGSize size))block{
    KJNewDynamicView *backView = [[self alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    
    [KJTools makeCornerRadius:Handle(10) borderColor:DefaultBackgroudColor layer:backView.layer borderWidth:0.5];
    
    if (block) {
        block([backView getViewSizeFrom:model]);
    }
    return backView;
}

- (CGSize)getViewSizeFrom:(NSObject*)model{
//    KJContentModel *k = (KJContentModel*)model;
    
    [self setUI];
    
    // 先调用superView的layoutIfNeeded方法再获取frame
    [self layoutIfNeeded];
    CGFloat h = Handle(10) + CGRectGetHeight(self.newDynamicImageView.frame) + Handle(9);
    return CGSizeMake(SCREEN_WIDTH, h);
}

#pragma mark - KJScrollTextViewDelegate
- (void)scrollTextView:(KJScrollTextView *)scrollTextView currentTextIndex:(NSInteger)index{
//    NSLog(@"当前是信息%ld",index);
}
- (void)scrollTextView:(KJScrollTextView *)scrollTextView clickIndex:(NSInteger)index content:(NSString *)content{
    NSLog(@"#####点击的是：第%ld条信息 内容：%@",index,content);
}

- (void)setUI{
    [self.newDynamicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(15));
        make.width.height.mas_equalTo(Handle(40));
    }];
    [self addSubview:self.scrollTextView];
    [self.scrollTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(Handle(10));
        make.left.mas_equalTo(self.newDynamicImageView.mas_right).mas_offset(Handle(10));
        make.right.mas_equalTo(self).mas_offset(-Handle(10));
        make.height.mas_equalTo(Handle(20));
    }];
    [self addSubview:self.scrollTextView2];
    [self.scrollTextView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollTextView.mas_bottom);
        make.left.mas_equalTo(self.newDynamicImageView.mas_right).mas_offset(Handle(10));
        make.right.mas_equalTo(self).mas_offset(-Handle(10));
        make.height.mas_equalTo(Handle(20));
    }];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"富文本数据"];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"timg1"];
    textAttachment.bounds = CGRectMake(0, -4, 15, 15);
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrStr insertAttributedString:attachmentAttrStr atIndex:0];
    // NSMutableAttributedString to NSString
    NSString *anotherString = [attrStr string];
    
    _scrollTextView.textDataArr = @[attrStr,@"第一条假数据",@"第2条假数据",@"第3条假数据",@"第4条假数据",@"第5条假数据"];
    // 开始滚动
    [_scrollTextView startScrollBottomToTopWithNoSpace];
    _scrollTextView2.textDataArr = @[anotherString];
    // 开始滚动
    [_scrollTextView2 startScrollBottomToTopWithNoSpace];
}

- (UIImageView*)newDynamicImageView{
    if (!_newDynamicImageView) {
        _newDynamicImageView = InsertImageView(self, CGRectZero, GetImage(@"zuixindongtai"));
    }
    return _newDynamicImageView;
}

- (KJScrollTextView*)scrollTextView{
    if (!_scrollTextView) {
        _scrollTextView = [[KJScrollTextView alloc] initWithFrame:CGRectMake(60, 64, SCREEN_WIDTH-70, 20)];
        _scrollTextView.delegate            = self;
        _scrollTextView.textStayTime        = 2;
        _scrollTextView.scrollAnimationTime = 0.5;
        _scrollTextView.textColor           = MainColor;
        _scrollTextView.textFont            = [UIFont boldSystemFontOfSize:13.f];
        _scrollTextView.textAlignment       = NSTextAlignmentLeft;
        _scrollTextView.touchEnable         = YES;
    }
    return _scrollTextView;
}
- (KJScrollTextView*)scrollTextView2{
    if (!_scrollTextView2) {
        _scrollTextView2 = [[KJScrollTextView alloc] initWithFrame:CGRectMake(60, 84, SCREEN_WIDTH-70, 20)];
        _scrollTextView2.delegate            = self;
        _scrollTextView2.textStayTime        = 2;
        _scrollTextView2.scrollAnimationTime = 0.5;
        _scrollTextView2.textColor           = MainColor;
        _scrollTextView2.textFont            = [UIFont boldSystemFontOfSize:13.f];
        _scrollTextView2.textAlignment       = NSTextAlignmentLeft;
        _scrollTextView2.touchEnable         = YES;
    }
    return _scrollTextView2;
}


@end
