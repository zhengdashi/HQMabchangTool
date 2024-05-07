//
//  HQSpeedy.m
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/7.
//

#import "HQSpeedy.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSObject+HQ.h"

@implementation HQSpeedy
+ (UIEdgeInsets)tz_safeAreaInsets {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (![window isKeyWindow]) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (CGRectEqualToRect(keyWindow.bounds, [UIScreen mainScreen].bounds)) {
            window = keyWindow;
        }
    }
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets insets = [window safeAreaInsets];
        return insets;
    }
    return UIEdgeInsetsZero;
}

+ (CGFloat)tz_statusBarHeight {
    if ([UIWindow instancesRespondToSelector:@selector(safeAreaInsets)]) {
        return [self tz_safeAreaInsets].top;
    }
    return 20;
}
+ (CGFloat)tz_statusBottomHeight {
    if ([UIWindow instancesRespondToSelector:@selector(safeAreaInsets)]) {
        return [self tz_safeAreaInsets].bottom;
    }
    return 0;
}
+ (CGFloat)tz_bottomVCArrHeight {
    NSArray *viewControllers = [NSObject getCurrentVC].navigationController.viewControllers;
    if (viewControllers.count == 1) {
        return 49;
    } else {
        return 0;
    }
    
}


/// 顶部安全区高度
+ (CGFloat)ss_safeDistanceTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}

/// 底部安全区高度
+ (CGFloat)ss_safeDistanceBottom {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}


/// 顶部状态栏高度（包括安全区）
+ (CGFloat)ss_statusBarHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}
/// 顶部间距 (不包括状态栏)
+ (CGFloat)ss_safeAreaTopInterval {
    return [self ss_statusBarHeight] - 20;
}

/// 导航栏高度
+ (CGFloat)ss_navigationBarHeight {
    return 44.0f;
}

/// 状态栏+导航栏的高度
+ (CGFloat)ss_navigationFullHeight {
    return [self ss_statusBarHeight] + [self ss_navigationBarHeight];
}

/// 底部导航栏高度
+ (CGFloat)ss_tabBarHeight {
    return 49.0f;
}

/// 底部导航栏高度（包括安全区）
+ (CGFloat)ss_tabBarFullHeight {
    return [self ss_tabBarHeight] + [self ss_safeDistanceBottom];
}


#pragma mark - 切圆角
+ (void)setPartRoundWithView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    view.layer.mask = shapeLayer;
}
@end
