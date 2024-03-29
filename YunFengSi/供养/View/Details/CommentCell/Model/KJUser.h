//
//  KJUser.h
//  KJDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJUser : NSObject

/** userId */
@property (nonatomic , copy)NSString *userId;

/** 用户昵称 */
@property (nonatomic , copy)NSString *nickname;

/** 头像地址 */
@property (nonatomic , copy)NSString *avatarUrl;

@end
