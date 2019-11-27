//
//  GHSpecificationSelectionModel.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHSpecificationSelectionModel : NSObject

@property (nonatomic , copy) NSString *sku_id;

@property (nonatomic , copy) NSString *arrival_cycle;

@property (nonatomic , copy) NSString *sku_code;

@property (nonatomic , copy) NSString *order_limit_type;

@property (nonatomic , copy) NSString *sku_name;

@property (nonatomic , copy) NSString *mini_order;

@property (nonatomic , copy) NSString *virtual_stock;

@property (nonatomic , copy) NSString *sale_price;

@property (nonatomic , copy) NSString *isActivityBegin;

@property (nonatomic , strong) NSArray *images;

@property (nonatomic , copy) NSString *specifications;

@property (nonatomic , copy) NSString *actual_stock;


@property (nonatomic , copy) NSString *onActivitySku;

@property (nonatomic , copy) NSString *spu_code;

@property (nonatomic , copy) NSString *color;
@property (nonatomic , copy) NSString *unit;

@property (nonatomic , copy) NSString *activityPlatform;
@property (nonatomic , copy) NSString *count;
@property (nonatomic , copy) NSString *activityType;
/**
 * 是否被选择
 */
@property (nonatomic, assign) BOOL seleted;

/**
 * sku序号
 */
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *activity_price;

/**
 * 是否有活动 isHaveActivity = 1 有 ; isHaveActivity = 2 无
*/
@property (nonatomic, copy) NSString *isHaveActivity;
@end

NS_ASSUME_NONNULL_END
