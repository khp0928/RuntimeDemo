//
//  TimerProxy.m
//  RuntimeDemo
//
//  Created by user on 2021/7/9.
//

#import "TimerProxy.h"

@interface TimerProxy()

@property(nonatomic,weak) id target;

@end
@implementation TimerProxy

+(instancetype)proxyWithTarget:(id)target{
    TimerProxy * proxy = [[TimerProxy alloc] init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    return self.target;
}

@end
