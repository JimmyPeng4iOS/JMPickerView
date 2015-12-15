//
//  JMControllerCache.m
//  JMContainerDemo
//
//  Created by JimmyPeng on 15/12/15.
//  Copyright © 2015年 彭继宗. All rights reserved.
//

#import "JMControllerCache.h"

@interface JMControllerCache ()
//可变字典缓存vC
@property (nonatomic, strong) NSMutableDictionary *dict;
//可变数组记录次数
@property (nonatomic, strong) NSMutableArray *usedTimesList;
//容量
@property (nonatomic, assign) NSInteger capacity;

@end

@implementation JMControllerCache

- (instancetype)initWithCount:(NSInteger)count
{
    if (self = [super init])
    {
        _capacity = count;
    }
    
    return self;
}

- (void)setObject:(id)object forKey:(NSString *)key
{
    //如果字典不存在key
    if (![self.usedTimesList containsObject:key])
    {
        //数组个数小于容量,说明没满
        if (self.usedTimesList.count < _capacity)
        {
            //添加
            [self.dict setValue:object forKey:key];
            
            [self.usedTimesList addObject:key];
        }
        //满了,移除最前那个
        else
        {
            NSString *longTimeUnusedKey = [self.usedTimesList firstObject];
            
            [self.dict setValue:nil forKey:longTimeUnusedKey];
            
            [self.usedTimesList removeObjectAtIndex:0];
            //设置
            [self.dict setValue:object forKey:key];
            
            [self.usedTimesList addObject:key];
        }
    }
    // 字典存在key
    else
    {
        //更新
        [self.dict setValue:object forKey:key];
        
        [self.usedTimesList removeObject:key];
        
        [self.usedTimesList addObject:key];
    }
}

//获取缓存
- (id)objectForKey:(NSString *)key
{
    if ([self.usedTimesList containsObject:key])
    {
        //刷新在数组中的位置
        [self.usedTimesList removeObject:key];
        
        [self.usedTimesList addObject:key];
        
        return [self.dict objectForKey:key];
    }
    //不存在返回空
    else
    {
        return nil;
    }
}

#pragma mark- 懒加载

- (NSMutableDictionary *)dict
{
    if (_dict == nil)
    {
        _dict = [NSMutableDictionary dictionaryWithCapacity:_capacity];
    }
    return _dict;
}

- (NSMutableArray *)usedTimesList
{
    if (_usedTimesList == nil)
    {
        _usedTimesList = [NSMutableArray arrayWithCapacity:_capacity];
    }
    return _usedTimesList;
}











@end