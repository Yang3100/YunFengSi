//
//  KJHomeVC.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHomeVC.h"

#import "SUSearchBarView.h"

#import "KJHelpFristCell.h"

#import "KJSearchVC.h"

//// 全局变量
static UIStatusBarStyle style_ = UIStatusBarStyleDefault;
static BOOL statusBarHidden_ = NO;

@interface KJHomeVC ()

/// 滚动到顶部的按钮
@property (nonatomic, readwrite, weak)UIButton *scrollToTopButton;
/// 自定义的导航条
@property (nonatomic, readwrite, weak)UIView *navBar;
/// searchBar
@property (nonatomic, readwrite, weak)SUSearchBarView *titleView;
/// headerView
@property (nonatomic, readwrite, weak)SDCycleScrollView *headerView;

@end

@implementation KJHomeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    [self.headerView adjustWhenControllerViewWillAppera];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // hide sys navBar
    self.fd_prefersNavigationBarHidden = YES;
    // 去掉侧滑pop手势
    self.fd_interactivePopDisabled = YES;
    
    // 上下拉刷新
    self.shouldPullDownToRefresh = YES;
    self.shouldPullUpToLoadMore = YES;
    
    // create subViews
    [self setUI];
    
    // deal action
    [self dealAction];
    
    /// tableView rigister  cell
    [self.tableView registerClass:[KJHelpFristCell class] forCellReuseIdentifier:@"KJHelpFristCell"];
    
    [self tableViewDidTriggerHeaderRefresh];
    
    /// bind viewModel
    [self _bindViewModel];
}

#pragma mark - BindModel
- (void)_bindViewModel{
    // kvo
    [FBKVOController controllerWithObserver:self];
}

#pragma mark - 事件处理
/// 事件处理
- (void)dealAction{
    /// 点击搜索框的事件：这里我就不跳转到搜索界面了  直接退出该界面
    @weakify(self);
    self.titleView.searchBarViewClicked = ^ {
        @strongify(self);
        @weakify(self);
        KJSearchVC *vc = [[KJSearchVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    /// banner 视图被点击
    self.headerView.clickItemOperationBlock = ^(NSInteger currentIndex){
        @strongify(self);
        NSLog(@"banner 视图被点击");
    };
}
/// 滚动到顶部
- (void)_scrollToTop {
    [self.tableView setContentOffset:CGPointMake(0, 0)animated:YES];
}

#pragma mark - Override
/// 下拉刷新
- (void)tableViewDidTriggerHeaderRefresh{
    /// config param
    NSInteger page = 1;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@(page)forKey:@"page"];
    /// 请求banner数据 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *imageNames = @[@"tu1",
                                @"tu3" // 本地图片请填写全名
                                ];
        /// 配置数据
        self.headerView.localizationImageNamesGroup = imageNames;
        self.headerView.hidden = !(imageNames.count>0);
    });
    /// 请求商品数据
    /// 请求商品数据 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.75f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        /// 移除掉数据
        [self.dataSource removeAllObjects];
        /// 获取数据
//        NSData *data = [NSData dataNamed:[NSString stringWithFormat:@"SUGoodsData_%zd.data",(page)]];
//        SUGoodsData *goodsData = [SUGoodsData modelWithJSON:data];
//        /// 转化数据
//        NSArray *dataSource = [self _dataSourceWithGoodsData:goodsData];
        for (NSInteger i = 0; i<10; i++){
            /// 添加数据
            [self.dataSource addObject:@(i)];
        }
        /// 结束头部控件的刷新并刷新数据
        [self tableViewDidFinishTriggerHeader:YES reload:YES];
    });
}
/// 上拉加载
- (void)tableViewDidTriggerFooterRefresh{
    /// config param
    NSInteger page = self.page+1;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@(page)forKey:@"page"];
    
    /// 请求商品数据
    /// 请求商品数据 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.75f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        /// 获取数据
        for (NSInteger i = 0; i<10; i++){
            /// 添加数据
            [self.dataSource addObject:@(i)];
        }
        /// 结束尾部控件的刷新并刷新数据
        [self tableViewDidFinishTriggerHeader:NO reload:YES];
    });
}

/// config  cell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    KJHelpFristCell *cell = [KJHelpFristCell cellWithTableView:tableView];
    /// 处理事件
    @weakify(self);
    /// 头像
//    cell.avatarClickedHandler = ^(SUGoodsCell *goodsCell){
//        @strongify(self);
//        SUGoodsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.row];
//        [self _pushToPublicViewControllerWithTitle:viewModel.goods.nickName];
//    };
    return cell;
}

