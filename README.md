# JMpickerView
#####JMpickerView 是本人 Jimmy 使用`Objective-C`语言对子控制器间平滑切换封装的一个框架。 基于`UIViewController`的容器属性，通过添加子容器,可平滑高效的切换界面,同时保证只存在一个控制器,其他控制器在移出控制器时进行了缓存和销毁, 简单易用,效率高。 
---
#####Github地址:

<https://github.com/JimmyPeng4iOS/JMPickerView>

---
###示例

![示例](http://upload-images.jianshu.io/upload_images/1115674-a59526da457009aa.gif?imageMogr2/auto-orient/strip)

###使用方法:

* 懒加载选择bar和主View

```objective-c
//顶部 选择bar
- (JMtopSeleteView *)topView
{
    if (_topView == nil)
    {
        //指定按钮的数目(不建议超过6个), 标题数组 , 标题颜色,  bar的颜色
                _topView = [JMtopSeleteView topViewWithNum:4
                                    andTitle:@[@"gray",@"red",@"yellow",@"blue"]
                                    titleColor:[UIColor orangeColor]
                                    barColor:[UIColor whiteColor]];
        //可自定义frame
        _topView.frame = CGRectMake(0, 64,ScreenWidth, 44);
    }
    return _topView;
}
//主View
- (JMPickerView *)pickerView
{
    if (_pickerView == nil)
    {     //指定父容器, 一般为self
        _pickerView = [JMPickerView pickerViewWithBaseViewController:self];
        //View的frame
        _pickerView.frame = CGRectMake(0,108, ScreenWidth, ScreenHeight-108);
        //替换view
        self.view = _pickerView;
        //添加topBar
        [self.view addSubview:self.topView];
    }
    return _pickerView;
}
```

* 初始化

```objective-c
  //遵守<JMtopSeleteViewDelegate>代理
    self.topView.delegate = self;
  //定义一开始显示的页面
    self.pickerView.seletedIndex = 0;
```

* 实现代理方法

```objective-c
- (UIViewController *)JMtopSeleteView:(JMtopSeleteView *)sender controllerAt:(NSInteger)index
{
    switch (index)
    {
        case 0:
            return [[GrayViewController alloc] init];
        case 1:
            return [[RedViewController  alloc] init];
        case 2:
            return [[YellowViewController alloc] init];
        default:
            return [[BlueViewController alloc] init];
    }
}
```

---
#####最后 再来一遍github地址 (๑•̀ㅂ•́)و✧

<https://github.com/JimmyPeng4iOS/JMPickerView>

---
####个人中文博客 ┑(￣Д ￣)┍
<http://www.jianshu.com/users/53845c6b43dc/top_articles>