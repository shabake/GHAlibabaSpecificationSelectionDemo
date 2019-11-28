//
//  GHAlibabaSpecificationSelectionBottomView.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GHAlibabaSpecificationSelectionBottomViewDidClickSureBlock)(void);

@interface GHAlibabaSpecificationSelectionBottomView : UIView

@property (nonatomic , copy) GHAlibabaSpecificationSelectionBottomViewDidClickSureBlock didClickSureBlock;

/**
 *   根据数据来决定确定按钮的状态
 */
- (void)changeStatusWithTitles:(NSMutableArray *)titles;

@end

NS_ASSUME_NONNULL_END
