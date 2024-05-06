//
//  NSString+HQ.m
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#import "NSString+HQ.h"

@implementation NSString (HQ)
//转换成字典
- (id)GFJSONValue {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
//转换成string
- (NSString *)GFJSONString {
    NSError* error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:kNilOptions
                                                     error:&error];
    if((error != nil) || (data == nil))
    {
        return nil;
    }
    else
    {
        NSStringEncoding coding = NSUTF8StringEncoding;
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if((responseString == nil) && (data.length > 0))
        {
            NSData *utf8Data = [self replaceNoUtf8:data];
            responseString = [[NSString alloc] initWithData:utf8Data encoding:coding];
        }
        
        return responseString;
    }
}
//替换非utf8字符
//注意：如果是三字节utf-8，第二字节错误，则先替换第一字节内容(认为此字节误码为三字节utf8的头)，然后判断剩下的两个字节是否非法；
- (NSData *)replaceNoUtf8:(NSData *)data
{
    char aa[] = {'A','A','A','A','A','A'};                      //utf8最多6个字符，当前方法未使用
    NSMutableData *md = [NSMutableData dataWithData:data];
    int loc = 0;
    while(loc < [md length])
    {
        char buffer;
        [md getBytes:&buffer range:NSMakeRange(loc, 1)];
        if((buffer & 0x80) == 0)
        {
            loc++;
            continue;
        }
        else if((buffer & 0xE0) == 0xC0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                continue;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else if((buffer & 0xF0) == 0xE0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                [md getBytes:&buffer range:NSMakeRange(loc, 1)];
                if((buffer & 0xC0) == 0x80)
                {
                    loc++;
                    continue;
                }
                loc--;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else
        {
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
    }
    
    return md;
}
//计算nsstring的尺寸，size－最大宽高约束
- (CGSize)zr_calculateSize:(CGSize)size font:(UIFont *)font {
    CGSize expectedLabelSize = CGSizeZero;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 1;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return CGSizeMake(ceil(expectedLabelSize.width) + 2, ceil(expectedLabelSize.height) + 2);
}
//将int转换成 str
NSString *SJStringWithFormat(NSInteger index) {
    return [NSString stringWithFormat:@"%ld",(long)index];
}
//拼接字符串
NSString *SJStringWithPickFormat(NSString *keyStr, NSString *keyValue) {
    return [NSString stringWithFormat:@"%@%@",keyStr,keyValue];
}

//手机号验证
+ (BOOL)isPhoneNumber:(NSString *)number
{
    NSString *phoneRegex1=@"1[23456789]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}

+ (BOOL)isNumber:(NSString *)number
{
    NSString *numberStr = @"^([1-9][0-9]*)+(/.[0-9]{1,2})?$";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberStr];
    return  [phoneTest1 evaluateWithObject:number];
}
//把多个json字符串转为一个json字符串

- (NSString *)objArrayToJSON:(NSArray *)array {

    

    NSString *jsonStr = @"[";

    

    for (NSInteger i = 0; i < array.count; ++i) {

        if (i != 0) {

            jsonStr = [jsonStr stringByAppendingString:@","];

        }

        jsonStr = [jsonStr stringByAppendingString:array[i]];

    }

    jsonStr = [jsonStr stringByAppendingString:@"]"];

    

    return jsonStr;

}
// 缓存大小
+(NSString *)getCachesSize{
    // 调试
#ifdef DEBUG
    
    // 如果文件夹不存在 or 不是一个文件夹, 那么就抛出一个异常
    // 抛出异常会导致程序闪退, 所以只在调试阶段抛出。发布阶段不要再抛了,--->影响用户体验
    
    BOOL isDirectory = NO;
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        
        NSException *exception = [NSException exceptionWithName:@"文件错误" reason:@"请检查你的文件路径!" userInfo:nil];
        
        [exception raise];
    }
    
    //发布
#else
    
#endif
    
    //1.获取“cachePath”文件夹下面的所有文件
    NSArray *subpathArray= [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSString *filePath = nil;
    long long totalSize = 0;
    
    for (NSString *subpath in subpathArray) {
        
        // 拼接每一个文件的全路径
        filePath =[cachePath stringByAppendingPathComponent:subpath];
        
        BOOL isDirectory = NO;   //是否文件夹，默认不是
        
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];   // 判断文件是否存在
        
        // 文件不存在,是文件夹,是隐藏文件都过滤
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) continue;
        
        // attributesOfItemAtPath 只可以获得文件属性，不可以获得文件夹属性，
        //这个也就是需要遍历文件夹里面每一个文件的原因
        
        long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
        
        totalSize += fileSize;
        
    }
    
    // 2.将文件夹大小转换为 M/KB/B
    NSString *totalSizeString = nil;
    
    if (totalSize > 1000 * 1000) {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fM",totalSize / 1000.0f /1000.0f];
        
    } else if (totalSize > 1000) {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000.0f ];
        
    } else {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fB",totalSize / 1.0f];
        
    }
    
    return totalSizeString;
    
}


// 清除缓存
+ (void)removeCache{
    
//    // 1.拿到cachePath路径的下一级目录的子文件夹
//    // contentsOfDirectoryAtPath:error:递归
//    // subpathsAtPath:不递归
//    [MBProgressHUD mj_showMessage:@"正在清除缓存..."];
//    NSArray *subpathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil];
//
//    // 2.如果数组为空，说明没有缓存或者用户已经清理过，此时直接return
//    if (subpathArray.count == 0) {
////        [SVProgressHUD showNOmessage:@"缓存已清理"];
//        return ;
//    }
//
//    NSError *error = nil;
//    NSString *filePath = nil;
//    BOOL flag = NO;
//
//    NSString *size = [self getCachesSize];
//
//    for (NSString *subpath in subpathArray) {
//
//        filePath = [cachePath stringByAppendingPathComponent:subpath];
//
//        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
//
//            // 删除子文件夹
//            BOOL isRemoveSuccessed = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
//
//            if (isRemoveSuccessed) { // 删除成功
//
//                flag = YES;
//            }
//        }
//
//    }
//
//    if (NO == flag) {
//        [MBProgressHUD mj_hideHUD];
//        [MBProgressHUD zr_showError:@"缓存已清理"];// [SVProgressHUD showNOmessage:@"缓存已清理"];
//    }
//    else {
//        [MBProgressHUD mj_hideHUD];
//        [MBProgressHUD zr_showError:[NSString stringWithFormat:@"为您腾出%@空间",size]];//[SVProgressHUD showYESmessage:[NSString stringWithFormat:@"为您腾出%@空间",size]];
//    }
//    return ;
    
}
- (NSString *)calculateNumber {
    NSInteger number = [self integerValue];
    
    CGFloat m_number = number*0.000001;
    NSString *calculate = nil;
    if (m_number > 100) {
        calculate = [NSString stringWithFormat:@"%.0f M",m_number];
    } else {
        calculate = [NSString stringWithFormat:@"%.1f M",m_number];
    }
    
    return calculate;
}

// 字体格式调整
+ (NSMutableAttributedString *)asString:(NSString *)string {
    //格式调整
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    /**调行间距*/
    style.lineSpacing = 4;
//    style.lineHeightMultiple = 22;
    style.alignment = NSTextAlignmentLeft;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
    return attStr;
}

#pragma mark - 时间转化
+ (NSString *)timeIntervalToMMSSFormat:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

@end
