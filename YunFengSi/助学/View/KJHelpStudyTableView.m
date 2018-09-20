//
//  KJHelpStudyTableView.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHelpStudyTableView.h"
#import "KJHelpFristCell.h"
#import "KJHelpSecondCell.h"

#import "KJHelpDetailsVC.h"

@interface KJHelpStudyTableView()<UITableViewDelegate,UITableViewDataSource>{
    __block CGFloat h;
}

@property(nonatomic,strong) UITableView *mainTable;

@end

@implementation KJHelpStudyTableView

- (void)getHeight:(CGFloat)height{
    h = height;
    [self setUI];
}

- (void)setUI{
    [self addSubview:self.mainTable];
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(self->h);
    }];
    // 注册cell
    [self.mainTable registerClass:[KJHelpFristCell class] forCellReuseIdentifier:@"KJHelpFristCell"];
    [self.mainTable registerClass:[KJHelpSecondCell class] forCellReuseIdentifier:@"KJHelpSecondCell"];
}
- (UITableView*)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        //去掉自带分割线
        [_mainTable setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.backgroundColor = DefaultBackgroudColor;
    }
    return _mainTable;
}


#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return [self.mainTable fd_heightForCellWithIdentifier:@"KJHelpFristCell" cacheByKey:indexPath configuration:^(KJHelpFristCell *cell) {
        }];
    }else{
        return [self.mainTable fd_heightForCellWithIdentifier:@"KJHelpSecondCell" cacheByKey:indexPath configuration:^(KJHelpSecondCell *cell) {
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        KJHelpFristCell *cell = [KJHelpFristCell cellWithTableView:tableView];
//        cell.model = @"";
        return cell;
    }else{
        KJHelpSecondCell *cell = [KJHelpSecondCell cellWithTableView:tableView];
        //        cell.model = @"";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KJHelpDetailsVC *vc = [[KJHelpDetailsVC alloc]init];
    vc.view.backgroundColor = DefaultBackgroudColor;
    vc.navigationItem.title = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    KJBaseNavigationController *nav = [[KJBaseNavigationController alloc]initWithRootViewController:vc];
    [[KJTools currentViewController] presentViewController:nav animated:YES completion:^{
        
    }];
}


@end
