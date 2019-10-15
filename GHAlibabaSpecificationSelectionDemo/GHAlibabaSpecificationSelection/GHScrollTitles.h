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

@property (nonatomic , strong) NSMutableArray *titles;

@property (nonatomic , copy) GHScrollTitlesDidClickTitleBlock didClickTitleBlock;


@end

NS_ASSUME_NONNULL_END
