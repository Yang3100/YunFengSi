//
//  KJBaseTabBarController.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/20.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseTabBarController.h"
#import "KJHomeVC.h"
#import "KJActivityVC.h"
#import "KJFendVC.h"
#import "KJHelpStudyVC.h"
#import "KJMeVC.h"

@interface KJBaseTabBarController ()

@end

@implementation KJBaseTabBarController

+(void)initialize{
    // tabBaritme 标题未选中的 颜色 大小设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    attrs[NSForegroundColorAttributeName] = attrs[NSForegroundColorAttributeName];
    
    // tabBaritme 标题选中的 颜色 大小设置
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = MainColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChildVC:[[KJFendVC alloc]init] title:@"供养" image:@"zhifu_normal" selectedImage:@"zhifu_pressed"];
    [self setupChildVC:[[KJHelpStudyVC alloc]init] title:@"助学" image:@"zixun_normal" selectedImage:@"zixun_pressed"];
    [self setupChildVC:[[KJHomeVC alloc]init] title:@"首页" image:@"shouye_normal" selectedImage:@"shouye_pressed"];
    [self setupChildVC:[[KJActivityVC alloc]init] title:@"活动" image:@"simiao_normal" selectedImage:@"simiao_pressed"];
    [self setupChildVC:[[KJMeVC alloc]init] title:@"我的" image:@"mine_normal" selectedImage:@"mine_pressed"];
    
    // 更改系统自带的tabbar
    UITabBar *tabbar = [[UITabBar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
    tabbar.translucent = NO;
    [tabbar setBarTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置tabBar子控制器 item 标题，以及图片
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:vc];
}

#pragma mark - tabbar点击效果
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [tabBar.items indexOfObject:item];
    // 添加动画
    [self animationWithindex:index];
}

- (void)animationWithindex:(NSInteger)index{
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation *anim =[CABasicAnimation  animation];
    //    想让哪一个图层做动画,就添加到哪一个图层上面.
    anim.keyPath = @"transform.scale";
    //    缩放到最小
    anim.toValue = @1.3;
    //    设置动画执行的次数
    anim.repeatCount = 3;
    //    设置动画执行的时长
    anim.duration = 0.1;
    //    反转
    anim.autoreverses = YES;
    
    [[tabbarbuttonArray[index] layer] addAnimation:anim forKey:nil];
}



@end




