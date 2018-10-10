//
//  KJAnnularProgressView.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJAnnularProgressView.h"

#import <AudioToolbox/AudioToolbox.h>

#import <UAProgressView/UAProgressView.h>

@interface KJAnnularProgressView()

@property(nonatomic,strong)UAProgressView *progressView;

@property (nonatomic, strong)UILabel  *nameLabel;//标题
@property (nonatomic, strong)UILabel  *likeLabel;//点赞人数
@property (nonatomic, strong)UILabel  *helpNumLabel;//助学人数
@property (nonatomic, strong)UILabel  *surplusDayLabel;//剩余天数

@property (nonatomic, strong)UILabel  *targetLabel;//目标金额
@property (nonatomic, strong)UILabel  *completeLabel;//已达成
@property (nonatomic, strong)UILabel  *projectLabel;//项目详情
@property (nonatomic, strong)UILabel  *loveLabel;//爱心动态

@property (nonatomic, strong)UIView  *imaginaryLine;// 虚线
@property (nonatomic, strong)UILabel  *detailLabel;//详情

@property (nonatomic, strong)UILabel  *seeLabel;//看完了
@property (nonatomic, strong)UIButton  *giveLikeButton;//点赞

// 粒子效果
@property(nonatomic,strong) CAEmitterLayer *emitterLayer;  // 粒子容器
@property(nonatomic,strong) CAEmitterCell *emitterCell;    // 粒子

@end

@implementation KJAnnularProgressView

+ (instancetype)createViewFromData:(NSObject*)model Size:(void(^)(CGSize size))block{
    KJAnnularProgressView *backView = [[self alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    
    if (block){
        block([backView getViewSizeFrom:model]);
    }
    return backView;
}

- (CGSize)getViewSizeFrom:(NSObject*)model{
    //    KJContentModel *k = (KJContentModel*)model;
    
    [self setUI];
    
    // 先调用superView的layoutIfNeeded方法再获取frame
    [self layoutIfNeeded];
    CGFloat h = CGRectGetHeight(self.giveLikeButton.frame)+ self.giveLikeButton.frame.origin.y + Handle(20);
    return CGSizeMake(SCREEN_WIDTH, h);
}

- (void)setUI{
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self).mas_offset(Handle(10));
        make.right.mas_equalTo(self).mas_offset(-Handle(10));
        make.height.mas_equalTo(Handle(20));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.right.mas_equalTo(self.likeLabel.mas_left).mas_offset(Handle(-10));
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(Handle(30));
        make.centerX.mas_equalTo(self);
        make.width.height.mas_equalTo(Handle(80));
    }];
    [self.helpNumLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.progressView.mas_bottom).mas_offset(Handle(-30));
        make.right.mas_equalTo(self.progressView.mas_left).mas_offset(Handle(-10));
        make.width.height.mas_equalTo(Handle(60));
    }];
    [self.surplusDayLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(self.helpNumLabel);
        make.left.mas_equalTo(self.progressView.mas_right).mas_offset(Handle(10));
        make.width.height.mas_equalTo(Handle(60));
    }];
    
    [self.targetLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.helpNumLabel.mas_bottom).mas_offset(Handle(20));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(50));
        make.width.mas_equalTo((SCREEN_WIDTH-20)/2-1);
    }];
    [self.completeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.helpNumLabel.mas_bottom).mas_offset(Handle(20));
        make.right.mas_equalTo(self).mas_offset(Handle(-10));
        make.height.mas_equalTo(Handle(50));
        make.width.mas_equalTo((SCREEN_WIDTH-20)/2);
    }];
    [self.loveLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.completeLabel.mas_bottom).mas_offset(Handle(20));
        make.right.mas_equalTo(self).mas_offset(Handle(-20));
        make.height.mas_equalTo(Handle(30));
        make.width.mas_equalTo((SCREEN_WIDTH-30)/2);
    }];
    [self.projectLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.completeLabel.mas_bottom).mas_offset(Handle(20));
        make.left.mas_equalTo(self).mas_offset(Handle(20));
        make.height.mas_equalTo(Handle(30));
        make.width.mas_equalTo((SCREEN_WIDTH-40)/2);
    }];
    [self.imaginaryLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.projectLabel.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.height.mas_equalTo(Handle(1));
        make.width.mas_equalTo(SCREEN_WIDTH-20);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.imaginaryLine.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self).mas_offset(Handle(10));
        make.width.mas_equalTo(SCREEN_WIDTH-20);
    }];
    
    [self.seeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.detailLabel.mas_bottom).mas_offset(Handle(30));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(Handle(20));
    }];
    
    [self.giveLikeButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.seeLabel.mas_bottom).mas_offset(Handle(10));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(Handle(30));
        make.width.mas_equalTo(Handle(60));
    }];
    
    [self begionProgress];
}

