//
//  GHPopView.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHPopView : UIView

#pragma mark - Value
/** 内容View高度 */
@property (nonatomic, assign) CGFloat contentViewHeight;

#pragma mark - Event
/** 显示完成Block */
@property (nonatomic, copy) void (^showFinish)(CGRect frame);
/** 消失完成Block */
@property (nonatomic, copy) void (^dimissFinish)(void);

/** 显示 */
- (void)show;
/** 消失 */

- (void)dismiss;
- (void)addView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
