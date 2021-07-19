//
//  Timer_NsProxy.m
//  RuntimeDemo
//
//  Created by user on 2021/7/9.
//

#import "Timer_NsProxy.h"

@implementation Timer_NsProxy
+ (instancetype)proxyWithTarget:(id)target {
    Timer_NsProxy *proxy = [Timer_NsProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}
@end
