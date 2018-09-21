//
//  KJActivityVC.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJActivityVC.h"
#import "UIView+CMHEmptyView.h"

@interface KJActivityVC ()

@end

@implementation KJActivityVC
/// 重写init方法，配置你想要的属性
- (instancetype)init{
    self = [super init];
    if (self) {
        /// 支持上拉加载，下拉刷新
        self.shouldPullDownToRefresh = YES;
        self.shouldPullUpToLoadMore = YES;
        
        /// 是否在用户上拉加载后的数据 , 如果请求回来的数据`小于` pageSize， 则提示没有更多的数据.default is YES 。 如果为`NO` 则隐藏mi_footer 。 前提是` shouldMultiSections = NO `才有效。
//        self.shouldEndRefreshingWithNoMoreData = NO; // NO
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [MBProgressHUD kj_showProgressHUD:@"模拟网络加载ing.." addedToView:self.view];
    [self tableViewDidTriggerHeaderRefresh];
}

#pragma mark - Override
- (void)tableViewDidTriggerHeaderRefresh{
    /// 下拉刷新事件 子类重写
    self.page = 1;
    /// 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        /// hid HUD
        [MBProgressHUD kj_hideHUDForView:self.view];
        /// 假设就是没有数据
        
        /// 现实场景中，我们利用AFNetworking访问服务器的数据，有成功的回调，和失败的回调，如下所示。
        /**
         ///
         [CMHHttpRequestTool POST:UFMapListUrl params:params completion:^(NSURLSessionDataTask *task, id responseObject) {
         /// 请求成功的回调
         /// 若code == 200，则代表数据请求成功，否则则代表数据请求失败
         if ([responseObject[@"code"] integerValue]== 200) {
         /// 这里就代表请求成功，但是返回来的数据可能为空
         }else{
         /// 这里一般是服务器的问题，比如 服务器报500的错误，或者404的错误，以及503等等
         }
         } failed:^(NSURLSessionDataTask *task, NSError *error) {
         /// 请求失败的回调，
         /// 客户端一般只需要关心出错的原因是：
         /// - 网络问题
         /// - 服务器问题
         }];
         */
        /// 以下模拟上面的网络请求回调 。 requestState == 0 则代表请求失败，反之，则代表请求成功
        NSInteger requestState = [NSObject kj_randomNumber:1 to:4];
        CMHEmptyDataViewType emptyType = [NSObject kj_randomNumber:0 to:8];
        if (requestState < 0) {
            
            /// 服务器请求成功的返回的状态码 requestCode == 200 则代表有数据 ， 反之则代表服务器出错
            NSInteger requestCode = [NSObject kj_randomNumber:0 to:199];
            
            BOOL hasError = (requestCode < 200);
            
            /// 请求成功的回调
            if (requestCode >= 200) { /// 这里假设>=200代表成功，增加一下模拟成功的几率
                /// 这里就代表请求成功，但是返回来的数据可能为空
            }else{
                /// 这里一般是服务器的问题，比如 服务器报500的错误，或者404的错误，以及503等等
            }
            [self.tableView cmh_configEmptyViewWithType:emptyType emptyInfo:nil errorInfo:nil offsetTop:250 hasData:self.dataSource.count>0 hasError:hasError reloadBlock:NULL];
        }else{
            /// 请求失败的回调，
            /// 客户端一般只需要关心出错的原因是：
            /// - 网络问题
            /// - 服务器问题
            /// 只需要设置 errorInfo 和 hasError == YES , hasData
            @weakify(self);
            [self.tableView cmh_configEmptyViewWithType:emptyType emptyInfo:nil errorInfo:nil offsetTop:250 hasData:self.dataSource.count>0 hasError:YES reloadBlock:^{
                @strongify(self);
                [MBProgressHUD kj_showProgressHUD:@"Loading..." addedToView:self.view];
                [self tableViewDidTriggerHeaderRefresh];
            }];
        }
        /// 告诉系统你是否结束刷新 , 这个方法我们手动调用，无需重写
        [self tableViewDidFinishTriggerHeader:YES reload:YES];
        
    });
}

@end
