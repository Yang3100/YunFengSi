//
//  KJBaseNavigationController.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseNavigationController.h"

@interface KJBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KJBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
    // Do any additional setup after loading the view.
    
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = MainColor; //  导航背景颜色
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:attrs];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
