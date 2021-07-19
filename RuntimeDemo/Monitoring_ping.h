//
//  Monitoring_ping.h
//  RuntimeDemo
//
//  Created by user on 2021/7/13.
//


#import <UIKit/UIKit.h>

typedef void (^DoraemonANRTrackerBlock)(NSDictionary *info);

NS_ASSUME_NONNULL_BEGIN
@interface PingThread: NSThread
/**
 *  用于Ping主线程的线程类
 *  通过信号量控制来Ping主线程，判断主线程是否卡顿
 */
 

/**
 *  初始化Ping主线程的线程类
 *
 *  @param threshold 主线程卡顿阈值
 *  @param handler   监控到卡顿回调
 */
- (instancetype)initWithThreshold:(double)threshold
                          handler:(DoraemonANRTrackerBlock)handler;

@end

@interface Monitoring_ping : UIViewController

@end

NS_ASSUME_NONNULL_END
