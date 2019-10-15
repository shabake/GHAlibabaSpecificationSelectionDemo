//
//  GHScrollView.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^GHScrollViewGetCurrentPageBlock)(NSInteger currentPage,UIView *view);

@protocol GHScrollViewScrollViewDelegate
// 需要delegate在view中填充第toPage的数据；如果传入的view为nil，需要delegate创建view
- (nonnull UITableView *)setupView:(nullable UITableView *)view toPage:(NSUInteger)toPage;
- (NSUInteger)numOfPages;

@end

@interface GHScrollView : UIScrollView

@property (nonatomic,assign, nonnull) id<GHScrollViewScrollViewDelegate> delegateForReuseableScrollView;
// 完成bufferViews的初始化，并放入containerView，再把containerView放入scrollView
- (void)setupViews;

@property (nonatomic , copy) GHScrollViewGetCurrentPageBlock getCurrentPageBlock;

@end

NS_ASSUME_NONNULL_END
