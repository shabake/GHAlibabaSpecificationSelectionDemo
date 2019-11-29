//
//  UIButton+Extension.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 macBookPro. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extension)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


#pragma mark - Runtime解决UIButton重复点击问题

/**

 *  点击事件的事件间隔
 */
@property (nonatomic, assign) NSTimeInterval acceptEventInterval;
@end

NS_ASSUME_NONNULL_END
