//
//  NSString+Extension.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize;
@end

NS_ASSUME_NONNULL_END
