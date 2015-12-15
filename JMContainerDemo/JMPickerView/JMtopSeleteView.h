//
//  JMtopSeleteView.h
//  JMtopSeleteViewDemo
//
//  Created by Jimmy on 15/12/4.
//  Copyright © 2015年 Jimmy. All rights reserved.
//


#import "JMPickerView.h"
#import <UIKit/UIKit.h>

@class JMtopSeleteView;

/**
 *  代理方法
 */
@protocol JMtopSeleteViewDelegate <NSObject>

/**
 *  跳转方法
 *
 *  @param sender 调用的pickerView
 *  @param index  跳转的index
 *
 *  @return 跳转的控制器
 */
- (UIViewController *)JMtopSeleteView:(JMtopSeleteView *)sender controllerAt:(NSInteger)index;
@optional

@end



@interface JMtopSeleteView : UIView

//代理
@property(nonatomic, weak)id<JMtopSeleteViewDelegate> delegate;

//旧的index
@property (nonatomic, assign) NSInteger oldIndex;
//新的index
@property (nonatomic, assign) NSInteger newIndex;

/**
 *  给外界调用的类方法
 *
 *  @param number     按钮的数目
 *  @param titleArray 按钮的标题数组
 *  @param color      整体的颜色
 *
 */
+ (instancetype)topViewWithNum:(NSInteger)number andTitle:(NSArray *)titleArray titleColor:(UIColor *)titleColor barColor:(UIColor *)barColor;




@end
