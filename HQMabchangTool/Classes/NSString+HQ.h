//
//  NSString+HQ.h
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HQ)
/**
 把字符串之类的转换成字典

 @return 返回
 */
- (id)GFJSONValue;


/**
 转换成string
 
 @return 返回
 */
- (NSString *)GFJSONString;

/**
 *  int 转换成string
 */
NSString *SJStringWithFormat(NSInteger index);



/**
 *  拼接两个字符串
 *
 *  @param keyStr   前边
 *  @param keyValue 后边
 */
NSString *SJStringWithPickFormat(NSString *keyStr, NSString *keyValue);
//计算宽度
- (CGSize)zr_calculateSize:(CGSize)size font:(UIFont *)font;


/// 判断是否是数字
/// @param number 输入的内容
+ (BOOL)isNumber:(NSString *)number;


/// 计算缓存大小
+(NSString *)getCachesSize;

// 清除缓存
+ (void)removeCache;

/// 计算数量缩写
- (NSString *)calculateNumber;


// 字体格式调整
+ (NSMutableAttributedString *)asString:(NSString *)string;

#pragma mark - 时间转化
+ (NSString *)timeIntervalToMMSSFormat:(NSTimeInterval)interval;
@end

NS_ASSUME_NONNULL_END