- (void)begionProgress{
    //  延时执行
    int64_t delayInSeconds = 0.5; // 延迟的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __block float localProgress;
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.05 block:^(NSTimer * _Nonnull timer){
            localProgress = ((int)((localProgress * 100.0f)+ 1.01)% 100)/ 100.0f;
            // 关闭计时器
            if (localProgress>=0.81){
                [timer invalidate];
                timer = nil;
            }else{
                [self.progressView setProgress:localProgress];
            }
        } repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    });
}

- (UAProgressView*)progressView{
    if (!_progressView){
        _progressView = [[UAProgressView alloc] initWithFrame:CGRectMake(0, 0, Handle(80), Handle(80))];
        _progressView.tintColor = MainColor;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60.0, 20.0)];
        label.text = @"80.0%";
        label.textColor = MainColor;
        [label setTextAlignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = NO; // Allows tap to pass through to the progress view.
        _progressView.centralView = label;
        _progressView.progressChangedBlock = ^(UAProgressView *progressView, CGFloat progress){
            [(UILabel *)progressView.centralView setText:[NSString stringWithFormat:@"%2.0f%%", progress * 100]];
        };
        _progressView.animationDuration = 2;
        [self addSubview:_progressView];
    }
    return _progressView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel){
        _nameLabel=InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"这里显示名字很长很长的名字", SystemFontSize(14), DefaultTitleColor);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}
- (UILabel*)likeLabel{
    if (!_likeLabel){
        _likeLabel=InsertLabel(self, CGRectZero, NSTextAlignmentRight, @"118人点赞", SystemFontSize(12), [UIColor redColor]);
    }
    return _likeLabel;
}
- (UILabel*)helpNumLabel{
    if (!_helpNumLabel){
        _helpNumLabel = InsertLabel(self, CGRectZero, NSTextAlignmentCenter, @"帮助人数\n500人", SystemFontSize(11), [UIColor whiteColor]);
        _helpNumLabel.backgroundColor = MainColor;
        _helpNumLabel.numberOfLines = 0;
        [KJTools makeCornerRadius:Handle(30)borderColor:DefaultBackgroudColor layer:_helpNumLabel.layer borderWidth:1];
    }
    return _helpNumLabel;
}
- (UILabel*)surplusDayLabel{
    if (!_surplusDayLabel){
        _surplusDayLabel = InsertLabel(self, CGRectZero, NSTextAlignmentCenter, @"剩余天数\n30天", SystemFontSize(11), [UIColor whiteColor]);
        _surplusDayLabel.backgroundColor = MainColor;
        _surplusDayLabel.numberOfLines = 0;
        [KJTools makeCornerRadius:Handle(30)borderColor:DefaultBackgroudColor layer:_surplusDayLabel.layer borderWidth:1];
    }
    return _surplusDayLabel;
}
- (UILabel*)targetLabel{
    if (!_targetLabel){
        _targetLabel = InsertLabel(self, CGRectZero, NSTextAlignmentCenter, @"3200元\n目标金额", SystemFontSize(13), [UIColor whiteColor]);
        _targetLabel.numberOfLines = 0;
        _targetLabel.backgroundColor = MainColor;
    }
    return _targetLabel;
}
- (UILabel*)completeLabel{
    if (!_completeLabel){
        _completeLabel = InsertLabel(self, CGRectZero, NSTextAlignmentCenter, @"3100\n达成金额", SystemFontSize(13), [UIColor whiteColor]);
        _completeLabel.numberOfLines = 0;
        _completeLabel.backgroundColor = MainColor;
    }
    return _completeLabel;
}
- (UILabel*)projectLabel{
    if (!_projectLabel){
        _projectLabel=InsertLabel(self, CGRectZero, NSTextAlignmentCenter, @"项目详情", SystemFontSize(12), [UIColor whiteColor]);
        _projectLabel.backgroundColor = MainColor;
        [KJTools makeCornerRadius:Handle(5)borderColor:MainColor layer:_projectLabel.layer borderWidth:1];
    }
    return _projectLabel;
}
- (UILabel*)loveLabel{
    if (!_loveLabel){
        _loveLabel=InsertLabel(self, CGRectZero, NSTextAlignmentCenter, @"爱心动态", SystemFontSize(12), MainColor);
        _loveLabel.backgroundColor = [UIColor whiteColor];
        [KJTools makeCornerRadius:Handle(5)borderColor:MainColor layer:_loveLabel.layer borderWidth:1];
    }
    return _loveLabel;
}

