//
//  XFHudHelper.m
//  
//
//  Created by zhengchen2 on 15/3/4.
//  Copyright (c) 2014年 zhengchen2. All rights reserved.
//

#import "CDZHudHelper.h"
#import "MBProgressHUD.h"

static const char CDZLoadingHudKey;
@implementation UIViewController (CDZHudController)

// showTime <= 0 时，不显示
- (void)showTextHud:(NSString*)message{  // 默认显示 2 秒
    [self.view showTextHud:message];
}
- (void)showTextHud:(NSString*)message showTime:(NSTimeInterval)showTime{
    [self.view showTextHud:message showTime:showTime];
}
- (void)showTextHudWithTitle:(NSString*)title message:(NSString*)message showTime:(NSTimeInterval)showTime yOffset:(CGFloat)yOffset{
    [self.view showTextHudWithTitle:title message:message showTime:showTime yOffset:yOffset];
}

// 一个view，只会显示一个 LoadingHud
- (void)showLoadingHud:(NSString*)message{
    [self.view showLoadingHud:message];
}
- (void)showLoadingHudWithTitle:(NSString*)title message:(NSString*)message yOffset:(CGFloat)yOffset modal:(BOOL)modal{
    [self.view showLoadingHudWithTitle:title message:message yOffset:yOffset modal:modal];
}
- (void)hideLoadingHud{
    [self.view hideLoadingHud];
}

@end


@implementation UIView (CDZHudView)

// showTime <= 0 时，不显示
- (void)showTextHud:(NSString*)message{  // 默认显示 2 秒
    [self showTextHudWithTitle:nil message:message showTime:CDZHudDefaultShowTime yOffset:-22];
}
- (void)showTextHud:(NSString*)message showTime:(NSTimeInterval)showTime{
    [self showTextHudWithTitle:nil message:message showTime:showTime yOffset:-22];
}
- (void)showTextHudWithTitle:(NSString*)title message:(NSString*)message showTime:(NSTimeInterval)showTime yOffset:(CGFloat)yOffset{
    if(showTime <= 0){
        return;
    }
    
    MBProgressHUD* hud = [[MBProgressHUD alloc]init];
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    
    hud.labelText = title;
    hud.detailsLabelText = message;
    hud.yOffset = yOffset;
    hud.mode = MBProgressHUDModeText;
    
    [self addSubview:hud];
    [hud show:YES];
    
    [hud hide:YES afterDelay:showTime];
    
    
    
    // 无障碍阅读
    NSString* accessibilityString = nil;
    if (title && message == nil) {
        accessibilityString = title;
    }
    else if(title == nil && message){
        accessibilityString = message;
    }
    else if(title && message) {
        accessibilityString = [[NSString alloc]initWithFormat:@"%@\n%@", title, message, nil];
    }
    if (accessibilityString) {
        // 显示hud，通常是在界面发生变化的时候
        // 发出Notification后，正好界面变化导致voiceOver会中断此次Notification播报
        // 等0.1秒，让界面变化先播报，再发出Notification播放，就不会被打断了
        GCDAsyncInMainAfter(0.1, ^{
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, accessibilityString);
        });
    }
}

// 一个view，只会显示一个 LoadingHud
- (void)showLoadingHud:(NSString*)message{
    [self showLoadingHudWithTitle:nil message:message yOffset:-22 modal:NO];
}
- (void)showLoadingHudWithTitle:(NSString*)title message:(NSString*)message yOffset:(CGFloat)yOffset modal:(BOOL)modal{
    MBProgressHUD* loadingHud =  objc_getAssociatedObject(self, &CDZLoadingHudKey);
    if (loadingHud == nil) {
        loadingHud = [[MBProgressHUD alloc]init];
        loadingHud.removeFromSuperViewOnHide = YES;
        objc_setAssociatedObject(self, &CDZLoadingHudKey, loadingHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    loadingHud.labelText = title;
    loadingHud.detailsLabelText = message;
    loadingHud.yOffset = yOffset;
    loadingHud.mode = MBProgressHUDModeIndeterminate;
    loadingHud.userInteractionEnabled = modal;
    
    [self addSubview:loadingHud];
    [loadingHud show:YES];
}
- (void)hideLoadingHud{
    MBProgressHUD* loadingHud =  objc_getAssociatedObject(self, &CDZLoadingHudKey);
    if (loadingHud) {
        [loadingHud hide:YES];
    }
}

@end


//  contact 303730915@qq.com



