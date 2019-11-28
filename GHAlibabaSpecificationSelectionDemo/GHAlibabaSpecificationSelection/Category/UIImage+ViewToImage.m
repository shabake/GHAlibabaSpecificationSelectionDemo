//
//  UIImage+ViewToImage.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "UIImage+ViewToImage.h"

@implementation UIImage (ViewToImage)

+ (UIImage *)imageWithFrame:(CGRect)frame backGroundColor:(UIColor *)backGroundColor text:(NSString *)text textColor:(UIColor *)textColor textFontOfSize:(CGFloat)size {
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 5;
    backView.backgroundColor = backGroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.backgroundColor = backGroundColor;
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:size];
    [backView addSubview:label];
    UIGraphicsBeginImageContextWithOptions(backView.bounds.size,NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [backView.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

@end
