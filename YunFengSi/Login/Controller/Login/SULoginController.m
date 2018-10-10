//
//  SULoginController0.m
//  KJDevelopExample
//
//  Created by 杨科军 on 2017/6/12.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import "SULoginController.h"
#import "SULoginInputView.h"

#import "KJBaseTabBarController.h"
#import "AppDelegate.h"

@interface SULoginController ()
/// 输入款的父类
@property (weak, nonatomic)IBOutlet UIView *inputBaseView;

/// 登录按钮
@property (weak, nonatomic)IBOutlet UIButton *loginBtn;

/// 输入框
@property (nonatomic, readwrite, weak)SULoginInputView *inputView;
/// 用户头像
@property (weak, nonatomic)IBOutlet UIImageView *userAvatar;



@end

@implementation SULoginController

/////// ========== 产品🐶的需求 程序🦍的命运 ==========
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [(KJNavigationController *)self.navigationController hideNavgationSystemLine];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [(KJNavigationController *)self.navigationController showNavgationSystemLine];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /// 弹出键盘
//    [self.inputView.phoneTextField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";

    /// 初始化导航栏
    [self _setupNavigationItem];

    /// 初始化subView
    [self _setupSubViews];
    
}

////////////////// 以下为逻辑代码，还请过多关注 ///////////////////
#pragma mark - 事件处理
/// 登录按钮被点击
- (IBAction)_loginBtnDidClicked:(UIButton *)sender {
    /// 验证手机号码 正确的手机号码
    if (![NSString kj_isValidMobile:self.inputView.phoneTextField.text]){
        [MBProgressHUD kj_showTips:@"请输入正确的手机号码"];
        return;
    }
    
    /// 验证验证码 四位数字
    if (self.inputView.verifyTextField.text.length < 6 ){
        [MBProgressHUD kj_showTips:@"密码位数错误"];
        return;
    }
    
    //// 键盘掉下
    [self.view endEditing:YES];
    
    /// show loading
    [MBProgressHUD kj_showProgressHUD:@"Loading..."];
    
    
        NSDictionary *dict = @{
                               @"type":@"1",
                               @"phone":self.inputView.phoneTextField.text,
                               @"password":self.inputView.verifyTextField.text,
                               };
    //Ggaoye
    [HNRequestManager sendRequestWithRequestMethodType:HNRequestMethodTypePOST requestAPICode:@"Dzlogin" refreshCache:YES requestParameters:dict success:^(id responseObject){
        NSLog(@"%@",responseObject);
        /// hid hud
        [MBProgressHUD kj_hideHUD];
        /// 登录成功 保存数据 简单起见 随便存了哈
        [[NSUserDefaults standardUserDefaults] setValue:self.inputView.phoneTextField.text forKey:@"account"];
        [[NSUserDefaults standardUserDefaults] setValue:self.inputView.verifyTextField.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        /// 跳转主界面
        KJBaseTabBarController *vc = [[KJBaseTabBarController alloc] init];
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController = vc;
    } faild:^(NSError *error){
        NSLog(@"%@",error);
    }];
    
}
/// textField的数据改变
- (void)_textFieldValueDidChanged:(UITextField *)sender{
    self.loginBtn.enabled = (self.inputView.phoneTextField.hasText && self.inputView.verifyTextField.hasText);
    
    /// 这里是假数据 模拟用户输入去本地数据库拉去数据
    if(![NSString kj_isValidMobile:self.inputView.phoneTextField.text]){
        self.userAvatar.image = GetImage(@"timg1");
        return;
    }
}

/// 填充数据
- (void)_fillupTextField{
    /// 从沙盒中取出数据
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
    if ([account isEqualToString:@""] || [password isEqualToString:@""]){
        [MBProgressHUD kj_showErrorTips:@"请输入账号密码"];
        [self.inputView.phoneTextField becomeFirstResponder];
        return;
    }
    
    self.inputView.phoneTextField.text = account;
    self.inputView.verifyTextField.text = password;
    /// 验证登录按钮的有效性
    [self _textFieldValueDidChanged:nil];
}


////////////////// 以下为UI代码，不必过多关注 ///////////////////
#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    /// 快捷方式 填充数据
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"填充" style:UIBarButtonItemStylePlain target:self action:@selector(_fillupTextField)];
}


#pragma mark - 初始化subView
- (void)_setupSubViews{
    /// 设置圆角
//    [self.userAvatar cornerRadiusRoundingRect];
//    [self.userAvatar zy_attachBorderWidth:.5f color:KJColorFromHexString(@"#EBEBEB")];
    
    /// 输入框
    SULoginInputView *inputView = [SULoginInputView inputView];
    self.inputView = inputView;
    [self.inputBaseView addSubview:inputView];
    
    /// 布局
    [inputView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    /// 登录按钮
    [self.loginBtn setTitleColor:UIColorFromRGBA(255.0f, 255.0f, 255.0f, .5f)forState:UIControlStateDisabled];
    /// 从沙盒中取出数据
    inputView.phoneTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    inputView.verifyTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    /// 验证登录按钮的有效性
    [self _textFieldValueDidChanged:nil];
    
    /// 添加事件
    [inputView.phoneTextField addTarget:self action:@selector(_textFieldValueDidChanged:)forControlEvents:UIControlEventEditingChanged];
    [inputView.verifyTextField addTarget:self action:@selector(_textFieldValueDidChanged:)forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Override
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    /// 键盘掉下
    [self.view endEditing:YES];
}
@end
