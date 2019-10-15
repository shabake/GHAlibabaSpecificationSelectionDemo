//
//  GHScrollView.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHScrollView.h"

@interface GHScrollView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UIView* containerView;
@property (nonatomic, strong) NSMutableArray* arrays;

@property (nonatomic, strong) NSMutableArray* bufferViews;
@property int currentPage;
@property int toPage;

@end

static const int nBufferViews = 3;

@implementation GHScrollView

- (void)initDataArray {
    self.arrays = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int j = 0; j < 1000; j++) {
            NSString *string = [NSString stringWithFormat:@"%d__%d",i,j];
            [array addObject:string];
        }
        
        [self.arrays addObject:array];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        _currentPage = 0;
               _containerView = [[UIView alloc]init];
               _bufferViews = [[NSMutableArray alloc]init];
               _delegateForReuseableScrollView = nil;
        self.delegate = self;
        [self initDataArray];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _currentPage = 0;
        _containerView = [[UIView alloc]init];
        _bufferViews = [[NSMutableArray alloc]init];
        _delegateForReuseableScrollView = nil;
    }
    return self;
}

- (void)setupViews{
    CGRect rtContent = self.frame;
    rtContent.size.width = rtContent.size.width * nBufferViews;
    self.containerView.frame = CGRectMake(0, 0, rtContent.size.width, rtContent.size.height);
    self.contentSize = rtContent.size;
    [self addSubview:self.containerView];
    self.pagingEnabled = YES;
    [self setShowsHorizontalScrollIndicator:YES];
    
    for (int i=0; i<nBufferViews; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        CGRect rect = self.frame;
        rect.origin.x = rect.size.width * i;
        tableView.dataSource = self;
        tableView.delegate = self;

        tableView.frame = CGRectMake(rect.origin.x, 0, rect.size.width,rect.size.height);
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
        [self.bufferViews addObject:tableView];
        [self.containerView addSubview:tableView];

        if (i == 0) {
            tableView.backgroundColor = [UIColor redColor];
        }else if(i == 1){
            tableView.backgroundColor = [UIColor yellowColor];
        }else{
            tableView.backgroundColor = [UIColor blueColor];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.delegateForReuseableScrollView == nil) {
        NSLog(@"不执行reusable策略：self.delegateForReusableScrollView == nill");
        return;
    }
    // 如果总页数小于buffer页数，则没必要执行reusable策略
    if ([self.delegateForReuseableScrollView numOfPages] <= nBufferViews) {
        NSLog(@"不执行reusable策略：总页数小于buffer数");
        return;
    }
    UITableView *currentView = nil;
    NSUInteger maxPage = [self.delegateForReuseableScrollView numOfPages] - 1;
    if (self.currentPage == 0) {
        currentView = self.bufferViews[0];
    }else if (self.currentPage == maxPage){
        currentView = self.bufferViews[2];
    }else{
        currentView = self.bufferViews[1];
    }

    CGFloat offsetDiff = self.contentOffset.x - currentView.frame.origin.x;
    // 如果滑动幅度没有达到翻页，则不执行reusable策略
    if (fabs(offsetDiff) < self.frame.size.width) {
//        NSLog(@"不执行reusable策略：未达到翻页X(%d - %d)", (int)self.contentOffset.x, (int)currentView.frame.origin.x);
        return;
    }
    
    int toPage = self.currentPage;
    if (offsetDiff > 0) {
        toPage++;
    }else{
        toPage--;
    }
      
    // 如果是 第0页<=>第1页 或者 最后一页<=>倒数第二页，则仅更新currentPage
    if (self.currentPage == 0 || toPage == 0 || self.currentPage == maxPage || toPage == maxPage) {
        self.currentPage = toPage;
    }else{
        if (toPage > self.currentPage) {
            UITableView *view = self.bufferViews[0];
            self.bufferViews[0] = self.bufferViews[1];
            self.bufferViews[1] = self.bufferViews[2];
            self.bufferViews[2] = view;
            [self.delegateForReuseableScrollView setupView:self.bufferViews[2] toPage:toPage + 1];
          
        }else{
            UITableView *view = self.bufferViews[2];
            self.bufferViews[2] = self.bufferViews[1];
            self.bufferViews[1] = self.bufferViews[0];
            self.bufferViews[0] = view;
            [self.delegateForReuseableScrollView setupView:self.bufferViews[0] toPage:toPage - 1];

        }
        self.currentPage = toPage;
        
        for (int i=0; i<nBufferViews; i++) {
            UIView *view = self.bufferViews[i];
            CGRect rect = self.frame;
            rect.origin.x = rect.size.width * i;
            view.frame = CGRectMake(rect.origin.x, 0, rect.size.width, rect.size.height);
        }
        CGPoint contentOffset = ((UIView*)self.bufferViews[1]).frame.origin;
        self.contentOffset = contentOffset;
    }
    NSLog(@"%d-%d",self.currentPage,toPage);
    for (UITableView *tab in self.bufferViews) {
        [tab reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrays[self.currentPage] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    
    cell.textLabel.text = self.arrays[self.currentPage][indexPath.row];
    return cell;
}

@end
