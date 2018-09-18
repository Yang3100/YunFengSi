//
//  KJFendCollectionView.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJFendCollectionView.h"
#import "KJFendCollectionViewCell.h"
#import "KJDetailsVC.h"

@interface KJFendCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    __block CGFloat h;
}

@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KJFendCollectionView


- (void)getHeight:(CGFloat)height Data:(NSObject*)model{
    h = height;
    [self setUI];
}

- (void)setUI{
    [self addSubview:self.mainCollectionView];
}

#pragma mark - UICollectionViewDelegate
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KJFendCollectionViewCell *cell = (KJFendCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"KJFendCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KJFendCollectionViewCell *cell = (KJFendCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    KJDetailsVC *vc = [[KJDetailsVC alloc]init];
    vc.view.backgroundColor = DefaultBackgroudColor;
    KJBaseNavigationController *nav = [[KJBaseNavigationController alloc]initWithRootViewController:vc];
    vc.navigationItem.title = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [[KJTools currentViewController] presentViewController:nav animated:YES completion:^{
        
    }];
}


#pragma mark - getter
- (UICollectionView *)mainCollectionView{
    if (!_mainCollectionView){
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        //该方法也可以设置itemSize
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/3, (SCREEN_WIDTH-60)/3*1.5);
        
        //2.初始化collectionView
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h) collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中一致
        [_mainCollectionView registerClass:[KJFendCollectionViewCell class] forCellWithReuseIdentifier:@"KJFendCollectionViewCell"];
        
        //4.设置代理
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        
    }
    return _mainCollectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray){
        _dataArray = [NSMutableArray array];
        
        for (NSInteger i=0; i<10; i++) {
            [_dataArray addObject:@(i)];
        }
    }
    return _dataArray;
}

@end
