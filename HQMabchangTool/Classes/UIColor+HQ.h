//
//  UIColor+HQ.h
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HQ)
/**
 传入颜色的hex值

 @param hex 值
 @return 得到透明度是1的颜色
 */
+ (UIColor *)colorHex:(UInt32)hex;


+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
