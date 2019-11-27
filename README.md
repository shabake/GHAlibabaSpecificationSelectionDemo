
#### 前言

因为最近有需求，需要做和阿里巴巴样式差不多的规格选择器，在简书，`cocoaChina`,`github`都没找到比较满意决定自己撸一个，简单做了一个`demo`展示大致的实现思路，如果你有更好方案，请联系我，如果这个`demo`对你有帮助，请点一个`star`是对我最大的鼓励，小弟感激不尽！

![未标题-2.png](https://upload-images.jianshu.io/upload_images/1419035-939d3461ce617c41.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/620)


#### Features

1.列表高度自适应，布局中心对齐。

2.动态输入监听，同步显示，根据输入判定确定状态。

3.数据模型重新组装。

4.适配`IPhoneX`及以上系列。

5.自带键盘监听，上移，收回。

6.通过`block`将用户选择的数据回调出来。

7.自动布局有无颜色导航器。

#### 演示

![Untitled.gif](https://upload-images.jianshu.io/upload_images/1419035-d077a726fdb7f320.gif?imageMogr2/auto-orient/strip)

#### 部分代码

初始化对象

引入
`#import GHAlibabaSpecificationSelection.h`

```objective-c
- (GHAlibabaSpecificationSelection *)alibabaSpecificationSelection {
    if (_alibabaSpecificationSelection == nil) {
        _alibabaSpecificationSelection = [[GHAlibabaSpecificationSelection alloc]init];
        _alibabaSpecificationSelection.contentViewHeight = 500;
    }
    return _alibabaSpecificationSelection;
}
```

传入数据

```objective-c
[self.alibabaSpecificationSelection setSkuList:specifications colors:colors sectePrice:sectePrice];

```

取出用户选择

```objective-c
  _alibabaSpecificationSelection.getDataBlock = ^(NSArray * _Nonnull dataArray) {
            NSLog(@"用户选择的数据%@",dataArray);
            NSMutableString *string = [NSMutableString string];
            for (NSDictionary *dict in dataArray) {
                [string appendFormat:@"颜色:%@  数量:%@  id:%@\n",dict[@"color"],dict[@"skuNum"],dict[@"skuId"]];
            }
            KAlert(@"用户选择的数据", string);
  };
```

####联系

[45329453@qq.com](45329453@qq.com)

[Github](https://github.com/shabake/)

[demo](https://github.com/shabake/GHAlibabaSpecificationSelectionDemo)

--
