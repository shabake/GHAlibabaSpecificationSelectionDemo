//
//  GHAlibabaSpecificationSelection.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHAlibabaSpecificationSelection.h"
#import "GHScrollTitles.h"
#import "GHTableView.h"
#import "GHAlibabaSpecificationSelectionModel.h"
#import "GHSpecificationSelectionModel.h"
#import "UIImageView+WebCache.h"
#import "GHSpecificationSelectionImageModel.h"
#import "GHSpecificationSelectionTitleModel.h"
#import "GHTextField.h"
#import "NSString+Extension.h"
#import "GHAlibabaSpecificationSelectionBottomView.h"

typedef void (^GHSpecificationSelectionCellCountBlock)(GHSpecificationSelectionModel *skuModel);

@interface GHSpecificationSelectionCell : UITableViewCell<UITextFieldDelegate>

+ (CGFloat)getCellHeightWithSkuModel:(GHSpecificationSelectionModel *)skuModel;

@property (nonatomic , strong) GHSpecificationSelectionModel *skuModel;

/**
 *  skuName
 */
@property (nonatomic , strong) UILabel *skuName;

/**
 *  skuCode
 */
@property (nonatomic , strong) UILabel *skuCode;

/**
 *  价格
 */
@property (nonatomic , strong) UILabel *price;

/**
 *  预计出货日
 */
@property (nonatomic , strong) UILabel *estimatedDate;

/**
 *  计数控件
 */
@property (nonatomic , strong) GHTextField *countField;

/**
 库存不足
 */
@property (nonatomic , strong) UILabel *inventory;

@property (nonatomic , strong) UIView *line;

@property (nonatomic , copy) GHSpecificationSelectionCellCountBlock countBlock;

@end

@implementation GHSpecificationSelectionCell

- (void)setSkuModel:(GHSpecificationSelectionModel *)skuModel {
    _skuModel = skuModel;
    NSMutableArray *iconTypes = [NSMutableArray array];
    //    if ([skuModel.isHaveActivity isEqualToString:@"1"]) {
    //        XFSIconType iconType = 0;
    //        if ([skuModel.activityType isEqualToString: @"10"]) {
    //            iconType = XFSIconTypeSpecialPrice;
    //            self.price.attributedText = [self getActivityPrice];
    //        } else if ([skuModel.activityType isEqualToString:@"20"]) {
    //            iconType = XFSIconTypeFullReduction;
    //            self.price.text = [NSString stringWithFormat:@"￥%@",skuModel.sale_price];
    //        }
    //        [iconTypes addObject:@(iconType)];
    //    } else {
    //        iconTypes = nil;
    self.price.text = [NSString stringWithFormat:@"￥%@",skuModel.sale_price];
    //    }
    self.skuName.text = [NSString stringWithFormat:@"%@%@%@", ValidStr(skuModel.color)? skuModel.color:@"", ValidStr(skuModel.color) ? @"/":@"", ValidStr(skuModel.specifications) ? skuModel.specifications :@""];
    //    [self.skuName setTitleString: [NSString stringWithFormat:@"%@%@%@", ValidStr(skuModel.color)? skuModel.color:@"", ValidStr(skuModel.color) ? @"/":@"", ValidStr(skuModel.specifications) ? skuModel.specifications :@""] iconTypeArray:iconTypes];
    
    self.skuCode.text = [NSString stringWithFormat:@"商品编码:%@",skuModel.sku_code];
    NSString *estimatedDate = @"";
    if (skuModel.count.integerValue <= skuModel.actual_stock.integerValue && skuModel.actual_stock.integerValue > 0) {
        estimatedDate = @"1天";
    } else {
        estimatedDate = [NSString stringWithFormat:@"%ld天",skuModel.arrival_cycle.integerValue + 1];
    }
    self.estimatedDate.text = [NSString stringWithFormat:@"预计出货日:%@",estimatedDate];
    self.countField.maxCount = skuModel.actual_stock.integerValue + skuModel.virtual_stock.integerValue;
    self.countField.minCount = 0;
    self.countField.count = skuModel.count.integerValue;
    self.countField.miniOrder = skuModel.mini_order.integerValue;
    
    /**
     * 购买限制类型(0起订量的正整数倍,1不低于起订量的正整数)
     */
    if ([skuModel.order_limit_type isEqualToString:@"0"]) {
        self.countField.miniOrderType = GHCountFieldMiniOrderTypeMultiple;
    } else {
        self.countField.miniOrderType = GHCountFieldMiniOrderTypeStep;
    }
    [self actionControlState];
}

