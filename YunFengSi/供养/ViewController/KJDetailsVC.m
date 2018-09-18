//
//  KJDetailsVC.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJDetailsVC.h"

#import "KJDetailsHeaderCell.h"
#import "KJDetailCommentCell.h"

@interface KJDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTable;

@end

@implementation KJDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.mainTable registerClass:[KJDetailsHeaderCell class] forCellReuseIdentifier:@"KJDetailsHeaderCell"];
    [self.mainTable registerClass:[KJDetailCommentCell class] forCellReuseIdentifier:@"KJDetailCommentCell"];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [self.mainTable fd_heightForCellWithIdentifier:@"KJDetailsHeaderCell" cacheByKey:indexPath configuration:^(KJDetailsHeaderCell *cell) {
        }];
    }else{
        return [self.mainTable fd_heightForCellWithIdentifier:@"KJDetailCommentCell" cacheByKey:indexPath configuration:^(KJDetailCommentCell *cell) {
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        KJDetailsHeaderCell *cell = [KJDetailsHeaderCell cellWithTableView:tableView];
        cell.model = @"";
        return cell;
    }else{
        KJDetailCommentCell *cell = [KJDetailCommentCell cellWithTableView:tableView];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 40;
    }else{
        return 0.1;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UILabel *la = InsertLabel(nil, CGRectMake(0, 0, SCREEN_WIDTH, 30), NSTextAlignmentLeft, @"评论(10)", SystemFontSize(12), [UIColor blackColor]);
        la.backgroundColor = self.view.backgroundColor;
        return la;
    }else{
        return nil;
    }
}
#pragma mark - setUI
-(void)setUI{
    [self.view addSubview:self.mainTable];
}
- (UITableView*)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:(UITableViewStylePlain)];
        //去掉自带分割线
        [_mainTable setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.backgroundColor = DefaultBackgroudColor;
    }
    return _mainTable;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
////    NSLog(@"%f",_mainTable.contentOffset.y);
//    if (_mainTable.contentOffset.y >= SCREEN_HEIGHT-64) {
//        _mainTable.bounces = NO;
//    }
//    else {
//        _mainTable.bounces = YES;
//    }
//}



@end
