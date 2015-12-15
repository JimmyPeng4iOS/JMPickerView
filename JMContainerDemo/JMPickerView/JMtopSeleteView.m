//
//  JMtopSeleteView.m
//  JMtopSeleteViewDemo
//
//  Created by Jimmy on 15/12/4.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "JMtopSeleteView.h"

#import "JMControllerCache.h"


//#define width [UIScreen mainScreen].bounds.size.width



#define padding 16

@interface JMtopSeleteView ()<JMPickerViewDelegate,JMPickerViewDataSource>


//初始Index
@property (nonatomic, assign) NSInteger firstIndex;

//按钮个数
@property (nonatomic, assign) NSInteger    number;

//上一个按钮
@property (nonatomic, strong) UIButton     *lastButton;

//底部view
@property (nonatomic, strong) UIView       *bottomView;

//pickerView
@property (nonatomic, strong) JMPickerView *pickerView;

//缓存器
@property (nonatomic, strong) JMControllerCache* vcCache;



@end



@implementation JMtopSeleteView

//类方法
+ (instancetype)topViewWithNum:(NSInteger)number andTitle:(NSArray *)titleArray titleColor:(UIColor *)titleColor barColor:(UIColor *)barColor
{
    return [[self alloc] initWithNum:number andTitle:titleArray titleColor:titleColor barColor:(UIColor *)barColor];
}

/**
 *  重写构造方法
 *
 *  @param number     按钮的数目
 *  @param titleArray 按钮的标题数组
 *  @param color      整体的颜色
 *
 */
- (instancetype)initWithNum:(NSInteger)number andTitle:(NSArray *)titleArray titleColor:(UIColor *)titleColor barColor:(UIColor *)barColor
{
    if (self = [super init])
    {
        [self prepareUIWithNum:number andTitle:titleArray titleColor:(UIColor *)titleColor];
        
        self.backgroundColor = barColor;
    }
    return self;
}

//布局子控件
- (void)layoutSubviews
{
    //一定要调用父类的!
    [super layoutSubviews];
    //设置frame
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat buttonW = width / self.number;
    CGFloat buttonH = height;
    CGFloat buttonY = 0;
    
    
    int i = 0;
    
    for (UIButton *button in self.subviews)
    {
        CGFloat buttonX = i * buttonW;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        i++;
        
        if (i == self.number + 1)
        {
            self.bottomView.frame = CGRectMake(self.firstIndex * button.frame.size.width + padding/2, buttonH* 4/5, buttonW - padding , 2);
        }
    }
    
}

/**
 *  准备UI
 */
- (void)prepareUIWithNum:(NSInteger)number andTitle:(NSArray *)titleArray titleColor:(UIColor *)color
{
    
    self.pickerView.delegate = self;
    
    self.pickerView.dataSource = self;
    
    self.oldIndex = -1;
    
    NSAssert(titleArray.count == number, @"传入的按钮数目与数组元素个数不符");
    
    //添加按钮
    for (int i = 0; i < number; i++)
    {
        //创建按钮
        UIButton *button = [[UIButton alloc] init];
        //设置标题
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        
        self.number = number;
        //设置颜色
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateSelected];
        //设置font
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        //设置tag
        button.tag = i;
        //设置点击方法
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加按钮
        [self addSubview:button];
        
    }
    
    //设置背景颜色
    self.bottomView.backgroundColor = color;
    //添加子控件
    [self addSubview:self.bottomView];
    
}

//点击按钮的方法
- (void)buttonClick:(UIButton *)button
{
    if (button.tag == self.oldIndex)
    {
        return;
    }
    //上一个的点击事件取消
    self.lastButton.selected = NO;
    //设置选中
    button.selected = YES;
    self.lastButton = button;
    self.newIndex = button.tag;
    //设置底部滑条
    
    CGFloat ViewW = button.frame.size.width - padding ;
    CGFloat ViewH = 2;
    CGFloat ViewX = button.frame.origin.x + padding/2 ;
    CGFloat ViewY = button.frame.size.height* 4/5;
    //设置动画
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.frame = CGRectMake(ViewX, ViewY, ViewW, ViewH);
    }];

    [self.pickerView switchTo:_newIndex];
    
    //设置index
    self.oldIndex = button.tag;
}


#pragma mark- 数据源方法


- (UIViewController *)JMPickerView:(JMPickerView *)sender controllerAt:(NSInteger)index
{
    //把index转成string
    NSString *key = [NSString stringWithFormat:@"%ld", (long)index];
    
    //缓存的话 读取缓存
    if ([self.vcCache objectForKey:key])
    {
        return [self.vcCache objectForKey:key];
    }
    else
    {
        //跳转的控制器 调用代理方法
        UIViewController *ctrl = [self.delegate JMtopSeleteView:self controllerAt:index];
        
        //如果没有缓存,则缓存控制器
        [self.vcCache setObject:ctrl forKey:key];
        
        return ctrl;
    }
}

#pragma mark- 代理

- (void)JMPickerView:(JMPickerView *)slide didSwitchTo:(NSInteger)index
{
    for (UIButton *button in self.subviews)
    {
        if (button.tag == index)
        {
            //选中按钮
            button.selected = YES;
            self.lastButton = button;
            self.oldIndex = self.pickerView.seletedIndex;
            self.firstIndex = index;
            return;
        }
    }
}



//懒加载
- (UIView *)bottomView
{
    if (_bottomView == nil)
    {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}



- (JMPickerView *)pickerView
{
    if (_pickerView == nil)
    {
        _pickerView = [[JMPickerView alloc] init];
    }
    return _pickerView;
}



- (JMControllerCache *)vcCache
{
    if (_vcCache == nil)
    {
        _vcCache = [[JMControllerCache alloc] initWithCount:_number];
    }
    return _vcCache;
}



@end
