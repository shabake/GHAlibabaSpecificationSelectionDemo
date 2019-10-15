//
//  GHTableView.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHTableView.h"

@implementation GHTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self == [super initWithFrame:frame style:style]) {
        if (@available(iOS 11.0, *)) {
                 self.estimatedRowHeight = 0;
                 self.estimatedSectionHeaderHeight = 0;
                 self.estimatedSectionFooterHeight = 0;
             }
    }
    return self;
}

@end