- (UIView*)imaginaryLine{
    if (!_imaginaryLine){
        _imaginaryLine = InsertView(self, CGRectZero, [UIColor grayColor]);
    }
    return _imaginaryLine;
}

- (UILabel*)detailLabel{
    if (!_detailLabel){
        _detailLabel=InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"我们使用一门语言\n\n\n无论是外语还是计算机语言，总是从语法开始的，这样我们才能正确的把握逻辑。所以我们从语法开始说起。在这部分我们仅关心其语法的使用\n只要我们使用谓词（NSPredicate）都需要为谓词定义谓词表达式,而这个表达式必须是一个返回BOOL的值。\n谓词表达式由表达式、运算符和值构成。\n   \n1.比较运算符\n\n比较运算符如下\n=、==：判断两个表达式是否相等\n在谓词中=和==是相同的意思都是判断，而没有赋值这一说", SystemFontSize(14), [UIColor blackColor]);
        _detailLabel.backgroundColor = [UIColor whiteColor];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UILabel*)seeLabel{
    if (!_seeLabel){
        _seeLabel=InsertLabel(self, CGRectZero, NSTextAlignmentCenter, @"看完了点个赞吧!", SystemFontSize(12), MainColor);
    }
    return _seeLabel;
}
- (UIButton*)giveLikeButton{
    if (!_giveLikeButton){
        _giveLikeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_giveLikeButton setTitle:@"118" forState:UIControlStateNormal];
        //设置button正常状态下的图片
        [_giveLikeButton setImage:[UIImage imageNamed:@"comment_zan_nor"]
                        forState:UIControlStateNormal];
        //设置button高亮状态下的图片
        [_giveLikeButton setImage:[UIImage imageNamed:@"comment_zan_high"]
                        forState:UIControlStateHighlighted];
        //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
//        CGFloat leftlab = [_giveLikeLabel.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : _giveLikeLabel.titleLabel.font}].width;
//        [_giveLikeLabel setImageEdgeInsets:UIEdgeInsetsMake(0, leftlab + 70, 0, 0)];
//        [_giveLikeLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];

        _giveLikeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 60);
        //button标题的偏移量，这个偏移量是相对于图片的
        _giveLikeButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, -5);
        _giveLikeButton.showsTouchWhenHighlighted = YES;
        // 重点位置结束
        _giveLikeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //设置button正常状态下的标题颜色
        [_giveLikeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //设置button高亮状态下的标题颜色
        [_giveLikeButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
        _giveLikeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_giveLikeButton addTarget:self action:@selector(buttonDidClicked)forControlEvents:UIControlEventTouchUpInside];
        [KJTools makeCornerRadius:Handle(5) borderColor:[UIColor grayColor] layer:_giveLikeButton.layer borderWidth:1];
        _giveLikeButton.highlighted = NO;
        _giveLikeButton.selected = NO;
        [self addSubview:_giveLikeButton];
    }
    return _giveLikeButton;
}

