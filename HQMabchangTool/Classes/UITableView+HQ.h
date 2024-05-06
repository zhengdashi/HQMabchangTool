//
//  UITableView+HQ.h
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HQ)
/**
 注册cell  nib
 
 @param nibNames nibcell
 */
- (void)registerCellWithNIbNames:(NSArray *)nibNames;
@end

NS_ASSUME_NONNULL_END
