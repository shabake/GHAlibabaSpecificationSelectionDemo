//
//  GHSpecificationSelectionModel.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHSpecificationSelectionModel.h"

@implementation GHSpecificationSelectionModel

/// 是否有活动
- (NSString *)isHaveActivity {
    NSString *isHaveActivity = @"2";
    if ([self.activityPlatform isEqualToString:@"30"] ||
        [self.activityPlatform isEqualToString:@"10"]) {
        if ([self.isActivityBegin isEqualToString:@"0"] ||[self.isActivityBegin isEqualToString:@"-1"]) {
            isHaveActivity = @"1";
        } else {
            isHaveActivity = @"2";
        }
    } else {
        isHaveActivity = @"2";
    }
    return isHaveActivity;
}

@end
