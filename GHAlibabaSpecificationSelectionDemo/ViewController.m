//
//  ViewController.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "ViewController.h"
#import "GHAlibabaSpecificationSelection.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    GHAlibabaSpecificationSelection *alibabaSpecificationSelection = [[GHAlibabaSpecificationSelection alloc]init];
     [alibabaSpecificationSelection show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view. 
}


@end
