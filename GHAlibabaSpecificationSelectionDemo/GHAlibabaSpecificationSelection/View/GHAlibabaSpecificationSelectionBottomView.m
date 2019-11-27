//
//  GHAlibabaSpecificationSelectionBottomView.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHAlibabaSpecificationSelectionBottomView.h"
#import "GHSpecificationSelectionModel.h"
#import "GHSpecificationSelectionTitleModel.h"
#import "UIButton+Extension.h"

@interface GHAlibabaSpecificationSelectionBottomView()

/**
 *  确定
 */
@property (nonatomic , strong) UIButton *sure;

@end
@implementation GHAlibabaSpecificationSelectionBottomView

- (void)changeStatusWithTitles:(NSMutableArray *)titles {
    NSInteger count = 0;
    for (NSInteger i = 0 ; i < titles.count; i ++) {
        GHSpecificationSelectionTitleModel *titleModel = titles[i ];
        for (NSInteger j = 0 ; j < titleModel.skuList.count; j++) {
            GHSpecificationSelectionModel *skuModel = titleModel.skuList[j];
            count += skuModel.count.integerValue;
        }
    }
    self.sure.enabled = count == 0 ? NO:YES;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self changeStatusWithTitles:@[].copy];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.sure];
    [self.sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@50);
    }];
}

- (void)clickSure {
    if (self.didClickSureBlock) {
        self.didClickSureBlock();
    }
}

- (UIButton *)sure {
    if (_sure == nil) {
        _sure = [[UIButton alloc]init];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
        [_sure setBackgroundColor:UIColorFromRGB(0xe5e5e5) forState:UIControlStateDisabled];
        [_sure addTarget:self action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sure;
}

@end
