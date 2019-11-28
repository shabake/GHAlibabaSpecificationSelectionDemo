//
//  UIImage+ViewToImage.h
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 macBookPro. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ViewToImage)

+ (UIImage *)imageWithFrame:(CGRect)frame backGroundColor:(UIColor *)backGroundColor text:(NSString *)text textColor:(UIColor *)textColor textFontOfSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
