//
//  GHTextField.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GHTextFieldChangeBlock)(NSInteger count);


typedef NS_ENUM (NSUInteger, GHCountFieldChangeType) {
    GHCountFieldChangeTypeAdd = 1,
    GHCountFieldChangeTypeSub,
    GHCountFieldChangeTypeNone,
};

typedef NS_ENUM (NSUInteger, GHCountFieldMiniOrderType) {
    GHCountFieldMiniOrderTypeMultiple = 1,
    GHCountFieldMiniOrderTypeStep
};


@interface GHTextField : UITextField


/**
 最大值
 */
@property (nonatomic , assign) NSInteger maxCount;

/**
 最小值
 */
@property (nonatomic , assign) NSInteger minCount;

/**
 当前值
 */
@property (nonatomic , assign) NSInteger count;

/**
 按钮类型 +/-/无
 */
@property (nonatomic , assign) GHCountFieldChangeType changeType;

/**
 起订量类型（非必设置属性，与miniOrder属性配合使用）
 */
@property (nonatomic, assign) GHCountFieldMiniOrderType miniOrderType;

/**
 最小起订数量(不设置则为普通步进增加，及1、2、3、4)
 */
@property (nonatomic , assign) NSInteger miniOrder;


/**
 CountDidChangeBlock
 */
@property (nonatomic , copy) GHTextFieldChangeBlock countDidChangeBlock;

/**
 是否显示边框
 */
@property (nonatomic, assign) BOOL showBorderLine;

@end

NS_ASSUME_NONNULL_END
