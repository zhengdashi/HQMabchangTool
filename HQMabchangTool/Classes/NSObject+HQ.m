//
//  NSObject+HQ.m
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import "NSObject+HQ.h"

@implementation NSObject (HQ)
//延迟执行
+ (void)executeRunloop:(void (^)(void))runloop afterDelay:(float)delay {
    double delayInSeconds = delay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (runloop) {
            runloop();
        }
    });
}

+ (id)bundleLoadNibNamed:(NSString *)nibName {
    return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
}
//保存数据
void SaveDataToNSUserDefaults(id data, NSString *key){
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//得到数据
id GetDataFromNSUserDefaults(NSString *key) {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}
//删除所在的key的数据
void DeleteDataFromNSUserDefaults(NSString * key) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//根据xib名字查找类
id GFBundleNibName(NSString *nibName) {
    return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
}

+ (void)showImageLookArr:(NSMutableArray *)imageArr index:(NSInteger)index {
//    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
//    browser.isFullWidthForLandScape = YES;
//    browser.isNeedLandscape = NO;
//    browser.currentImageIndex = index;
//    browser.imageArray = imageArr;
//
//    [browser show];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIWindow *window = [self getKeyWindow];
    UIViewController *rootViewController = window.rootViewController;

    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];

    return currentVC;
}
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;

    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的

        rootVC = [rootVC presentedViewController];
    }

    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController

        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];

    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController

        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];

    }
    else {
        // 根视图为非导航类

        currentVC = rootVC;
    }

    return currentVC;
}
- (UIWindow *)getKeyWindow
{   if (@available(iOS 13.0, *)) {
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {if (windowScene.activationState == UISceneActivationStateForegroundActive) {
        for (UIWindow *window in windowScene.windows) {
            if (window.isKeyWindow){
                return window;
            }
          }
        }
      }
    }
    return nil;
}
@end
