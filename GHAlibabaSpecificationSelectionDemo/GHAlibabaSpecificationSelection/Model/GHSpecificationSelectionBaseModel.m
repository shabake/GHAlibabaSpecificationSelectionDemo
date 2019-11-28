//
//  GHSpecificationSelectionBaseModel.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHSpecificationSelectionBaseModel.h"

@implementation GHSpecificationSelectionBaseModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}


@end
