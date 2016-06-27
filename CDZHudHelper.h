//
//  XFHudHelper.h
//  
//
//  Created by zhengchen2 on 15/3/4.
//  Copyright (c) 2014年 zhengchen2. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CDZHudDefaultShowTime 2


@interface UIViewController (CDZHudController)

// showTime <= 0 时，不显示
- (void)showTextHud:(NSString*)message;  // 默认显示 2 秒
- (void)showTextHud:(NSString*)message showTime:(NSTimeInterval)showTime;
- (void)showTextHudWithTitle:(NSString*)title message:(NSString*)message showTime:(NSTimeInterval)showTime yOffset:(CGFloat)yOffset;

// 一个view，只会显示一个 LoadingHud
- (void)showLoadingHud:(NSString*)message;
- (void)showLoadingHudWithTitle:(NSString*)title message:(NSString*)message yOffset:(CGFloat)yOffset modal:(BOOL)modal;
- (void)hideLoadingHud;

@end


@interface UIView (CDZHudView)

// showTime <= 0 时，不显示
- (void)showTextHud:(NSString*)message;  // 默认显示 2 秒
- (void)showTextHud:(NSString*)message showTime:(NSTimeInterval)showTime;
- (void)showTextHudWithTitle:(NSString*)title message:(NSString*)message showTime:(NSTimeInterval)showTime yOffset:(CGFloat)yOffset;

// 一个view，只会显示一个 LoadingHud，modal默认为NO
- (void)showLoadingHud:(NSString*)message;
// modal为YES时，表示在 loadingHud显示期间，不允许点击view上的交互元素。
- (void)showLoadingHudWithTitle:(NSString*)title message:(NSString*)message yOffset:(CGFloat)yOffset modal:(BOOL)modal;
- (void)hideLoadingHud;

@end


#define showLoadingHud(text) [self showLoadingHud:(text)]
#define showLoadingModalHud(text) [self showLoadingHudWithTitle:nil message:(text) yOffset:-22 modal:YES]
#define showLoadingHudInWindow(text) [[UIApplication sharedApplication].keyWindow showLoadingHud:(text)]
#define hideHud() [self hideLoadingHud]

#define showTextHud(text) [self showTextHud:(text)]
#define showTextHudInWindow(text) [[UIApplication sharedApplication].keyWindow showTextHud:(text)]




//  contact 303730915@qq.com



