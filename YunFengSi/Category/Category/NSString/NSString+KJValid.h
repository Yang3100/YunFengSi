//
//  NSString+KJValid.h
//  KJDevelopExample
//
//  Created by senba on 2017/6/12.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KJValid)

/// 检测字符串是否包含中文
+( BOOL)kj_isContainChinese:(NSString *)str;

/// 整形
+ (BOOL)kj_isPureInt:(NSString *)string;

/// 浮点型
+ (BOOL)kj_isPureFloat:(NSString *)string;

/// 有效的手机号码
+ (BOOL)kj_isValidMobile:(NSString *)str;

/// 纯数字
+ (BOOL)kj_isPureDigitCharacters:(NSString *)string;

/// 字符串为字母或者数字
+ (BOOL)kj_isValidCharacterOrNumber:(NSString *)str;
@end
