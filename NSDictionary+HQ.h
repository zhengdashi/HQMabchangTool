//
//  NSDictionary+HQ.h
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (HQ)
- (id)nilObjectForKey:(NSString *)key;

/// json字符串转字典
/// @param jsonString json字符串
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// NSJSONReadingMutableLeaveserror
+ (NSDictionary *)dictionaryLeaveserrorString:(NSString *)jsonString;



// 字典转json字符串方法

-(NSString *)convertToJsonData:(id)jsonDa;
@end

NS_ASSUME_NONNULL_END
