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
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] 🤨🤨 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

// 日记输出宏
#ifdef DEBUG // 调试状态, 打开LOG功能
#define MHLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define MHLog(...)
#endif

/// 适配iPhone X + iOS 11
#define  MHAdjustsScrollViewInsets_Never(__scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([__scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
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
#define MHObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])

// 字符串为空
#define MHStringIsEmpty(__string) ((__string.length == 0) || MHObjectIsNil(__string))

// 字符串不为空
#define MHStringIsNotEmpty(__string)  (!MHStringIsEmpty(__string))

// 数组为空
#define MHArrayIsEmpty(__array) ((MHObjectIsNil(__array)) || (__array.count==0))

#define _weakself __weak typeof(self) weakself = self
#pragma mark ********** 快捷获取当前进程的代理对象指针 ************/
#define kAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)

// IOS版本
#define MHIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define MH_iOS7_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define MH_iOS8_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define MH_iOS9_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)
#define MH_iOS10_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)

/// 类型相关
#define MH_IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define MH_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define MH_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

/// 屏幕尺寸相关
#define MH_SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define MH_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define MH_SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])
#define MH_SCREEN_MAX_LENGTH (MAX(MH_SCREEN_WIDTH, MH_SCREEN_HEIGHT))
#define MH_SCREEN_MIN_LENGTH (MIN(MH_SCREEN_WIDTH, MH_SCREEN_HEIGHT))

/// 手机类型相关
#define MH_IS_IPHONE_4_OR_LESS  (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH  < 568.0)
#define MH_IS_IPHONE_5          (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH == 568.0)
#define MH_IS_IPHONE_6          (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH == 667.0)
#define MH_IS_IPHONE_6P         (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH == 736.0)
#define MH_IS_IPHONE_X          (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH == 812.0)

/// 导航条高度
#define MH_APPLICATION_TOP_BAR_HEIGHT (MH_IS_IPHONE_X?88.0f:64.0f)
/// tabBar高度
#define MH_APPLICATION_TAB_BAR_HEIGHT (MH_IS_IPHONE_X?83.0f:49.0f)
/// 工具条高度 (常见的高度)
#define MH_APPLICATION_TOOL_BAR_HEIGHT_44  44.0f
#define MH_APPLICATION_TOOL_BAR_HEIGHT_49  49.0f
/// 状态栏高度
#define MH_APPLICATION_STATUS_BAR_HEIGHT (MH_IS_IPHONE_X?44:20.0f)


#pragma mark *******    屏幕的宽高   *********/
// 屏幕总尺寸
#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height
#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
// 等比例缩放系数
#define SCREEN_SCALE  ((SCREEN_WIDTH > 414) ? (SCREEN_HEIGHT/375.0) : (SCREEN_WIDTH/375.0))
#define Handle(x)     ((x)*SCREEN_SCALE)

// 通用控件左右间隔
#define kSpaceToLeftOrRight          Handle(10)
#define MHTopicVerticalSpace         kSpaceToLeftOrRight
#define MHCommentContentLineSpacing  kSpaceToLeftOrRight
#define MHTopicHorizontalSpace       kSpaceToLeftOrRight
// 二级评价
#define MHCommentHorizontalSpace     Handle(11.0f)
#define MHCommentVerticalSpace       Handle(7.0f)
#define MHTopicAvatarWH              Handle(30.0f)  // 话题头像宽高
#define MHTopicMoreButtonW           24.0f // 话题更多按钮宽
#define MHGlobalBottomLineHeight     0.55f  // 线高

#pragma mark *******    颜色   *********/
#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]  // rgb颜色+透明度
#define UIColorHexFromRGB(hex) UIColorFromHEXA(hex,1.0)


#define MainColor             UIColorFromHEXA(0xfea43b,1.0)  // app 主色调
#define BtnUnEnableBgColor    UIColorFromHEXA(0xbbbbbb,1.0)  // 按钮不可点击状态
#define BtnBgColor            UIColorFromHEXA(0xFFD308,1.0)  // 按钮可点击状态
#define DefaultTitleColor     UIColorFromHEXA(0x343434,1.0)  // 字体颜色
#define DefaultBackgroudColor UIColorFromHEXA(0xf9f6f6,1.0)  // 视图里面的背景颜色
#define DefaultLineColor      UIColorFromHEXA(0x000000,0.5)  // 边框线的颜色
// 填充颜色,获取的是父视图Table背景颜色
#define KJTableFillColor [UIColor groupTableViewBackgroundColor]


#pragma mark *******    图片资源相关   *********
#define GetImage(imageName)   [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
#define DefaultHeaderImage    GetImage(@"me_no_header")     // 头像占位图
#define DefaultCoverImage     GetImage(@"me_no_cover")      // 封面占位图

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
#define kAppIcon  GetImage(@"timg1")


#endif /* Macros_h */
