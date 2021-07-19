//
//  Timer_NsProxy.h
//  RuntimeDemo
//
//  Created by user on 2021/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Timer_NsProxy : NSProxy
@property (weak, nonatomic) id target;
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
