//
//  HQAlertController.m
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import "HQAlertController.h"

@implementation HQAlertController
+ (void)showAlertControllerTitle:(NSString *)titleStr
                         message:(NSString *)massgate
                         conform:(NSString *)conform
                          cancel:(NSString *)cancel
           selectCancelOrConform:(void(^)(HQAlertControllerSelectType type))selectType
              showViewController:(UIViewController *)VC
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleStr message:massgate preferredStyle:UIAlertControllerStyleAlert];
    
    //2.添加按钮动作
    //2.1 确认按钮
    UIAlertAction *conform1 = [UIAlertAction actionWithTitle:conform style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (selectType) {
            selectType(HQAlertControllerSelectTypeConform);
        }
    }];
    //2.2 取消按钮
    UIAlertAction *cancel1 = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (selectType) {
            selectType(HQAlertControllerSelectTypeCancel);
        }
    }];
    
    //3.将动作按钮 添加到控制器中
    if (cancel.length > 0) {
        [alert addAction:cancel1];
    }
    if (conform.length > 0) {
        [alert addAction:conform1];
    }
        
        //4.显示弹框
    [VC presentViewController:alert animated:YES completion:nil];
    
    
}
@end
