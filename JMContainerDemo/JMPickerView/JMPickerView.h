//
//  JMPickerView.h
//  JMContainerDemo
//
//  Created by JimmyPeng on 15/12/13.
//  Copyright © 2015年 彭继宗. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMPickerView;

/**
 *  数据源方法
 */
@protocol JMPickerViewDataSource <NSObject>

//返回一个要添加的子控制器
- (UIViewController *)JMPickerView:(JMPickerView *)sender controllerAt:(NSInteger)index;

@end

/**
 *  代理
 */
@protocol JMPickerViewDelegate <NSObject>

@optional
//跳转的方法
- (void)JMPickerView:(JMPickerView *)slide switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(float)percent;

- (void)JMPickerView:(JMPickerView *)slide didSwitchTo:(NSInteger)index;

- (void)JMPickerView:(JMPickerView *)slide switchCanceled:(NSInteger)oldIndex;

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

- (void)switchTo:(NSInteger)index;

@end
