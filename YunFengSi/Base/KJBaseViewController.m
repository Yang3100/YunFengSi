//
//  KJBaseViewController.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseViewController.h"


@interface KJBaseViewController ()

/// The `params` parameter in `-initWithParams:` method.
@property (nonatomic, readwrite, copy)NSDictionary *params;

@end

@implementation KJBaseViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//#ifdef __IPHONE_11_0
//    /// ignore adjust scroll 64
//    self.automaticallyAdjustsScrollViewInsets = YES;
//#else
//    /// ignore adjust scroll 64
//    self.automaticallyAdjustsScrollViewInsets = NO;
//#endif
//
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    /// backgroundColor
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    // 添加返回
//    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem leftItemWithImage:@"login_goBack" higthImage:@"" title:nil target:self action:@selector(NavBack)];
//}
//- (void)NavBack{
//    if ([KJTools kj_judgeCurrentVCIsPushOrPrsent:self]){  // push方式进入
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//}

- (void)dealloc{
    NSLog(@"%@--dealloc",NSStringFromClass([self class]));
}


// when `KJViewController ` created and call `viewDidLoad` method , execute `requestRemoteData` Or `configure` method
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    KJBaseViewController *viewController = [super allocWithZone:zone];
//    @weakify(viewController)
//    [[viewController
//      rac_signalForSelector:@selector(viewDidLoad)]
//     subscribeNext:^(id x){
//         @strongify(viewController)
//         [viewController configure];
//
//         /// 请求数据
//         if (viewController.shouldRequestRemoteDataOnViewDidLoad){
//             [viewController requestRemoteData];
//         }
//     }];
    return viewController;
}


- (instancetype)initWithParams:(NSDictionary *)params{
    /// CoderMikeHe Fixed Bug: 这里调用self init ,便于其他开发人员直接采用 [xxx alloc] init]创建控制器，向下兼容吧
    if (self = [self init]){
        _params = params;
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self){
        /// 基础配置
        /// 默认在viewDidLoad里面服务器的数据
        _shouldRequestRemoteDataOnViewDidLoad = YES;
        /// FDFullscreenPopGesture
        _interactivePopDisabled = NO;
        _prefersNavigationBarHidden = NO;
        /// custom
        _prefersNavigationBarBottomLineHidden = NO;
        /// 允许IQKeyboardMananger接管键盘弹出事件
        _keyboardEnable = YES;
        _shouldResignOnTouchOutside = YES;
        _keyboardDistanceFromTextField = 10.0f;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    /// 隐藏导航栏细线
//    KJNavigationController *nav = (KJNavigationController *)self.navigationController;
//    if ([nav isKindOfClass:[KJNavigationController class]]){ /// 容错
//        /// 显示或隐藏
//        self.prefersNavigationBarBottomLineHidden?[nav hideNavigationBottomLine]:[nav showNavigationBottomLine];
//    }
    
//    /// 配置键盘
//    IQKeyboardManager.sharedManager.enable = self.keyboardEnable;
//    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = self.shouldResignOnTouchOutside;
//    IQKeyboardManager.sharedManager.keyboardDistanceFromTextField = self.keyboardDistanceFromTextField;
//
//    if (nav){
//        /**
//         原因：
//         viewController.navigationItem.backBarButtonItem = nil;
//         [viewController.navigationItem setHidesBackButton:YES];
//         CoderMikeHe: Fixed Bug 上面这个方法，会导致侧滑取消时，导航栏出现三个蓝点，系统层面的BUg
//         这种方法也不是最完美的，第一次侧滑取消 也会复现
//         */
//        for (UIView *subView in nav.navigationBar.subviews){
//            /// 隐藏掉蓝点
//            if ([subView isKindOfClass:NSClassFromString(@"_UINavigationItemButtonView")]){
//                subView.kj_size = CGSizeZero;
//                subView.hidden = YES;
//            }
//        }
//    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Being popped, take a snapshot
    if ([self isMovingFromParentViewController]){
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
    
    if (self.navigationController){
        /**
         viewController.navigationItem.backBarButtonItem = nil;
         [viewController.navigationItem setHidesBackButton:YES];
         CoderMikeHe: Fixed Bug 上面这个方法，会导致侧滑取消时，导航栏出现三个蓝点，系统层面的BUg
         */
        for (UIView *subView in self.navigationController.navigationBar.subviews){
            /// 隐藏掉蓝点
            if ([subView isKindOfClass:NSClassFromString(@"_UINavigationItemButtonView")]){
                subView.size = CGSizeZero;
                subView.hidden = YES;
            }
        }
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// ignore adjust auto scroll 64
    /// CoderMikeHe Fixed: 适配 iOS 11.0 , iOS11以后，控制器的automaticallyAdjustsScrollViewInsets已经废弃，所以默认就会是YES
    /// iOS 11新增：adjustContentInset 和 contentInsetAdjustmentBehavior 来处理滚动区域
    /// CoderMikeHe Fixed : __IPHONE_11_0 只是说明Xcode定义了这个宏，但不能说明这个支持11.0，所以需要@available(iOS 11.0, *)
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)){
        self.automaticallyAdjustsScrollViewInsets = YES;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    /// backgroundColor
    self.view.backgroundColor = [UIColor whiteColor];
    
    /// 导航栏隐藏 只能在ViewDidLoad里面加载，无法动态
    self.fd_prefersNavigationBarHidden = self.prefersNavigationBarHidden;
    
    /// pop手势
    self.fd_interactivePopDisabled = self.interactivePopDisabled;
}

#pragma mark - Public Method
//- (void)configure{
//    /// ... subclass override , but must use `[super configure]`
//    /// 动态改变
//    @weakify(self);
//    [[[RACObserve(self, interactivePopDisabled)distinctUntilChanged] deliverOnMainThread] subscribeNext:^(NSNumber * x){
//        @strongify(self);
//        self.fd_interactivePopDisabled = x.boolValue;
//    }];
//}

- (void)requestRemoteData{
    /// ... subclass override
    
}

- (id)fetchLocalData{
    /// ... subclass override
    return nil;
}

#pragma mark - Orientation
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Status bar
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

@end
