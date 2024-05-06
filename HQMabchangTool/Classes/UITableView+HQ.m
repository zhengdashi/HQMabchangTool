//
//  UITableView+HQ.m
//  HQMabchangTool
//
//  Created by 郑浩然 on 2024/5/6.
//

#import "UITableView+HQ.h"

@implementation UITableView (HQ)
//注册nib cell
- (void)registerCellWithNIbNames:(NSArray *)nibNames {
    for (NSString *nibName in nibNames) {
        [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
    }
}
@end