- (void)buttonDidClicked{
    if (self.giveLikeButton.selected) {
        [MBProgressHUD kj_showTips:@"您已点赞!!"];
        return;
    }
    
    self.giveLikeButton.highlighted = YES;
    self.giveLikeButton.selected = YES;
    [_giveLikeButton setTitle:@"119" forState:UIControlStateNormal];
    [_giveLikeButton setImage:[UIImage imageNamed:@"comment_zan_high"]
                     forState:UIControlStateNormal];
    
    // 添加粒子效果层
    [self.layer addSublayer:self.emitterLayer];
    
    
    //  延时执行
    int64_t delayInSeconds = 3.0; // 延迟的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self.emitterLayer removeFromSuperlayer];
    });
}

#pragma mark - 初始化粒子容器
- (CAEmitterLayer*)emitterLayer{
    if (!_emitterLayer) {
        // 粒子容器
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        // 决定了粒子发射形状的中心点
        emitterLayer.emitterPosition = self.giveLikeButton.center;
        // 发射源的尺寸大小
        emitterLayer.emitterSize     = self.giveLikeButton.frame.size;
        emitterLayer.emitterMode     = kCAEmitterLayerPoints;  // 发射模式
        emitterLayer.emitterShape    = kCAEmitterLayerCircle;  // 发射源的形状
        emitterLayer.renderMode      = kCAEmitterLayerAdditive;  // 渲染模式
        
        
        //        CAEmitterCell *subCell2 = home_Emitter_subCell([KJTools getImageFromColor:[UIColor blueColor] Rect:CGRectMake(0, 0, 10, 10)]);
        // 将色块粒子加入到容器之中
        emitterLayer.emitterCells = @[self.emitterCell];
        
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}

#pragma mark - 粒子设置
- (CAEmitterCell*)emitterCell{
    if (!_emitterCell) {
        _emitterCell = [CAEmitterCell emitterCell];
        
        // 粒子
        // 和CALayer一样，只是用来设置图片
        UIImage *image = GetImage(@"comment_zan_high");
        _emitterCell.contents = (__bridge id _Nullable)image.CGImage;
        
        _emitterCell.lifetime = 5;    // 粒子存活时间
        _emitterCell.lifetimeRange = 0; // 生命周期范围
        _emitterCell.alphaRange = 0.5f;
        _emitterCell.alphaSpeed = -0.3f;      // 粒子消逝的速度
        _emitterCell.spin = M_PI;             // 自旋转角度
        _emitterCell.spinRange = 2 * M_PI;    // 自旋转角度范围
        
        // 发射器
        _emitterCell.birthRate = 50;        // 每秒生成粒子的个数
        _emitterCell.yAcceleration = 0.f;   // 粒子的初始加速度
        _emitterCell.xAcceleration = 0.1f;
        _emitterCell.velocity = 80;           // 粒子运动的速度均值
        _emitterCell.velocityRange = 30.f;    // 粒子运动的速度扰动范围
        _emitterCell.emissionRange  = 2*M_PI; // 粒子发射角度范围
        
        _emitterCell.scale = 0.1;             // 缩放比例
        _emitterCell.scaleRange = 0.3;        // 缩放比例范围
        _emitterCell.scaleSpeed = 0.05;
    }
    return _emitterCell;
}


@end
