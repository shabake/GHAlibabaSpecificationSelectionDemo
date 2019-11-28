//
//  NSString+Extension.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "NSString+Extension.h"


@implementation NSString (Extension)

+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    CGSize expectedLabelSize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [paragraphStyle setLineSpacing:0];
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    paragraphStyle.alignment = NSTextAlignmentJustified;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    expectedLabelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

@end
