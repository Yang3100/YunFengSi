//
//  KJTopicCell.h
//  KJDevelopExample
//
//  Created by CoderMikeHe on 17/2/9.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KJTopicFrame,KJTopicCell,KJUser;

@protocol KJTopicCellDelegate <NSObject>

@optional
/** 点击头像或昵称的事件回调 */
- (void)topicCellDidClickedUser:(KJTopicCell *)topicCell;

/** 点击头像或昵称的事件回调 */
- (void)topicCellDidClickedTopicContent:(KJTopicCell *)topicCell;

/** 用户点击更多按钮 */
- (void)topicCellForClickedMoreAction:(KJTopicCell *)topicCell;

/** 用户点击点赞按钮 */
- (void)topicCellForClickedThumbAction:(KJTopicCell *)topicCell;

/** 点击评论cell的昵称 */
- (void)topicCell:(KJTopicCell *)topicCell didClickedUser:(KJUser *)user;
/** 点击某一行的cell */
- (void)topicCell:(KJTopicCell *)topicCell  didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface KJTopicCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 话题模型数据源 */
@property (nonatomic , strong)KJTopicFrame *topicFrame;

/** 代理 */
@property (nonatomic , weak)id <KJTopicCellDelegate> delegate;

@end
