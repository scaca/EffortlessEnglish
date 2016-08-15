//
//  UtilsMacro.h
//  各种工具类宏定义
//
//  Created by wangyuehong on 15/9/5.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#ifndef Imora_UtilsMacro_h
#define Imora_UtilsMacro_h

/******************************** 设备相关 ********************************/
#pragma mark - 设备相关

//屏幕的宽度,支持旋转屏幕
#define kScreen_Width                                                                                   \
    ((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1)                            \
         ? (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) \
                ? [UIScreen mainScreen].bounds.size.height                                              \
                : [UIScreen mainScreen].bounds.size.width)                                              \
         : [UIScreen mainScreen].bounds.size.width)

//屏幕的高度,支持旋转屏幕
#define kScreen_Height                                                                                  \
    ((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1)                            \
         ? (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) \
                ? [UIScreen mainScreen].bounds.size.width                                               \
                : [UIScreen mainScreen].bounds.size.height)                                             \
         : [UIScreen mainScreen].bounds.size.height)

//当前设备是iPhone
#define kDevice_is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//当前设备是iPad
#define kDevice_is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// iOS系统版本
#define kiOS_Version [[[UIDevice currentDevice] systemVersion] floatValue]
// iOS 9
#define kiOSVersion_9X (kiOS_Version >= 9.0f)
// iOS 8
#define kiOSVersion_8X (kiOS_Version >= 8.0f && kiOS_Version < 9.0f)
// iOS 7
#define kiOSVersion_7X (kiOS_Version >= 7.0f && kiOS_Version < 8.0f)

// iPhone4/4S
#define kDevice_is_iPhone4 ([[UIScreen mainScreen] bounds].size.height == 480)
// iPhone5/5C/5S
#define kDevice_is_iPhone5 ([[UIScreen mainScreen] bounds].size.height == 568)
// iPhone6
#define kDevice_is_iPhone6 ([[UIScreen mainScreen] bounds].size.height == 667)
// iPhone6 Plus
#define kDevice_is_iPhone6P ([[UIScreen mainScreen] bounds].size.height == 736)

/******************************** 单例 ********************************/
#pragma mark - 单例

// @interface
#define kSingleton_Interface(className) +(className *)defaultInstance;

// @implementation
#define kSingleton_Implementation(className)                \
    static className *_instance;                            \
    static dispatch_once_t onceToken;                       \
    +(instancetype)allocWithZone : (struct _NSZone *)zone { \
        dispatch_once(&onceToken, ^{                        \
          _instance = [super allocWithZone:zone];           \
        });                                                 \
        return _instance;                                   \
    }                                                       \
    +(instancetype)defaultInstance {                        \
        static dispatch_once_t onceToken;                   \
        dispatch_once(&onceToken, ^{                        \
          _instance = [[self alloc] init];                  \
        });                                                 \
        return _instance;                                   \
    }

/******************************** 国际化 ********************************/
#pragma mark - 国际化

#define tr(key) NSLocalizedStringFromTable(key, @"Localization", nil)

//当前语言
#define kSystem_Language ([[NSLocale preferredLanguages] objectAtIndex:0])

/******************************** 颜色相关 ********************************/
#pragma mark - 颜色相关

#define kColor(name) [UIColor ora_colorWithNamed:name]

#define kRGB_Color(r, g, b) [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1.f]

#define kRGBA_Color(r, g, b, a) [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a]

/******************************** 目录相关 ********************************/
#pragma mark - 目录相关

// Document目录
#define kDocumentsDirectory \
    ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0])

// Document子目录
#define kDocumentsSubDirectory(dir) ([kDocumentsDirectory stringByAppendingPathComponent:dir])

// Library目录
#define kLibraryDirectory \
    ([NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0])

// Library子目录
#define kLibrarySubDirectory(dir) ([kLibraryDirectory stringByAppendingPathComponent:dir])

// Cache目录
#define kCacheDirectory \
    ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0])

// Cache子目录
#define kCacheSubDirectory(dir) ([kCacheDirectory stringByAppendingPathComponent:dir])

// Temp目录
#define kTempDirectory (NSTemporaryDirectory())

// Temp子目录
#define kTempSubDirectory(dir) ([NSTemporaryDirectory() stringByAppendingPathComponent:dir])

/******************************** 图片相关 ********************************/
#pragma mark - 图片相关

//获取UIImage
#define kImage(name) [UIImage imageNamed:name]

//获取应用目录下的PNG图片
#define kImageWithName_PNG(name) \
    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]]

//获取应用目录下的JPG图片
#define kImageWithName_JPG(name) \
    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"jpg"]]

#endif
