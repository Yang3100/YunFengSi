//
//  KJMeVC.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJMeVC.h"
#import "CMHWaterfall.h"
#import "CMHWaterfallCell.h"
// 瀑布流
#import <CHTCollectionViewWaterfallLayout.h>

@interface KJMeVC ()<CHTCollectionViewDelegateWaterfallLayout>
/// temps
@property (nonatomic,readwrite,strong) NSMutableArray *temps;

@end

@implementation KJMeVC

/// 重写init方法，配置你想要的属性
- (instancetype)init{
    if (self=[super init]) {
        /// create collectionViewLayout
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumColumnSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.columnCount = 4; // 每行个数
        layout.footerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.collectionViewLayout = layout;
        self.perPage = 30;
        
        /// 支持上下拉加载和刷新
        self.shouldPullUpToLoadMore = YES;
        self.shouldPullDownToRefresh = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 设置
    [self _setup];
    
    /// 设置导航栏
    [self _setupNavigationItem];
    
    /// 设置子控件
    [self _setupSubViews];
    
    /// 布局子空间
    [self _makeSubViewsConstraints];
    
    /// 注册cell
    [self.collectionView registerClass:[CMHWaterfallCell class]
            forCellWithReuseIdentifier:@"CMHWaterfallCell"];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:@"footerView"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;//这里很关键，分两组，把banner放在第一组的footer，把分类按钮放在第二组的header
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"CMHWaterfallCell" forIndexPath:indexPath];
}

- (void)configureCell:(CMHWaterfallCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell configureModel:object];
}

- (void)collectionViewDidTriggerHeaderRefresh{
    /// 下拉刷新事件 子类重写
    self.page = 1;
    /// 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        /// 清掉数据源
        [self.dataSource removeAllObjects];
        
        /// 模拟数据
        //        for (NSInteger i = 0; i < self.perPage; i++) {
        //            [self.dataSource addObject:self.temps[[NSObject kj_randomNumber:0 to:self.temps.count]]];
        //        }
        [self.dataSource addObjectsFromArray:self.temps];
        
        /// 告诉系统你是否结束刷新 , 这个方法我们手动调用，无需重写
        [self collectionViewDidFinishTriggerHeader:YES reload:YES];
    });
}

- (void)collectionViewDidTriggerFooterRefresh{
    /// 下拉加载事件 子类重写
    self.page = self.page + 1;
    /// 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //        /// 模拟数据
        //        /// 假设第3页的时候请求回来的数据 < self.perPage 模拟网络加载数据不够的情况
        //        NSInteger count = (self.page >= 4)?18:self.perPage;
        //
        //        for (NSInteger i = 0; i < count; i++) {
        //            [self.dataSource addObject:self.temps[[NSObject kj_randomNumber:0 to:10]]];
        //        }
        
        [self.dataSource addObjectsFromArray:self.temps];
        
        /// 告诉系统你是否结束刷新 , 这个方法我们手动调用，无需重写
        [self collectionViewDidFinishTriggerHeader:NO reload:YES];
    });
}

#pragma mark - 事件处理Or辅助方法
#pragma mark - UICollectionViewDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 100;
    }else{
        return 0.0001;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        if (indexPath.section==0) {
            if (reusableView.subviews.count == 0) {//加一个限制，避免无限创建新的
                UIImageView*bgImageView = InsertImageView(reusableView, CGRectZero, GetImage(@"tu2"));
                [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(UIEdgeInsetsZero);
                }];
                UIImageView*headerImageView = InsertImageView(reusableView, CGRectZero, GetImage(@"timg1"));
                [KJTools makeCornerRadius:Handle(40) borderColor:MainColor layer:headerImageView.layer borderWidth:1];
                [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.mas_equalTo(reusableView).mas_offset(Handle(10));
                    make.width.height.mas_equalTo(Handle(80));
                }];
                UILabel*_nameLabel=InsertLabel(reusableView, CGRectZero, NSTextAlignmentLeft, @"77..", SystemFontSize(14), [UIColor whiteColor]);
                [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(reusableView).mas_offset(Handle(30));
                    make.height.mas_equalTo(Handle(20));
                    make.left.mas_equalTo(headerImageView.mas_right).mas_offset(Handle(10));
                }];
                UILabel*Label=InsertLabel(reusableView, CGRectZero, NSTextAlignmentLeft, @"CUICatalog: Invalid asset name supplied:SULoginController _loginBtn", SystemFontSize(12), [UIColor whiteColor]);
                Label.numberOfLines = 0;
                [Label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_nameLabel.mas_bottom).mas_offset(Handle(10));
                    make.right.mas_equalTo(reusableView).mas_offset(Handle(-10));
                    make.left.mas_equalTo(headerImageView.mas_right).mas_offset(Handle(10));
                }];
            }
        }else{
            [reusableView removeAllSubviews];
        }
    }
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
/// 子类必须override
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMHWaterfall *waterfall = self.dataSource[indexPath.item];
    CGFloat width = SCREEN_WIDTH/2;
    CGFloat height = width * waterfall.height / waterfall.width;
    return CGSizeMake(width, height);
}

#pragma mark - 初始化
- (void)_setup{
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44);
    self.collectionView.backgroundColor = DefaultBackgroudColor;
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    self.title = @"我的";
}

#pragma mark - 设置子控件
- (void)_setupSubViews{
    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}

- (NSMutableArray*)temps{
    if (!_temps) {
        _temps = [NSMutableArray array];
        NSArray *name = @[@"迪丽热巴",@"吴亦凡",@"鹿晗",@"杨幂"];
        NSArray *im = @[@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=280169289,4186753272&fm=11&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2300701076,252080396&fm=27&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=991701608,3109991055&fm=27&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2134095636,3035683221&fm=27&gp=0.jpg"];
        int a = (int)name.count-1;
        int b = (int)im.count-1;
        for (int i=0; i<23; i++) {
            CMHWaterfall *wf8 = [[CMHWaterfall alloc] init];
            wf8.title = name[[KJTools getRandomNumber:0 to:a]];
            wf8.imageUrl = im[[KJTools getRandomNumber:0 to:b]];
            wf8.width = 200;
            wf8.height = 200;
            [_temps addObject:wf8];
            
        }
    }
    return _temps;
}

@end

