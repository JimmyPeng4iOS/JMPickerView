//
//  ViewController.m
//  JMContainerDemo
//
//  Created by 彭继宗 on 15/12/7.
//  Copyright © 2015年 彭继宗. All rights reserved.
//

#import "ViewController.h"

#import "RedViewController.h"
#import "GrayViewController.h"
#import "YellowViewController.h"
#import "BlueViewController.h"

#import "JMtopSeleteView.h"
#import "JMPickerView.h"

@interface ViewController ()<JMtopSeleteViewDelegate>

@property (nonatomic, strong) JMtopSeleteView *topView;

@property (nonatomic, strong) JMPickerView    *pickerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.delegate = self;
    
    
    self.pickerView.baseViewController = self;
    

    self.pickerView.seletedIndex = 3;
    
}


#pragma mark- topView代理方法

- (UIViewController *)JMtopSeleteView:(JMtopSeleteView *)sender controllerAt:(NSInteger)index
{
    switch (index)
    {
        case 0:
            return [[GrayViewController alloc] init];
        case 1:
            return [[RedViewController alloc] init];
        case 2:
            return [[YellowViewController alloc] init];
        default:
            return [[BlueViewController alloc] init];
            break;
    }
    return nil;

}


#pragma mark- 懒加载

- (JMtopSeleteView *)topView
{
    if (_topView == nil)
    {
        _topView = [JMtopSeleteView topViewWithNum:4 andTitle:@[@"gray",@"red",@"yellow",@"blue"] titleColor:[UIColor orangeColor]];
        
        _topView.frame = CGRectMake(0, 64, 375, 44);
        
    }
    return _topView;
}

- (JMPickerView *)pickerView
{
    if (_pickerView == nil)
    {
        _pickerView = [[JMPickerView alloc] init];
        
        self.view = _pickerView;
        
        [self.view addSubview:self.topView];
    }
    return _pickerView;
}

@end
