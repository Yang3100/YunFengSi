//
//  NSAttributedString+KJSize.m
//  SenbaUsed
//
//  Created by senba on 2017/5/29.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "NSAttributedString+KJSize.h"

@implementation NSAttributedString (KJSize)
- (CGSize)kj_sizeWithLimitSize:(CGSize)limitSize{
    CGSize theSize;
    CGRect rect = [self boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    theSize.width = ceil(rect.size.width);
    theSize.height = ceil(rect.size.height);
    return theSize;
}

- (CGSize)kj_sizeWithLimitWidth:(CGFloat)limitWidth{
    return [self kj_sizeWithLimitSize:CGSizeMake(limitWidth, MAXFLOAT)];
}
@end
