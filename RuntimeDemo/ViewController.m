//
//  ViewController.m
//  RuntimeDemo
//
//  Created by user on 2021/7/6.
//

#import "ViewController.h"
#import "Student.h"
#import <objc/runtime.h>
#import "TimerViewController.h"
#import "TimerProxy.h"
#import "Monitoring_FPS.h"
#import "Monitoring_Runloop.h"

@interface ViewController ()

@property(nonatomic,strong) NSTimer * timer;/**ins*/
@property(nonatomic,assign) int increaseIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self monitoring_FPS];
    
    [self monitoring_runloop];
 
//    [self timerCicleTest];
}


#pragma mark -- 卡顿监听。。。。。。。
/***
 卡顿监控。。。
 */
- (void)monitoring_FPS{
    Monitoring_FPS * fpslab = [[Monitoring_FPS alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    fpslab.layer.borderColor = [UIColor greenColor].CGColor;
    [self.view addSubview:fpslab];
}

- (void)monitoring_runloop{
//    Monitoring_Runloop
}

- (void)montoring_pingThread{
    ////这个其实可以参考滴滴DoraemonANR  内部检测卡顿原理就应用了ping子线程方式
//    Monitoring_ping
}



#pragma mark -- timer循环引用。。。。。。。。
/***
 timer循环引用测试
 */
- (void)timerCicleTest{
    TimerViewController *timevc = [[TimerViewController alloc] init];
    [self presentViewController:timevc animated:YES completion:nil];
}
 
  
 

#pragma mark -- 测试消息转发流程。。。。。
/***
 消息转发流程。。。
 */
//
//void resolveMethodTest(void){
//    NSLog(@"----------%s",__func__);
//}
//
///**为一个类动态提供方法实现  实际还未进入方法转发
// respondsToSelector:和instancesRespondToSelector:也会调用resolveInstanceMethod:获取返回值
// 如果此方法返回NO则进入方法转发。。一般我们不操作这个方法因为系统底层很多都需要它操作。返回yes。。*/
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    NSLog(@"%s",__func__);
////    if (sel == NSSelectorFromString(@"studentMethod")) {
////        class_addMethod([self class], sel, resolveMethodTest, "v@:");
////        return YES;
////    //获取sayMaster方法的imp
////    IMP imp = class_getMethodImplementation(self, @selector(resolveMethodTest));
////    //获取sayMaster的实例方法
////    Method sayMethod  = class_getInstanceMethod(self, @selector(resolveMethodTest));
////    //获取sayMaster的丰富签名
////    const char *type = method_getTypeEncoding(sayMethod);
////    //将sel的实现指向sayMaster
////    return class_addMethod(self, sel, imp, type);
////    }
//    return [super resolveInstanceMethod:sel];
//}
//
///**允许你指定特有的对象。进行消息转发。从对象出发去查找消息*/
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    NSLog(@"%s",__func__);
//    if (aSelector == NSSelectorFromString(@"studentMethod")) {
////        return Student.class; //调用classMethod
////        return [[Student alloc] init]; //调用instanceMethod
//        return nil; //继续转发
//    }
//    return [super forwardingTargetForSelector:aSelector];
//
//}
//
///**methodSignatureForSelector和forwardInvocation关联。。提供方法签名调用。。forwardinvocation可以更改target也可以更改方法*/
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//    NSLog(@"%s",__func__);
//    if (aSelector == NSSelectorFromString(@"studentMethod")) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//    return [super methodSignatureForSelector:aSelector];
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
////    avoidcrash内部采取catch方式拦截
//    @try {
//        if (anInvocation.selector == @selector(studentMethod)) {
//            anInvocation.target = Student.class;
//            anInvocation.selector = @selector(say);
//            [anInvocation invoke];
//        }else{
//            [super forwardInvocation:anInvocation];
//        }
//
//
//    } @catch (NSException *exception) {
//
//    } @finally {
//
//    }
//}


@end
