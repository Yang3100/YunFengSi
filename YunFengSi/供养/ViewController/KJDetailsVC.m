//
//  KJDetailsVC.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJDetailsVC.h"

#import "KJDetailsHeaderCell.h"

#import "MHTopicFrame.h"
#import "MHTopicCell.h"

@interface KJDetailsVC ()<UITableViewDelegate,UITableViewDataSource,MHTopicCellDelegate>

@property(nonatomic,strong) UITableView *mainTable;
@property(nonatomic,strong) NSMutableArray *topicFrames; // MHTopicFrame 模型
@property(nonatomic,strong) NSMutableArray *users; // users

@end

@implementation KJDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化数据
    [self _setupData];

    //
    [self setUI];
}

#pragma mark - 初始化数据，假数据
- (void)_setupData{
    NSString *textString = @"孤独之前是迷茫，孤独之后是成长；孤独没有不好，不接受孤独才不好；不合群是表面的孤独，合群了才是内心的孤独。那一天，在图书馆闲逛，书从中，这本书吸引了我，从那以后，睡前总会翻上几页。或许与初到一个陌生城市有关，或许因为近三十却未立而惆怅。孤独这个字眼对我而言，有着异常的吸引力。";
    NSDate *date = [NSDate date];
    // 初始化100条数据
    for (NSInteger i = 20; i>0; i--) {
        // 话题
        MHTopic *topic = [[MHTopic alloc] init];
        topic.topicId = [NSString stringWithFormat:@"%zd",i];
        topic.thumbNums = [NSObject mh_randomNumber:1000 to:100000];
        topic.thumb = [NSObject mh_randomNumber:0 to:1];
        
        // 构建时间假数据
        topic.creatTime = @"2018-01-07 18:18:18";
        
        topic.text = [textString substringFromIndex:[NSObject mh_randomNumber:0 to:textString.length-1]];
        topic.user = self.users[[NSObject mh_randomNumber:0 to:9]];
        
        NSInteger commentsCount = [NSObject mh_randomNumber:0 to:20];
        topic.commentsCount = commentsCount;
        for (NSInteger j = 0; j<commentsCount; j++) {
            MHComment *comment = [[MHComment alloc] init];
            comment.commentId = [NSString stringWithFormat:@"%zd%zd",i,j];
            comment.creatTime = @"2017-01-07 18:18:18";
            comment.text = [textString substringToIndex:[NSObject mh_randomNumber:0 to:30]];
            if (j%3==0) {
                MHUser *toUser = self.users[[NSObject mh_randomNumber:0 to:5]];
                comment.toUser = toUser;
            }
            
            MHUser *fromUser = self.users[[NSObject mh_randomNumber:6 to:9]];
            comment.fromUser = fromUser;
            [topic.comments addObject:comment];
        }
        
        [self.topicFrames addObject:[self _topicFrameWithTopic:topic]];
    }
}

#pragma mark - 辅助方法
/** topic --- topicFrame */
- (MHTopicFrame *)_topicFrameWithTopic:(MHTopic *)topic{
    MHTopicFrame *topicFrame = [[MHTopicFrame alloc] init];
    // 传递微博模型数据，计算所有子控件的frame
    topicFrame.topic = topic;
    
    return topicFrame;
}

#pragma mark - MHTopicCellDelegate
- (void)topicCellForClickedThumbAction:(MHTopicCell *)topicCell{
    MHLog(@"---点击👍按钮---");
}

- (void)topicCellForClickedMoreAction:(MHTopicCell *)topicCell{
    MHLog(@"---点击更多按钮---");
    // 修改数据源方法
    MHTopic *topic = topicCell.topicFrame.topic;
    topic.thumb = !topic.isThumb;
    if (topic.isThumb) {
        topic.thumbNums+=1;
    }else{
        topic.thumbNums-=1;
    }
    
    // 刷新数据
    [self.mainTable reloadData];
}

- (void) topicCellDidClickedTopicContent:(MHTopicCell *)topicCell{
    MHLog(@"这里评论 -- :%@的帖子",topicCell.topicFrame.topic.user.nickname);
}

- (void)topicCellDidClickedUser:(MHTopicCell *)topicCell{
//    MHUserInfoController *userInfo = [[MHUserInfoController alloc] init];
//    userInfo.user = topicCell.topicFrame.topic.user;
//    [self.navigationController pushViewController:userInfo animated:YES];
}

- (void)topicCell:(MHTopicCell *)topicCell didClickedUser:(MHUser *)user{
//    MHUserInfoController *userInfo = [[MHUserInfoController alloc] init];
//    userInfo.user = user;
//    [self.navigationController pushViewController:userInfo animated:YES];
}

