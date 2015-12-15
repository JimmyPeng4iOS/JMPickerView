//
//  JMPickerView.m
//  JMContainerDemo
//
//  Created by JimmyPeng on 15/12/13.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "JMPickerView.h"

@interface JMPickerView ()

//旧的index
@property (nonatomic, assign) NSInteger        oldIndex;
//新的index
@property (nonatomic, assign) NSInteger        newIndex;
//是否跳转
@property (nonatomic, assign) BOOL             isSwitching;
//旧的控制器
@property (nonatomic, strong) UIViewController *oldVC;
//新的控制器
@property (nonatomic, strong) UIViewController *willVC;

@end

@implementation JMPickerView


+ (instancetype)pickerViewWithBaseViewController:(UIViewController *)baseController
{
    return [[self alloc] initWithBaseViewController:baseController];    
}

- (instancetype)initWithBaseViewController:(UIViewController *)baseController
{
    if (self = [super init])
    {
        self.oldIndex = -1;
        
        self.isSwitching = NO;
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        self.baseViewController = baseController;
        
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.oldIndex = -1;
        
        self.isSwitching = NO;
        
    }
    return self;
}

#pragma mark- 跳转的方法
/**
 *  跳转
 *
 *  @param index 跳转的index
 */
- (void)switchTo:(NSInteger)index
{
    //如果跳转是旧的index,return
    if (index == _oldIndex)
    {
        return;
    }
    
    //如果isSwitching_为YES return 防止多次点击
    if (_isSwitching) {
        return;
    }
    
    //如果 旧的VC存在 并且 旧VC 的父控制器是base控制器
    if (self.oldVC != nil && _oldVC.parentViewController == self.baseViewController)
    {
        //设置跳转bool为YES
        _isSwitching = YES;
        
        //定义oldVC = 旧的VC
        UIViewController *oldvc = _oldVC;
        
        //定义newVC = index返回的控制器
        UIViewController *newvc = [self.dataSource JMPickerView:self controllerAt:index];
        
        //添加子控制器
        [self.baseViewController addChildViewController:newvc];
        
        //设置frame
        //当前页面frame
        CGRect nowRect = oldvc.view.frame;
        //前面页面frame
        CGRect leftRect = CGRectMake(nowRect.origin.x-nowRect.size.width, nowRect.origin.y, nowRect.size.width, nowRect.size.height);
        //后面页面frame
        CGRect rightRect = CGRectMake(nowRect.origin.x+nowRect.size.width, nowRect.origin.y, nowRect.size.width, nowRect.size.height);
        
        
        CGRect newStartRect;
        
        CGRect oldEndRect;
        //如果新的index比旧的index大
        if (index > _oldIndex)
        {
            //新的是右边frame
            newStartRect = rightRect;
            //旧的是左边
            oldEndRect = leftRect;
        }
        else
        {//如果新的index比旧的index小
            //新的在左边
            newStartRect = leftRect;
            //旧的在右边
            oldEndRect = rightRect;
        }
        //赋值frame
        newvc.view.frame = newStartRect;
        
        
        [self.baseViewController transitionFromViewController:oldvc toViewController:newvc duration:0.4 options:0 animations:^{
            newvc.view.frame = nowRect;
            oldvc.view.frame = oldEndRect;
        } completion:^(BOOL finished) {
            [oldvc removeFromParentViewController];
            
            [newvc didMoveToParentViewController:self.baseViewController];
            
            _isSwitching = NO;
        }];
        
        _oldIndex = index;
        
        self.oldVC = newvc;
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(JMPickerView:didSwitchTo:)])
        {
            [self.delegate JMPickerView:self didSwitchTo:index];
        }
        [self showAt:index];
    }
    
    _willVC = nil;
    
}

//移除旧的控制器
- (void)removeOld
{
    [self removeCtrl:_oldVC];
    
    _oldVC = nil;
    
    _oldIndex = -1;
}

//移除新的控制器
- (void)removeWill
{
    [self removeCtrl:_willVC];
    
    _willVC = nil;
}

//展示
- (void)showAt:(NSInteger)index
{
    if (_oldIndex != index)
    {

        [self removeOld];
        
        UIViewController *vc = [self.dataSource JMPickerView:self controllerAt:index];
        
        [self.baseViewController addChildViewController:vc];
        
        vc.view.frame = self.frame;
        
        [self addSubview:vc.view];
        
        [vc didMoveToParentViewController:self.baseViewController];
        
        _oldIndex = index;
        
        _oldVC = vc;
    }
}

- (void)removeCtrl:(UIViewController *)ctrl
{
    UIViewController *vc = ctrl;
    
    [vc willMoveToParentViewController:nil];
    
    [vc.view removeFromSuperview];
    
    [vc removeFromParentViewController];
}



#pragma mark- setter 

- (void)setSeletedIndex:(NSInteger)seletedIndex
{
    _seletedIndex = seletedIndex;
    
    //pikerView跳转
    [self switchTo:seletedIndex];
}

#pragma mark- 懒加载
-(UIViewController *)oldVC
{
    if (_oldVC == nil)
    {
        _oldVC = [self.dataSource JMPickerView:self controllerAt:0];
    }
    return _oldVC;
}

#pragma mark- 单例
/**
 *  单例
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

@end
