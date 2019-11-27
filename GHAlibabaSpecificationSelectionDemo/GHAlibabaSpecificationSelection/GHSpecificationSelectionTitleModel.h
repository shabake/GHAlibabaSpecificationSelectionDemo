//
//  GHSpecificationSelectionTitleModel.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHSpecificationSelectionTitleModel : NSObject

/**
 *  颜色
 */
@property (nonatomic ,copy) NSString *color;

/**
 *  XFSGoodDetailsSkuModel集合
 */
@property (nonatomic ,strong) NSArray *skuList;

/**
 *  当前颜色规格够买数量
 */
@property (nonatomic ,copy) NSString *count;

@end

NS_ASSUME_NONNULL_END