- (NSMutableAttributedString *)getActivityPrice {
    NSString *price = [NSString stringWithFormat:@"¥%.2f",self.skuModel.sale_price.doubleValue];;
    NSString *activity_price = [NSString stringWithFormat:@"¥%.2f",self.skuModel.activity_price.doubleValue];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",activity_price,price]];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, activity_price.length)];
    [att addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x999999),NSStrikethroughStyleAttributeName: @(1),NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(activity_price.length + 1, price.length)];
    return att;
}

- (void)actionControlState {
    if ((self.skuModel.actual_stock.integerValue + self.skuModel.virtual_stock.integerValue) <= 0) {
        self.skuName.textColor = UIColorFromRGB(0x999999);
        self.price.textColor = UIColorFromRGB(0x999999);
        self.countField.textColor = UIColorFromRGB(0x999999);
        self.userInteractionEnabled = NO;
        self.inventory.hidden = NO;
    } else {
        self.countField.textColor = UIColorFromRGB(0x333333);
        self.skuName.textColor = UIColorFromRGB(0x333333);
        self.userInteractionEnabled = YES;
        self.inventory.hidden = YES;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = (kScreenWidth - 50) / 3.01;
    [self.contentView addSubview:self.skuCode];
    [self.skuCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.width.equalTo(@(width));
    }];
    
    [self.contentView addSubview:self.estimatedDate];
    [self.estimatedDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.skuCode.mas_right).offset(10);
        make.centerY.equalTo(self.skuCode);
        make.width.equalTo(@(width));
    }];
    
    [self.contentView addSubview:self.inventory];
    [self.inventory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.estimatedDate.mas_right).offset(10);
        make.centerY.equalTo(self.estimatedDate);
        make.width.equalTo(@(width));
    }];
    
    [self.contentView addSubview:self.skuName];
    [self.skuName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.skuCode);
        make.bottom.equalTo(self.skuCode.mas_top).offset(-10);
        make.width.equalTo(@(width));
    }];
    
    [self.contentView addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.skuName.mas_right).offset(10);
        make.centerY.equalTo(self.skuName);
        make.width.equalTo(@(width));
    }];
    
    [self.contentView addSubview:self.countField];
    [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.price.mas_right).offset(10);
        make.centerY.equalTo(self.price);
        make.width.equalTo(@(width));
        make.height.equalTo(@(26));
    }];
    
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.skuName);
        make.right.equalTo(self.countField);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@(1));
    }];
}