/// 文本内容区域
- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsZero;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /// 由于使用系统的autoLayout来计算cell的高度，每次滚动时都要重新计算cell的布局以此来获得cell的高度 这样一来性能不好
    /// 所以笔者采用实现计算好的cell的高度
    return 320;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 跳转到商品详请
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    self.scrollToTopButton.hidden = (offsetY < scrollView.height);
    
    CGFloat duration = 0.65;
    CGFloat titleViewAlpha = (offsetY >= 0)?1.0:0.;
    CGFloat navBarAlhpa = (offsetY >= self.headerView.height)?1.0:0.0;
    
    navBarAlhpa = (offsetY - self.headerView.height)/ self.headerView.height + 1;
    
    [UIView animateWithDuration:duration animations:^{
        self.navBar.backgroundColor = UIColorFromHEXA(0xfea43b, navBarAlhpa);
        self.titleView.alpha = titleViewAlpha;
    }];
    
    UIStatusBarStyle tempStyle = (offsetY >= self.headerView.height)?UIStatusBarStyleLightContent:UIStatusBarStyleDefault;
    BOOL tempStatusBarHidden = (offsetY >= 0)?NO:YES;
    if ((tempStyle == style_)&& (tempStatusBarHidden == statusBarHidden_)){
    } else {
        style_ = tempStyle;
        statusBarHidden_ = tempStatusBarHidden;
        /// 更新状态栏
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

////////////////// 以下为UI代码，不必过多关注 ///////////////////
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    /// FIXED : when data is empty ，the backgroundColor is exist
    return (self.dataSource.count==0)?.0001f:30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    /// FIXED : when data is empty ，show nothing
    if (self.dataSource.count==0)return nil;

    UILabel *la = InsertLabel(nil, CGRectMake(0, 0, SCREEN_WIDTH, 30), NSTextAlignmentLeft, @"  最新动态", SystemFontSize(12), [UIColor blackColor]);
    la.backgroundColor = self.view.backgroundColor;
    return la;
}

#pragma mark - Override
- (UIStatusBarStyle)preferredStatusBarStyle {
    return style_;
}
- (BOOL)prefersStatusBarHidden {
    return statusBarHidden_;
}
#pragma mark - 初始化子控件
- (void)setUI{
    /// Create NavBar;
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.navigationController.navigationBar.height+20)];
    navBar.backgroundColor = UIColorFromHEXA(0xfea43b,.0f);
    self.navBar = navBar;
    [self.view addSubview:navBar];
    
    /// 搜索框View
    CGFloat titleViewX = 26;
    CGFloat titleViewH = 28;
    CGFloat titleViewY = 20 + floor((navBar.height - 20 - titleViewH)/2);
    CGFloat titleViewW = kScreenW - 2 * titleViewX;
    SUSearchBarView *titleView = [[SUSearchBarView alloc] initWithFrame:CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH)];
    titleView.backgroundColor = [UIColor whiteColor];
    self.titleView = titleView;
    [navBar addSubview:titleView];
    
    /// 滚动到顶部的按钮
    CGFloat scrollToTopButtonW = 52;
    CGFloat scrollToTopButtonH = 90;
    CGFloat scrollToTopButtonX = (kScreenW - scrollToTopButtonW)- 12;
    CGFloat scrollToTopButtonY = (kScreenH - scrollToTopButtonH)- 60;
    UIButton *scrollToTopButton = [[UIButton alloc] initWithFrame:CGRectMake(scrollToTopButtonX, scrollToTopButtonY, scrollToTopButtonW, scrollToTopButtonH)];
    [scrollToTopButton setImage:[UIImage imageNamed:@"zuixindongtai"] forState:UIControlStateNormal];
    scrollToTopButton.hidden = YES;
    self.scrollToTopButton = scrollToTopButton;
    [self.view addSubview:scrollToTopButton];
    //// 添加事件处理
    [scrollToTopButton addTarget:self action:@selector(_scrollToTop)forControlEvents:UIControlEventTouchUpInside];
    
    /// 头视图 banner
    SDCycleScrollView *headerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, self.tableView.width/2)];
    headerView.autoScrollTimeInterval = 2.0f;
    headerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    headerView.placeholderImage = DefaultCoverImage;
    self.headerView = headerView;
    /// default is Hidden until have data to show
    headerView.hidden = YES;
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
}


@end

