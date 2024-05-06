//
//  NSDictionary+HQ.m
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import "NSDictionary+HQ.h"

@implementation NSDictionary (HQ)

- (id)nilObjectForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    
    if([obj isEqual:[NSNull null]])
    {
        return @"";
    }
    else
    {
        return obj;
    }
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSDictionary *)dictionaryLeaveserrorString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }

    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    NSString *str = nil;
    // 是否能变成ISO-8859-1这种编码的数据
        if ([jsonString canBeConvertedToEncoding:kCFStringEncodingISOLatin1]) {
            // 将ISO-8859-1的字符转成uft8
            str = [NSString stringWithUTF8String:[jsonString cStringUsingEncoding:enc]];
        }else{
            str = jsonString;
        }
    
    
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


// 字典转json字符串方法

-(NSString *)convertToJsonData:(id)jsonDa

{

    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDa options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        NSLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}
@end
