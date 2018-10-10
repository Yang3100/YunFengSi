//
//  Macros.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

// 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#ifdef DEBUG
#define NSLog(format, ...)printf("\n[%s] %s [第%d行] 🤨🤨 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

// 日记输出宏
#ifdef DEBUG // 调试状态, 打开LOG功能
#define KJLog(...)NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define KJLog(...)
#endif

/// 适配iPhone X + iOS 11
#define  KJAdjustsScrollViewInsets_Never(__scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([__scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]){\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = __scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)

// 是否为空对象
#define KJObjectIsNil(__object)   ((nil == __object) || [__object isKindOfClass:[NSNull class]])

// 字符串为空
#define KJStringIsEmpty(__string) ((__string.length == 0) || KJObjectIsNil(__string))

// 字符串不为空
#define KJStringIsNotEmpty(__string) (!KJStringIsEmpty(__string))

// 数组为空
#define KJArrayIsEmpty(__array)   ((KJObjectIsNil(__array)) || (__array.count==0))

#define _weakself __weak typeof(self)weakself = self
#pragma mark ********** 快捷获取当前进程的代理对象指针 ************/
#define kAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)

// IOS版本
#define KJIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

/// 机型相关
#define KJ_IS_IPAD   (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
#define KJ_IS_IPHONE (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
#define KJ_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

/// 屏幕尺寸相关
#define KJ_SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define KJ_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define KJ_SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])
#define KJ_SCREEN_MAX_LENGTH (MAX(KJ_SCREEN_WIDTH, KJ_SCREEN_HEIGHT))
#define KJ_SCREEN_MIN_LENGTH (MIN(KJ_SCREEN_WIDTH, KJ_SCREEN_HEIGHT))

/// 手机类型相关
#define KJ_IS_IPHONE_4_OR_LESS  (KJ_IS_IPHONE && KJ_SCREEN_MAX_LENGTH  < 568.0)
#define KJ_IS_IPHONE_5          (KJ_IS_IPHONE && KJ_SCREEN_MAX_LENGTH == 568.0)
#define KJ_IS_IPHONE_6          (KJ_IS_IPHONE && KJ_SCREEN_MAX_LENGTH == 667.0)
#define KJ_IS_IPHONE_6P         (KJ_IS_IPHONE && KJ_SCREEN_MAX_LENGTH == 736.0)
#define KJ_IS_IPHONE_X          (KJ_IS_IPHONE && KJ_SCREEN_MAX_LENGTH == 812.0)

/// 导航条高度
#define KJ_APPLICATION_TOP_BAR_HEIGHT (KJ_IS_IPHONE_X?88.0f:64.0f)
/// tabBar高度
#define KJ_APPLICATION_TAB_BAR_HEIGHT (KJ_IS_IPHONE_X?83.0f:49.0f)
/// 工具条高度 (常见的高度)
#define KJ_APPLICATION_TOOL_BAR_HEIGHT_44  44.0f
#define KJ_APPLICATION_TOOL_BAR_HEIGHT_49  49.0f
/// 状态栏高度
#define KJ_APPLICATION_STATUS_BAR_HEIGHT (KJ_IS_IPHONE_X?44:20.0f)


#pragma mark *******    屏幕的宽高   *********/
// 屏幕总尺寸
#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height
#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
// 等比例缩放系数
#define SCREEN_SCALE  ((SCREEN_WIDTH > 414)? (SCREEN_HEIGHT/375.0): (SCREEN_WIDTH/375.0))
#define Handle(x)    ((x)*SCREEN_SCALE)

// 通用控件左右间隔
#define kSpaceToLeftOrRight          Handle(10)
#define KJTopicVerticalSpace         kSpaceToLeftOrRight
#define KJCommentContentLineSpacing  kSpaceToLeftOrRight
#define KJTopicHorizontalSpace       kSpaceToLeftOrRight
// 二级评价
#define KJCommentHorizontalSpace     Handle(11.0f)
#define KJCommentVerticalSpace       Handle(7.0f)
#define KJTopicAvatarWH              Handle(30.0f) // 话题头像宽高
#define KJTopicMoreButtonW           24.0f  // 话题更多按钮宽
#define KJGlobalBottomLineHeight     0.55f  // 线高

#pragma mark *******    颜色   *********/
#define UIColorFromHEXA(hex,a)    [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define UIColorFromRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]  // rgb颜色+透明度
#define UIColorHexFromRGB(hex)    UIColorFromHEXA(hex,1.0)


#define MainColor             UIColorFromHEXA(0xfea43b,1.0) // app 主色调
#define BtnUnEnableBgColor    UIColorFromHEXA(0xbbbbbb,1.0) // 按钮不可点击状态
#define BtnBgColor            UIColorFromHEXA(0xFFD308,1.0) // 按钮可点击状态
#define DefaultTitleColor     UIColorFromHEXA(0x343434,1.0) // 字体颜色
#define DefaultBackgroudColor UIColorFromHEXA(0xf9f6f6,1.0) // 视图里面的背景颜色
#define DefaultLineColor      UIColorFromHEXA(0x000000,0.5) // 边框线的颜色
// 填充颜色,获取的是父视图Table背景颜色
#define KJTableFillColor      [UIColor groupTableViewBackgroundColor]


#pragma mark *******    图片资源相关   *********
#define GetImage(imageName)  [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
#define DefaultHeaderImage   GetImage(@"me_no_header")    // 头像占位图
#define DefaultCoverImage    GetImage(@"me_no_cover")     // 封面占位图

#pragma mark *******    系统默认字体设置和自选字体设置   *********/
#define SystemFontSize(fontsize)[UIFont systemFontOfSize:(fontsize)]
#define SystemBoldFontSize(fontsize)[UIFont boldSystemFontOfSize:(fontsize)]
#define CustomFontSize(fontname,fontsize)[UIFont fontWithName:fontname size:fontsize]

#pragma mark ********** 工程相关 ************/
/** 获取APP名称 */
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
/** 程序版本号 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 获取APP build版本 */
#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

#define kAppName  @"云峰寺"
#define kIDName   @"云号"
#define kAppIcon  GetImage(@"timg1")


#endif /* Macros_h */
