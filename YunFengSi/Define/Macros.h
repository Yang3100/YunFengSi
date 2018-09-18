//
//  Macros.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define _weakself __weak typeof(self) weakself = self
#pragma mark ********** 快捷获取当前进程的代理对象指针 ************/
#define kAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)

#pragma mark *******    屏幕的宽高   *********/
#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
#define KStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
// 等比例缩放系数
#define KEY_WINDOW    ([UIApplication sharedApplication].keyWindow)
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_SCALE  ((SCREEN_WIDTH > 414) ? (SCREEN_HEIGHT/375.0) : (SCREEN_WIDTH/375.0))
#define Handle(x)        ((x)*SCREEN_SCALE)
#define Handle_width(w)  ((w)*SCREEN_SCALE)
#define Handle_height(h) ((h)*SCREEN_SCALE)
#define HJSIZEX(x) ((SCREEN_WIDTH/750)*(x))
#define HJSIZEY(y) ((SCREEN_HEIGHT/1334)*(y))
#define SCREEN_MAX_LENGTH   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

/**
 iPhoneX适配
 */
#define iPhoneX ([UIScreen instanceMethodForSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125,2436),[[UIScreen mainScreen] currentMode].size):NO)

#define kTABBAR_HEIGHT (iPhoneX?(49.f+34.f):49.f)

/**
 Return the statusBar height.
 */
#define kSTATUSBAR_HEIGHT (iPhoneX?44.0f:20.f)

#define LiveRemandViewY   (iPhoneX?44.0f:0.f)

/**
 Return the navigationBar height.
 */
#define kNAVIGATION_HEIGHT (44.f)

/**
 Return the (navigationBar + statusBar) height.
 */
#define kSTATUSBAR_NAVIGATION_HEIGHT (iPhoneX?88.0f:64.f)

/**
 Return 没有tabar 距 底边高度
 */
#define BOTTOM_SPACE_HEIGHT (iPhoneX?34.0f:0.0f)

// 通用控件左右间隔
#define kSpaceToLeftOrRight Handle(10)

// 底部条高度
#define kBottomViewHeight 48

// 导航条高度
#define  kNavigationHeight 64

#define ChatToolsHeight  50+BOTTOM_SPACE_HEIGHT         // 聊天工具框高度
#define EmojiKeyboard_Height 200+BOTTOM_SPACE_HEIGHT    // 表情键盘的高度
#define LiveChatToolsHeight 49          // 直播间聊天工具栏高度
#define Live_EmojiKeyboard_Height  200  // 直播间表情键盘高度

#define  DeviceIsIPhoneX   [[HNTools deviceVersion] isEqualToString:@"iPhone X"]?1:0

#pragma mark *******    颜色   *********/
#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define UIColorHexFromRGB(hex) UIColorFromHEXA(hex,1.0)

#define MainColor             UIColorFromHEXA(0xfea43b,1.0)  // app 主色调
#define BtnUnEnableBgColor    UIColorFromHEXA(0xbbbbbb,1.0)  // 按钮不可点击状态
#define BtnBgColor            UIColorFromHEXA(0xFFD308,1.0)  // 按钮可点击状态
#define DefaultTitleColor     UIColorFromHEXA(0x343434,1.0)  // 字体颜色
#define DefaultBackgroudColor     UIColorFromHEXA(0xEEEEEE,1.0)  // 视图里面的背景颜色
#define DefaultLineColor      UIColorFromHEXA(0x000000,1.0)  // 边框线的颜色
#define KJTableFillColor [UIColor groupTableViewBackgroundColor]  // 填充颜色,获取的是父视图Table背景颜色

#pragma mark *******    图片资源相关   *********
#define GetImage(imageName)    [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
#define DefaultHeaderImage    GetImage(@"me_no_header")     // 头像占位图

#pragma mark *******    系统默认字体设置和自选字体设置   *********/
#define SystemFontSize(fontsize) [UIFont systemFontOfSize:(fontsize)]
#define SystemBoldFontSize(fontsize) [UIFont boldSystemFontOfSize:(fontsize)]
#define CustomFontSize(fontname,fontsize) [UIFont fontWithName:fontname size:fontsize]

#pragma mark ********** 工程相关 ************/
/** 获取APP名称 */
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
/** 程序版本号 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 获取APP build版本 */
#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

#define kAppName  @"云峰寺"
#define kIDName   @"云号"
#define kAppIcon  GetImage(@"yy")


#endif /* Macros_h */
