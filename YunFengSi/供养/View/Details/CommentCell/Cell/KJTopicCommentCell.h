//
//  KJTopicCommentCell.h
//  KJDevelopExample
//
//  Created by CoderMikeHe on 17/2/9.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJCommentFrame,KJTopicCommentCell,KJUser;

@protocol KJTopicCommentCellDelegate <NSObject>

@optional
/** 点击评论cell的昵称 */
- (void)topicCommentCell:(KJTopicCommentCell *)topicCommentCell didClickedUser:(KJUser *)user;

@end

@interface KJTopicCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 评论Frame */
@property (nonatomic,strong) KJCommentFrame *commentFrame;

/** 代理 */
@property (nonatomic,weak) id<KJTopicCommentCellDelegate> delegate;

@end
