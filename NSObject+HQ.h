//
//  NSObject+HQ.h
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HQ)
/**
 *  延迟时间执行
 */
+ (void)executeRunloop:(void(^)(void))runloop afterDelay:(float)delay;


+ (id)bundleLoadNibNamed:(NSString *)nibName;

//保存数据
void SaveDataToNSUserDefaults(id data, NSString *key);
//得到数据
id GetDataFromNSUserDefaults(NSString *key);
//删除所在的key的数据
void DeleteDataFromNSUserDefaults(NSString * key);

/// 根据xib名字查找类
/// @param nibName ib名字
id GFBundleNibName(NSString *nibName);


/// 得到当前vc
- (UIViewController *)getCurrentVC;

/// 获取window
- (UIWindow *)getKeyWindow;
@end

NS_ASSUME_NONNULL_END
