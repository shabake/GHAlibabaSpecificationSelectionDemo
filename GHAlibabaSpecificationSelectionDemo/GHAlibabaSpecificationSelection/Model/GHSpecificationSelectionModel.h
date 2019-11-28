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

@property (nonatomic , strong) NSArray *images;

@property (nonatomic , copy) NSString *specifications;

@property (nonatomic , copy) NSString *actual_stock;

@property (nonatomic , copy) NSString *color;

@property (nonatomic , copy) NSString *unit;

@property (nonatomic , copy) NSString *count;

/**
 *  0 = 无活动 1 特价 2 满减
 */
@property (nonatomic , copy) NSString *activityType;

@property (nonatomic, copy) NSString *activity_price;

@end

NS_ASSUME_NONNULL_END
