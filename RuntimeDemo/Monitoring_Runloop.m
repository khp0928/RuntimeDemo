//
//  Monitoring_Runloop.m
//  RuntimeDemo
//
//  Created by user on 2021/7/9.
//

#import "Monitoring_Runloop.h"

@interface Monitoring_Runloop ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, assign) NSUInteger timeoutCount;

@end

@implementation Monitoring_Runloop
{
  CFRunLoopActivity activity;
}

+ (instancetype)sharedInstance {
  static id instance = nil;
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
      instance = [[self alloc] init];
  });
  return instance;
}

- (void)start{
  [self registerObserver];
  [self startMonitor];
}

static void CallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
  Monitoring_Runloop *monitor = (__bridge Monitoring_Runloop *)info;
  monitor->activity = activity;
  // 发送信号
  dispatch_semaphore_t semaphore = monitor->_semaphore;
  dispatch_semaphore_signal(semaphore);
}

- (void)registerObserver{
  CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
  //NSIntegerMax : 优先级最小
  CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                          kCFRunLoopAllActivities,
                                                          YES,
                                                          NSIntegerMax,
                                                          &CallBack,
                                                          &context);
  CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
}


/***
 Run Loop Observer Activities
 typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0),
     kCFRunLoopBeforeTimers = (1UL << 1),
     kCFRunLoopBeforeSources = (1UL << 2),
     kCFRunLoopBeforeWaiting = (1UL << 5),
     kCFRunLoopAfterWaiting = (1UL << 6),
     kCFRunLoopExit = (1UL << 7),
     kCFRunLoopAllActivities = 0x0FFFFFFFU
 };
 
 */
- (void)startMonitor{
  // 创建信号c
  _semaphore = dispatch_semaphore_create(0);
  // 在子线程监控时长
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
      while (YES)
      {
          // 超时时间是 1 秒，没有等到信号量，st 就不等于 0， RunLoop 所有的任务
          // 没有接收到信号底层会先对信号量进行减减操作，此时信号量就变成负数
          // 所以开始进入等到，等达到了等待时间还没有收到信号则进行加加操作复原信号量
          // 执行进入等待的方法dispatch_semaphore_wait会返回非0的数
          // 收到信号的时候此时信号量是1  底层是减减操作，此时刚好等于0 所以直接返回0
          long st = dispatch_semaphore_wait(self->_semaphore, dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC));
          if (st != 0)
          {
              if (self->activity == kCFRunLoopBeforeSources || self->activity == kCFRunLoopAfterWaiting)
              {
                  //如果一直处于处理source0或者接受mach_port的状态则说明runloop的这次循环还没有完成
                  if (++self->_timeoutCount < 2){
                      NSLog(@"timeoutCount==%lu",(unsigned long)self->_timeoutCount);
                      continue;
                  }
                  // 如果超过两秒则说明卡顿了
                  // 一秒左右的衡量尺度 很大可能性连续来 避免大规模打印!
                  NSLog(@"检测到超过两次连续卡顿");
              }
          }
          self->_timeoutCount = 0;
      }
  });
}


@end
