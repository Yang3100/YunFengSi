//
//  KJBaseViewController.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseViewController.h"


@interface KJBaseViewController ()

@end

@implementation KJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem leftItemWithImage:@"login_goBack" higthImage:@"" title:nil target:self action:@selector(NavBack)];
}

- (void)NavBack{
    if ([KJTools kj_judgeCurrentVCIsPushOrPrsent:self]) {  // push方式进入
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dealloc{
    NSLog(@"%@--dealloc",NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
