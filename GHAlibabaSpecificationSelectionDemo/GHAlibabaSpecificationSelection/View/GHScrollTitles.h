//
//  GHScrollTitles.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHScrollTitles : UIView

typedef void (^GHScrollTitlesDidClickTitleBlock)(NSInteger tag);
typedef void (^GHScrollTitlesDidClickLeftBlock)(void);
typedef void (^GHScrollTitlesDidClickRightBlock)(void);

@property (nonatomic , strong) NSMutableArray *titles;

@property (nonatomic , copy) GHScrollTitlesDidClickTitleBlock didClickTitleBlock;

@property (nonatomic , copy) GHScrollTitlesDidClickLeftBlock didClickLeftBlock;

@property (nonatomic , copy) GHScrollTitlesDidClickRightBlock didClickRightBlock;

/** 菜单按钮移动位置 */
- (void)setMenusScrollView:(CGPoint)contentOffset;
/** 滑动停止的时候 */
- (void)setMenusScrollViewEnd:(CGPoint)endOffset;

/**
 *  刷新数据
 */
- (void)reloadData;

/**
 *  重置所有数据(去掉红点,index = 0,数据清空)
 */
- (void)resetData;

@end

NS_ASSUME_NONNULL_END