- (void)topicCell:(MHTopicCell *)topicCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MHTopicFrame *topicFrame = topicCell.topicFrame;
    MHCommentFrame *commentFrame = topicFrame.commentFrames[indexPath.row];
    
    MHUser *fromUser = commentFrame.comment.fromUser;
    
    MHLog(@"这里回复 -- :%@",fromUser.nickname);
}

#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return self.topicFrames.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        KJDetailsHeaderCell *cell = [KJDetailsHeaderCell cellWithTableView:tableView];
        cell.model = @"";
        return cell;
    }else{
        MHTopicCell *cell = [MHTopicCell cellWithTableView:tableView];
        MHTopicFrame *topicFrame = self.topicFrames[indexPath.row];
        cell.topicFrame = topicFrame;
        cell.delegate = self;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [self.mainTable fd_heightForCellWithIdentifier:@"KJDetailsHeaderCell" cacheByKey:indexPath configuration:^(KJDetailsHeaderCell *cell) {
        }];
    }else{
        return 0.1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return UITableViewAutomaticDimension;
    }else{
        MHTopicFrame *topicFrame = self.topicFrames[indexPath.row];
        if (topicFrame.tableViewFrame.size.height==0) {
            return topicFrame.height+topicFrame.tableViewFrame.size.height;
        }else{
            return topicFrame.height+topicFrame.tableViewFrame.size.height+MHTopicVerticalSpace;
        }
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        UILabel *la = InsertLabel(nil, CGRectMake(0, 0, SCREEN_WIDTH, 30), NSTextAlignmentLeft, @"  评论(10)", SystemFontSize(12), [UIColor blackColor]);
        la.backgroundColor = self.view.backgroundColor;
        return la;
    }else{
        return nil;
    }
}
#pragma mark - setUI
-(void)setUI{
    [self.view addSubview:self.mainTable];
    [_mainTable registerClass:[KJDetailsHeaderCell class] forCellReuseIdentifier:@"KJDetailsHeaderCell"];
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

#pragma mark - 私有方法
- (NSMutableArray *)topicFrames{
    if (_topicFrames == nil) {
        _topicFrames = [[NSMutableArray alloc] init];
    }
    return _topicFrames;
}

- (NSMutableArray *)users{
    if (_users == nil) {
        _users = [[NSMutableArray alloc] init];
        
        MHUser *user0 = [[MHUser alloc] init];
        user0.userId = @"1000";
        user0.nickname = @"CoderMikeHe";
        user0.avatarUrl = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1206211006,1884625258&fm=58";
        [_users addObject:user0];
        
        
        MHUser *user1 = [[MHUser alloc] init];
        user1.userId = @"1001";
        user1.nickname = @"吴亦凡";
        user1.avatarUrl = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2625917416,3846475495&fm=58";
        [_users addObject:user1];
        
        
        MHUser *user2 = [[MHUser alloc] init];
        user2.userId = @"1002";
        user2.nickname = @"杨洋";
        user2.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=413353707,3948222604&fm=58";
        [_users addObject:user2];
        
        
        MHUser *user3 = [[MHUser alloc] init];
        user3.userId = @"1003";
        user3.nickname = @"陈伟霆";
        user3.avatarUrl = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=3937650650,3185640398&fm=58";
        [_users addObject:user3];
        
        
        MHUser *user4 = [[MHUser alloc] init];
        user4.userId = @"1004";
        user4.nickname = @"张艺兴";
        user4.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1691925636,1723246683&fm=58";
        [_users addObject:user4];
        
        
        MHUser *user5 = [[MHUser alloc] init];
        user5.userId = @"1005";
        user5.nickname = @"鹿晗";
        user5.avatarUrl = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=437161406,3838120455&fm=58";
        [_users addObject:user5];
        
        
        MHUser *user6 = [[MHUser alloc] init];
        user6.userId = @"1006";
        user6.nickname = @"杨幂";
        user6.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1663450221,575161902&fm=58";
        [_users addObject:user6];
        
        
        MHUser *user7 = [[MHUser alloc] init];
        user7.userId = @"1007";
        user7.nickname = @"唐嫣";
        user7.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1655233011,1466773944&fm=58";
        [_users addObject:user7];
        
        
        MHUser *user8 = [[MHUser alloc] init];
        user8.userId = @"1008";
        user8.nickname = @"刘亦菲";
        user8.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=3932899473,3078920054&fm=58";
        [_users addObject:user8];
        
        
        MHUser *user9 = [[MHUser alloc] init];
        user9.userId = @"1009";
        user9.nickname = @"林允儿";
        user9.avatarUrl = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2961367360,923857578&fm=58";
        [_users addObject:user9];
        
    }
    return _users;
}

@end