+ (CGFloat)getCellHeightWithSkuModel:(GHSpecificationSelectionModel *)skuModel {
    CGFloat width = (kScreenWidth - 50) / 3.01;
    UILabel *skuName = [[UILabel alloc]init];
    UILabel *priceLab = [[UILabel alloc]init];
    NSMutableArray *iconTypes = [NSMutableArray array];
    if ([skuModel.isHaveActivity isEqualToString:@"1"]) {
        if ([skuModel.activityType isEqualToString: @"10"]) {
            NSString *price = [NSString stringWithFormat:@"¥%.2f",skuModel.sale_price.doubleValue];;
            NSString *activity_price = [NSString stringWithFormat:@"¥%.2f",skuModel.activity_price.doubleValue];
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",activity_price,price]];
            [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, activity_price.length)];
            
            [att addAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x999999),NSStrikethroughStyleAttributeName: @(1),NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(activity_price.length + 1, price.length)];
            priceLab.attributedText = att;
        } else if ([skuModel.activityType isEqualToString:@"20"]) {
            priceLab.text = [NSString stringWithFormat:@"￥%@",skuModel.sale_price];
        }
    } else {
        iconTypes = nil;
        priceLab.text = [NSString stringWithFormat:@"￥%@",skuModel.sale_price];
    }
    skuName.text= [NSString stringWithFormat:@"%@%@%@", ValidStr(skuModel.color)? skuModel.color:@"", ValidStr(skuModel.color) ? @"/":@"", ValidStr(skuModel.specifications) ? skuModel.specifications :@""];
    
    CGSize skuNameSzie = [skuName sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    CGSize skuCodeSzie = [NSString sizeWithText:[NSString stringWithFormat:@"商品编码:%@",skuModel.sku_code] andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(width, MAXFLOAT)];
    CGFloat leftHeight = 15 + skuNameSzie.height + 10 + skuCodeSzie.height + 15;
    CGSize priceSzie = [priceLab sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    NSString *estimatedDate = @"";
    if (skuModel.count.integerValue <= skuModel.actual_stock.integerValue && skuModel.actual_stock.integerValue > 0) {
        estimatedDate = @"1天";
    } else {
        estimatedDate = [NSString stringWithFormat:@"%ld天",skuModel.arrival_cycle.integerValue + 1];
    }
    CGSize estimatedDateSzie = [NSString sizeWithText:[NSString stringWithFormat:@"预计出货日:%@",estimatedDate] andFont:[UIFont systemFontOfSize:10] andMaxSize:CGSizeMake(width, MAXFLOAT)];
    CGFloat rightHeight = 15 + priceSzie.height + 10 + estimatedDateSzie.height + 15;
    if (leftHeight >= rightHeight) {
        return leftHeight;
    }
    return rightHeight;
}

- (UILabel *)price {
    if (_price == nil) {
        _price = [[UILabel alloc]init];
        _price.font = [UIFont systemFontOfSize:12];
        _price.textColor = UIColorFromRGB(0x333333);
        _price.text = @"价格(元)";
        _price.numberOfLines = 0;
        _price.textAlignment = NSTextAlignmentCenter;
    }
    return _price;
}

- (UILabel *)estimatedDate {
    if (_estimatedDate == nil) {
        _estimatedDate = [[UILabel alloc]init];
        _estimatedDate.font = [UIFont systemFontOfSize:10];
        _estimatedDate.textColor = UIColorFromRGB(0x999999);
        _estimatedDate.textAlignment = NSTextAlignmentCenter;
        
    }
    return _estimatedDate;
}

- (UILabel *)skuName {
    if (_skuName == nil) {
        _skuName = [[UILabel alloc]init];
        _skuName.font =  [UIFont systemFontOfSize:10];
        _skuName.textColor = UIColorFromRGB(0x999999);
    }
    return _skuName;
}

- (UILabel *)skuCode {
    if (_skuCode == nil) {
        _skuCode = [[UILabel alloc]init];
        _skuCode.font =  [UIFont systemFontOfSize:10];
        _skuCode.textColor = UIColorFromRGB(0x999999);
    }
    return _skuCode;
}

- (UILabel *)inventory {
    if (_inventory == nil) {
        _inventory = [[UILabel alloc]init];
        _inventory.font =  [UIFont systemFontOfSize:10];
        _inventory.textColor = [UIColor redColor];
        _inventory.text = @"库存不足";
        _inventory.textAlignment = NSTextAlignmentCenter;
    }
    return _inventory;
}

//- (XFSIconLabel *)skuName {
//    if (_skuName == nil) {
//        _skuName = [[XFSIconLabel alloc]init];
//        _skuName.font = JZGFont(12);
//        _skuName.textColor = UIColorFromRGB(0x333333);
//        _skuName.textAlignment = NSTextAlignmentLeft;
//        _skuName.numberOfLines = 0;
//    }
//    return _skuName;
//}

- (GHTextField *)countField {
    if (_countField == nil) {
        _countField = [[GHTextField alloc] init];
        _countField.backgroundColor = [UIColor whiteColor];
        _countField.showBorderLine = YES;
        _countField.delegate = self;
        _countField.tintColor = [UIColor redColor];
        weakself(self);
        _countField.countDidChangeBlock = ^(NSInteger count) {
            weakSelf.skuModel.count = [NSString stringWithFormat:@"%ld",(long)count];
            if (weakSelf.countBlock) {
                weakSelf.countBlock(weakSelf.skuModel);
            }
        };
    }
    return _countField;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    }
    return _line;
}


@end

@interface GHAlibabaSpecificationSelection()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

/**
 自定义view
 */
@property (nonatomic , strong) GHScrollTitles *scrollTitles;

/**
 自定义view
 */
@property (nonatomic , strong) UIView *backGround;
/**
 图标
 */
@property (nonatomic , strong) UIImageView *icon;
/**
 关闭
 */
@property (nonatomic , strong) UIButton *close;

/**
 sku标题
 */
@property (nonatomic , strong) UILabel *title;

/**
 sku价格
 */
@property (nonatomic , strong) UILabel *price;

/**
 最小起订量
 */
@property (nonatomic , strong) UILabel *minimumOrder;

