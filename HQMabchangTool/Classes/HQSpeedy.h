//
//  HQSpeedy.h
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQSpeedy : NSObject

/**
 * 安全域
 * 针对iphone X 系列
 * CGFloat toolBarHeight = 44 + [FCSpeedy tz_safeAreaInsets].bottom
 * */
+ (UIEdgeInsets)tz_safeAreaInsets;
/**
 * 导航栏高度
 */
+ (CGFloat)tz_statusBarHeight;

+ (CGFloat)tz_statusBottomHeight;

+ (CGFloat)tz_bottomVCArrHeight;


/// 顶部安全区高度
+ (CGFloat)ss_safeDistanceTop;
/// 底部安全区高度
+ (CGFloat)ss_safeDistanceBottom;

/// 顶部状态栏高度（包括安全区）
+ (CGFloat)ss_statusBarHeight;
/// 顶部间距 (不包括状态栏)
+ (CGFloat)ss_safeAreaTopInterval;
/// 导航栏高度
+ (CGFloat)ss_navigationBarHeight;

/// 状态栏+导航栏的高度
+ (CGFloat)ss_navigationFullHeight;
/// 底部导航栏高度
+ (CGFloat)ss_tabBarHeight;
/// 底部导航栏高度（包括安全区）
+ (CGFloat)ss_tabBarFullHeight;

/**
 切部分圆角
 
 UIRectCorner有五种
 UIRectCornerTopLeft //上左
 UIRectCornerTopRight //上右
 UIRectCornerBottomLeft // 下左
 UIRectCornerBottomRight // 下右
 UIRectCornerAllCorners // 全部
 
 @param cornerRadius 圆角半径
 */
+ (void)setPartRoundWithView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius;
@end

NS_ASSUME_NONNULL_END
