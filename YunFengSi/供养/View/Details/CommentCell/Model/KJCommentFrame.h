//
//  KJCommentFrame.h
//  KJDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJComment.h"
@interface KJCommentFrame : NSObject
/** 内容尺寸 */
@property (nonatomic , assign , readonly)CGRect textFrame;
/** cell高度 */
@property (nonatomic , assign , readonly)CGFloat cellHeight;

/** 最大宽度 外界传递 */
@property (nonatomic , assign)CGFloat maxW;

/** 评论模型 外界传递 */
@property (nonatomic , strong)KJComment *comment;
@end