/**
 *
 */
@property (nonatomic , strong) UIView *shadow;

/**
 *
 */
@property (nonatomic , strong) UIScrollView *scrollView;

/**
 *
 */
@property (nonatomic , strong) UIView *test;

@property (nonatomic , strong) NSMutableArray *arrays;

@property (nonatomic , assign) NSInteger currentPage;

@property (nonatomic , assign) int lastContentOffset;

@property (nonatomic , strong) UITableView *table;

@property (nonatomic , strong) UILabel *t;

@property (nonatomic , strong) NSArray *skuList;

@property (nonatomic , strong) NSMutableArray *tables;

@property (nonatomic , strong) NSArray *colors;

@property (nonatomic , strong) GHAlibabaSpecificationSelectionBottomView *bottomView;

@end

@implementation GHAlibabaSpecificationSelection

- (void)clickClose {
    [self dismiss];
}

- (void)show {
    [self configuration];
    [self configDefaultUI];
    [super show];
}

- (void)setSkuList:(NSArray *)skuList colors:(NSArray *)colors sectePrice:(NSDictionary *)sectePrice {
    self.skuList = skuList;
    self.colors = colors;
    NSString *max_price = sectePrice[@"max_price"];
    NSString *min_price = sectePrice[@"min_price"];
    self.price.attributedText = [self getRealPirceWithMaxPrice:max_price min_price:min_price];
    NSMutableArray *titles = [NSMutableArray array];
    if (colors.count > 1) {
        for (NSInteger i = 0; i < colors.count; i++) {
            GHSpecificationSelectionTitleModel *titleModel = [[GHSpecificationSelectionTitleModel alloc]init];
            NSString *colorStr = colors[i];
            titleModel.color = colorStr;
            NSMutableArray *skus = [NSMutableArray array];
            for (NSInteger j = 0; j < skuList.count; j++) {
                GHSpecificationSelectionModel *skuModel = skuList[j];
                if ([skuModel.color isEqualToString:titleModel.color]) {
                    [skus addObject:skuModel];
                }
            }
            titleModel.skuList = skus.copy;
            [titles addObject:titleModel];
        }
    } else {
        GHSpecificationSelectionTitleModel *titleModel = [[GHSpecificationSelectionTitleModel alloc]init];
        NSMutableArray *skus = [NSMutableArray array];
        for (NSInteger j = 0; j < skuList.count; j++) {
            GHSpecificationSelectionModel *skuModel = skuList[j];
            [skus addObject:skuModel];
        }
        titleModel.skuList = skus.copy;
        [titles addObject:titleModel];
    }
    self.scrollTitles.titles = titles.mutableCopy;
    [self setTableViews];
    [self loadIconWithIndex:0];
}

- (NSMutableAttributedString *)getRealPirceWithMaxPrice:(NSString *)max_price min_price:(NSString *)min_price  {
    if (!ValidStr(max_price)) {
        return nil;
    }
    if (!ValidStr(min_price)) {
        return nil;
    }
    NSMutableAttributedString *maxPrice = [self actionPrice:max_price];
    NSMutableAttributedString *minPrice = [self actionPrice:min_price];
    NSMutableAttributedString *realPrice = [[NSMutableAttributedString alloc]init];
    [realPrice appendAttributedString:minPrice];
    [realPrice appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@" ~"]];
    [realPrice appendAttributedString:maxPrice];
    return realPrice;
}

- (NSMutableAttributedString *)actionPrice:(NSString *)price {
    
    NSString *priceStr = [NSString stringWithFormat:@"￥%.2f",price.doubleValue];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(0, priceStr.length)];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, 1)];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(priceStr.length - 2, 2)];
    
    return att;
}

