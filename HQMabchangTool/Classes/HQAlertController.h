//
//  HQAlertController.h
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HQAlertControllerSelectType) {
    HQAlertControllerSelectTypeConform, // 确定
    HQAlertControllerSelectTypeCancel // 取消
};

@interface HQAlertController : NSObject

+ (void)showAlertControllerTitle:(NSString *)titleStr
                         message:(NSString *)massgate
                         conform:(NSString *)conform
                          cancel:(NSString *)cancel
           selectCancelOrConform:(void(^)(HQAlertControllerSelectType type))selectType
              showViewController:(UIViewController *)VC;

@end

NS_ASSUME_NONNULL_END
