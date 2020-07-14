


![未标题-2.png](https://upload-images.jianshu.io/upload_images/1419035-5554f91741be4c55.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 前言

仿阿里巴巴规格选择器，如果你有更好方案，请联系我，45329453@qq.com

如果这个`demo`对你有帮助，请点一个★是对我最大的鼓励，感激不尽！


#### Features

> 初始化确定按钮颜色置灰，不可点击。
> 
> 当 `spu` 颜色数量大于**1**个时，显示颜色导航，底部列表可以滚动，反之隐藏，布局自适应。
> 
> 如果有颜色导航，输入或点击 `+` `- ` 按钮，颜色导航对应的颜色数字同步变化，如果数量大于**99**显示**99**+；如果数量小于**1**不显示。
> 
> 点击`>` `<` 底部列表和颜色导航同步滚动。
> 
> 输入或点击 `+` `- ` 按钮，当按 `+ `到最大库存 `+ ` 置灰；当按 `-` 到0 `-` 置灰。
> 
> 点击输入框。键盘弹出，[规格选择器](####规格选择器) 上移；点击**完成**，键盘收回，[规格选择器](####规格选择器) 回到原位。
> 
> 点击颜色导航条的颜色标签，高亮被点击颜色标签并滚动到屏幕中心，底部列表滑动到对应位置，同时切换 `sku` 图片。
> 
> 当输入或者点击数量大于**1**，确定按钮可点击，颜色高亮。
> 
> 当库存不足的时候，输入框下显示`库存不足`标签。
> 
> 输入框不可输入  `0`  ，` .` 等特殊符号。
> 
> 列表行自适应高度，布局中心对齐。
> 
> 点击背景遮罩或者 `x ` ，收回弹窗。
> 
> 动态输入监听，同步显示，根据输入判定确定按钮状态。
> 
> 数据模型重新组装。
> 
> 适配`IPhoneX`及以上系列。
>
> 增加加入到购物车抛物线动画，购物车同步用户选择 `sku` 数量。 



#### 演示


![Untitled.gif](https://upload-images.jianshu.io/upload_images/1419035-8bdb57d69448450d.gif?imageMogr2/auto-orient/strip)

#### 使用

`demo` 数据是从接口获取，需要连接`wifi`或蜂窝网络。

数据结构 **(点击箭头展开/收起)**
<details>{
    "data": [
        {
            "arrival_cycle": 5,
            "sku_code": "000001",
            "spu_id": 7280,
            "sku_name": "我是测试数据黑色000001",
            "virtual_stock": 9999,
            "sale_price": "1.80",
            "images": [
                {
                    "img_url": "https://upload-images.jianshu.io/upload_images/1419035-0a54dde4c9663e36.png"
                }
            ],
            "specifications": "我是测试数据黑色000001",
            "color": "黑",
            "mini_order": 1,
            "unit": "个",
            "sku_id": 1
        },
        {
            "arrival_cycle": 5,
            "sku_code": "000002",
            "spu_id": 7280,
            "sku_name": "我是测试数据红色000001",
            "virtual_stock": 9999,
            "sale_price": "28.80",
            "images": [
                {
                    "img_url": "https://upload-images.jianshu.io/upload_images/1419035-8739c526d2790690.png"
                }
            ],
            "specifications": "1.5平方我是测试数据红色000001",
            "color": "红",
            "mini_order": 2,
            "unit": "台",
            "sku_id": 2
        },
        {
            "arrival_cycle": 5,
            "sku_code": "000003",
            "sku_name": "我是测试数据黄色000003",
            "virtual_stock": 9999,
            "sale_price": "88.80",
            "images": [
                {
                    "img_url": "https://upload-images.jianshu.io/upload_images/1419035-4dd868e628b61cc6.png"
                }
            ],
            "specifications": "我是测试数据黄色000003",
            "spu_code": "101191",
            "color": "黄",
            "mini_order": 3,
            "unit": "把",
            "sku_id": 3
        },
        {
            "arrival_cycle": 5,
            "sku_code": "000004",
            "sku_name": "我是测试数据绿色000004",
            "virtual_stock": 9999,
            "sale_price": "88.80",
            "images": [
                {
                    "img_url": "https://upload-images.jianshu.io/upload_images/1419035-44c60adcf6a74843.png"
                }
            ],
            "specifications": "我是测试数据绿色000004",
            "spu_code": "000004",
            "color": "绿",
            "mini_order": 4,
            "unit": "只",
            "sku_id": 4
        },
        {
            "arrival_cycle": 5,
            "sku_code": "000006",
            "sku_name": "我是测试数据蓝色000005",
            "virtual_stock": 9999,
            "sale_price": "88.80",
            "images": [
                {
                    "img_url": "https://upload-images.jianshu.io/upload_images/1419035-08b4629d7bba016c.png"
                }
            ],
            "specifications": "我是测试数据蓝色000005",
            "spu_code": "000006",
            "color": "蓝",
            "mini_order": 5,
            "unit": "双",
            "sku_id": 5
        },
        {
            "arrival_cycle": 5,
            "sku_code": "000006",
            "sku_name": "我是测试数据白色000006",
            "virtual_stock": 9999,
            "sale_price": "88.80",
            "images": [
                {
                    "img_url": "https://upload-images.jianshu.io/upload_images/1419035-f9ecb0bbc4a2a405.png"
                }
            ],
            "specifications": "我是测试数据白色000006",
            "spu_code": "000006",
            "color": "白",
            "mini_order": 6,
            "unit": "呵呵",
            "sku_id": 6
        },
        {
            "arrival_cycle": 5,
            "sku_code": "000007",
            "spu_id": 7280,
            "sku_name": "1.5平方我是测试数据黄绿000007",
            "virtual_stock": 9999,
            "sale_price": "88.80",
            "images": [
                {
                    "img_url": "https://upload-images.jianshu.io/upload_images/1419035-219ce100b765c4e6.png"
                }
            ],
            "specifications": "1.5平方我是测试数据黄绿000007",
            "color": "黄绿",
            "mini_order": 7,
            "unit": "吨",
            "sku_id": 7
        }
    ],
    "sectePrice": {
        "max_price": "3107.00",
        "min_price": "88.80"
    },
    "specifications": [
        "1.5平方",
        "2.5平方",
        "4平方",
        "6平方",
        "10平方",
        "16平方",
        "25平方",
        "35平方",
        "50平方"
    ],
    "color": [
        "红",
        "黄",
        "绿",
        "蓝",
        "黑",
        "白",
        "黄绿"
    ]
}</details>

`GHSpecificationSelectionTitleModel` 颜色导航器模型

`GHSpecificationSelectionModel` `sku` 模型

`GHSpecificationSelectionImageModel` 图片模型



**更新依赖库**

```
cd 项目路径
```

```
pod install
```

![carbon.png](https://upload-images.jianshu.io/upload_images/1419035-879de1e610062d8f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



如果更新 `Pod` 遇到问题,可以参考这篇[文章](https://www.jianshu.com/p/cd057b2055c0)

1.初始化对象

`GHAlibabaSpecificationSelection`继承 `GHPopView` ，`GHPopView` 已经封装好**弹出**/**收回**动画，外部无需重复处理。

```objective-c
- (void)show;
- (void)dismiss
```
`GHPopView`暴露一个`contentView`容器视图，子控件可以直接添加到这个视图。

```objective-c
@property (nonatomic, strong) UIView *contentView;
```

其中`contentViewHeight`是`contentView`容器视图的高度，初始化的时候必传

`#import GHAlibabaSpecificationSelection.h`

![carbon.png](https://upload-images.jianshu.io/upload_images/1419035-b4178d2971b737e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2.传入数据


```objective-c
/**
 * 数据源
 * @param skuList 装skuModel数组
 * @param colors 颜色数组 非必传，如果为空，不显示颜色导航
 * @param sectePrice 价格区间字典
 */
```

![carbon-2.png](https://upload-images.jianshu.io/upload_images/1419035-d19fe88c461f9de7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3.取出用户选择

![carbon-4.png](https://upload-images.jianshu.io/upload_images/1419035-0c222359f18ec0b3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



4.重置数据

> 在这个方法内部清除所有`count`。
> 
> 底部`scrollview` 滚动到初始化状态。
> 
> 底部确定按钮初始化状态。
> 
> `scrollTitles`初始化。


```objective-c
- (void) resetData;
```


#### 与我联系

45329453@qq.com