- (void)loadIconWithIndex:(NSInteger)index {
    GHSpecificationSelectionTitleModel *titleModel = self.scrollTitles.titles[index];
    GHSpecificationSelectionModel *skuModelFirst = titleModel.skuList.firstObject;
    GHSpecificationSelectionImageModel *imagesModel = skuModelFirst.images.firstObject;
    self.title.text = [NSString stringWithFormat:@"%@",skuModelFirst.sku_name];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:imagesModel.img_url]];
    self.minimumOrder.text = [NSString stringWithFormat:@"最少起订量: %@%@",skuModelFirst.mini_order,skuModelFirst.unit];
    UITableView *tabele = self.tables[index];
    self.currentPage = index;
    [tabele reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)keyBoardDidShow:(NSNotification*)notifiction {
    
    NSValue *keyboardObject = [[notifiction userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    double duration = [[notifiction.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:0];
    self.contentView.y = kScreenHeight - keyboardRect.size.height - self.contentView.height;
    [UIView commitAnimations];
}

- (void)keyBoardDidHide:(NSNotification*)notification {
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    self.contentView.y = kScreenHeight - self.contentView.height - kSafeAreaBottomHeight;
    [UIView commitAnimations];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.icon];
    CGFloat width = kScreenWidth - (CGRectGetMaxX(self.icon.frame) + 20) - (kScreenWidth - CGRectGetMinX(self.close.frame)) - 10;
    CGSize titleSize = [NSString sizeWithText:self.title.text andFont:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(width, MAXFLOAT)];
    self.title.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + 20, 5, width, titleSize.height);
    [self.contentView addSubview:self.close];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.price];
    self.price.frame = CGRectMake(CGRectGetMinX(self.title.frame), CGRectGetMaxY(self.title.frame) + 3, self.title.width , 21);
    [self.contentView addSubview:self.minimumOrder];
    self.minimumOrder.frame = CGRectMake(CGRectGetMinX(self.price.frame), CGRectGetMaxY(self.price.frame) + 2, self.price.width, 21);
    [self.contentView addSubview:self.shadow];
    self.shadow.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame) + 10, kScreenWidth, 10);
    
    [self.contentView addSubview:self.scrollTitles];
    if (self.colors.count > 1) {
        [self.contentView addSubview:self.scrollTitles];
        self.scrollTitles.frame = CGRectMake(0, CGRectGetMaxY(self.shadow.frame) + 10, kScreenWidth, 50);
    } else {
        self.scrollTitles.frame = CGRectMake(0, CGRectGetMaxY(self.shadow.frame) + 10, kScreenWidth, 0);
    }
    [self.contentView addSubview:self.scrollView];
    CGFloat scrollViewY = self.colors.count > 1 ? CGRectGetMaxY(self.scrollTitles.frame):CGRectGetMaxY(self.shadow.frame) + 10;
    CGFloat scrollViewH = 500 - CGRectGetMaxY(self.scrollTitles.frame) - 50;
    self.scrollView.frame = CGRectMake(0,scrollViewY, kScreenWidth,scrollViewH);
    [self setTableViews];
    [self.contentView addSubview:self.bottomView];
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), kScreenWidth, 50 + kSafeAreaBottomHeight);
}

- (void)setTableViews {
    [self.tables removeAllObjects];
    
    for (NSInteger index = 0; index < (self.colors.count > 1 ? self.colors.count:1); index++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width * index  , 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        tableView.showsVerticalScrollIndicator = YES;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[GHSpecificationSelectionCell class] forCellReuseIdentifier:@"GHSpecificationSelectionCellID"];
        [self.tables addObject:tableView];
        [self.scrollView addSubview:tableView];
    }
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * self.scrollTitles.titles.count, 0);
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.scrollTitles setMenusScrollViewEnd:scrollView.contentOffset];
    NSInteger page = (NSInteger)self.scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    [self loadIconWithIndex:page];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        [self.scrollTitles setMenusScrollView:scrollView.contentOffset];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GHSpecificationSelectionTitleModel *titleModel = self.scrollTitles.titles[self.currentPage];
    return titleModel.skuList.count;
}

#pragma mark 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GHSpecificationSelectionTitleModel *titleModel = self.scrollTitles.titles[self.currentPage];
    GHSpecificationSelectionModel *skuModel = titleModel.skuList[indexPath.row];
    GHSpecificationSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHSpecificationSelectionCellID"];
    cell.skuModel = skuModel;
    weakself(self);
    cell.countBlock = ^(GHSpecificationSelectionModel * _Nonnull skuModel) {
        [weakSelf.scrollTitles reloadData];
        [weakSelf.bottomView changeStatusWithTitles:weakSelf.scrollTitles.titles];
    };
    return cell;
}

#pragma mark - 计算高度
-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GHSpecificationSelectionTitleModel *titleModel = self.scrollTitles.titles[self.currentPage];
    GHSpecificationSelectionModel *skuModel = titleModel.skuList[indexPath.row];
    return [GHSpecificationSelectionCell getCellHeightWithSkuModel:skuModel];
}

