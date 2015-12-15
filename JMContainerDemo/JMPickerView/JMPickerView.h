//
//  JMPickerView.h
//  JMContainerDemo
//
//  Created by JimmyPeng on 15/12/13.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@class JMPickerView;

/**
 *  数据源方法
 */
@protocol JMPickerViewDataSource <NSObject>

//返回一个要添加的子控制器(缓存)

- (UIViewController *)JMPickerView:(JMPickerView *)sender controllerAt:(NSInteger)index;
@end

/**
 *  代理
 */
@protocol JMPickerViewDelegate <NSObject>

@optional
//选中按钮的方法
- (void)JMPickerView:(JMPickerView *)slide didSwitchTo:(NSInteger)index;

@end


@interface JMPickerView : UIView
//选中的index
@property (nonatomic, assign) NSInteger seletedIndex;
//父容器
@property (nonatomic, strong) UIViewController *baseViewController;
//代理
@property (nonatomic, weak) id<JMPickerViewDelegate>delegate;
//数据源
@property (nonatomic, weak) id<JMPickerViewDataSource>dataSource;

//跳转控制器
- (void)switchTo:(NSInteger)index;

/**
 *  外界构造方法
 *
 *  @param baseController 父容器控制器
 *  @param seletedIndex   一开始选中的index
 *
 *  @return 构件好的pickerView
 */
+ (instancetype)pickerViewWithBaseViewController:(UIViewController *)baseController;

@end
