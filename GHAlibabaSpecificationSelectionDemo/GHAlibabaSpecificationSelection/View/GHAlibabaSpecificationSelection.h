//
//  GHAlibabaSpecificationSelection.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHPopView.h"

NS_ASSUME_NONNULL_BEGIN


@interface GHAlibabaSpecificationSelection : GHPopView

@property (nonatomic , strong) NSArray *dataArray;


/**
 * 数据源
 * @param skuList 装skuModel数组
 * @param colors 颜色数组
 * @param sectePrice 价格区间字典
 */
- (void)setSkuList:(NSArray *)skuList colors:(NSArray *)colors sectePrice:(NSDictionary *)sectePrice;

@end

NS_ASSUME_NONNULL_END