- (void)scrollWithCurrentIndex:(NSInteger)currentIndex {
    CGPoint offset = self.scrollView.contentOffset;
    offset.x =  [UIScreen mainScreen].bounds.size.width * currentIndex;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - get

- (GHScrollTitles *)scrollTitles {
    if (_scrollTitles == nil) {
        _scrollTitles = [[GHScrollTitles alloc]init];
        _scrollTitles.frame = CGRectMake(0, CGRectGetMaxY(self.shadow.frame) + 10, [UIScreen mainScreen].bounds.size.width, 50);
        weakself(self);
        _scrollTitles.didClickTitleBlock = ^(NSInteger tag) {
            [weakSelf scrollWithCurrentIndex:tag];
            weakSelf.currentPage = tag;
            [weakSelf.table reloadData];
        };
        _scrollTitles.didClickLeftBlock = ^{
            CGPoint point = CGPointMake(weakSelf.scrollView.contentOffset.x - [UIScreen mainScreen].bounds.size.width , 0);
            [weakSelf.scrollView setContentOffset:point animated:YES];
        };
        _scrollTitles.didClickRightBlock = ^{
            CGPoint point = CGPointMake(weakSelf.scrollView.contentOffset.x + [UIScreen mainScreen].bounds.size.width , 0);
            [weakSelf.scrollView setContentOffset:point animated:YES];
        };
    }
    return _scrollTitles;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0,CGRectGetMaxY(self.scrollTitles.frame), [UIScreen mainScreen].bounds.size.width,self.contentViewHeight -CGRectGetMaxY(self.scrollTitles.frame));
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, -20, 100, 100)];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 5;
        _icon.backgroundColor = [UIColor redColor];
    }
    return _icon;
}

- (UIButton *)close {
    if (_close == nil) {
        _close = [[UIButton alloc]init];
        [_close setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        _close.frame = CGRectMake(self.frame.size.width - 30 - 10, 20, 30, 30);
        [_close addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _close;
}

- (void)clickSure {
    [self dismiss];
    NSMutableArray *skuIdNumlist = [NSMutableArray array];
    for (GHSpecificationSelectionTitleModel *titleModel in self.scrollTitles.titles) {
        for (GHSpecificationSelectionModel *skuModel in titleModel.skuList) {
            if (ValidStr(skuModel.count) && skuModel.count.integerValue > 0) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                dict[@"skuId"] = skuModel.sku_id;
                dict[@"skuNum"] = skuModel.count;
                dict[@"color"] = skuModel.color;
                [skuIdNumlist addObject:dict];
            }
        }
    }
    self.getDataBlock? self.getDataBlock(skuIdNumlist):nil;
}

- (UIView *)shadow {
    if (_shadow == nil) {
        _shadow = [[UIView alloc]init];
        _shadow.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame) + 10, [UIScreen mainScreen].bounds.size.width, 10);
        _shadow.backgroundColor = [UIColor whiteColor];
        _shadow.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadow.layer.shadowOffset = CGSizeMake(0, 5);
        _shadow.layer.shadowOpacity = 0.09;
    }
    return _shadow;
}

- (UILabel *)minimumOrder {
    if (_minimumOrder == nil) {
        _minimumOrder = [[UILabel alloc]init];
        _minimumOrder.frame = CGRectMake(CGRectGetMinX(self.price.frame), CGRectGetMaxY(self.price.frame) + 5, 100, 21);
        _minimumOrder.text = @"标题";
    }
    return _minimumOrder;
}

- (UILabel *)price {
    if (_price == nil) {
        _price = [[UILabel alloc]init];
        _price.frame = CGRectMake(CGRectGetMinX(self.title.frame), CGRectGetMaxY(self.title.frame) + 5, 100, 21);
        _price.text = @"标题";
    }
    return _price;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + 20, 10, 200, 21);
        _title.text = @"标题";
    }
    return _title;
}

- (NSMutableArray *)arrays {
    if (_arrays == nil) {
        _arrays = [NSMutableArray array];
    }
    return _arrays;
}

- (NSMutableArray *)tables {
    if (_tables == nil) {
        _tables = [NSMutableArray array];
    }
    return _tables;
}

- (GHAlibabaSpecificationSelectionBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[GHAlibabaSpecificationSelectionBottomView alloc]init];
        weakself(self);
        _bottomView.didClickSureBlock = ^{
            [weakSelf clickSure];
        };
    }
    return _bottomView;
}


@end
