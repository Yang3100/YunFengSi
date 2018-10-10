//
//  KJCommentFrame.m
//  KJDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import "KJCommentFrame.h"

@interface KJCommentFrame ()

/** 内容尺寸 */
@property (nonatomic , assign)CGRect textFrame;
/** cell高度 */
@property (nonatomic , assign)CGFloat cellHeight;

@end


@implementation KJCommentFrame

#pragma mark - Setter

- (void)setComment:(KJComment *)comment{
    _comment = comment;
    
    // 文本内容
    CGFloat textX = KJCommentHorizontalSpace;
    CGFloat textY = KJCommentVerticalSpace;
    CGSize  textLimitSize = CGSizeMake(self.maxW - 2 * textX, MAXFLOAT);
    CGFloat textH = [YYTextLayout layoutWithContainerSize:textLimitSize text:comment.attributedText].textBoundingSize.height;
    
    self.textFrame = (CGRect){{textX , textY} , {textLimitSize.width , textH}};
    
    self.cellHeight = CGRectGetMaxY(self.textFrame)+ KJCommentVerticalSpace;
}

@end
