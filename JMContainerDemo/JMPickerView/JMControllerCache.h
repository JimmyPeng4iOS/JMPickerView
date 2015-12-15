//
//  JMControllerCache.h
//  JMContainerDemo
//
//  Created by JimmyPeng on 15/12/15.
//  Copyright © 2015年 彭继宗. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JMCacheProtocol <NSObject>

- (void)setObject:(id)object forKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;

@end

@interface JMControllerCache : NSObject<JMCacheProtocol>

- (id)initWithCount:(NSInteger)count;

- (void)setObject:(id)object forKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;

@end
