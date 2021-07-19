//
//  Monitoring_FPS.m
//  RuntimeDemo
//
//  Created by user on 2021/7/9.
//

#import "Monitoring_FPS.h"
#import "Timer_NsProxy.h"

#define kSize CGSizeMake(55, 20)
@implementation Monitoring_FPS {
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = kSize;
    }
    self = [super initWithFrame:frame];
    self.textColor = [UIColor redColor];
    self.font = [UIFont systemFontOfSize:18.0];
    _link = [CADisplayLink displayLinkWithTarget:[Timer_NsProxy proxyWithTarget:self] selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)dealloc {
    [_link invalidate];
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        NSLog(@"记录前次时间");
        return;
    }
    //次数
    _count++;
    //时间
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    NSString * fpsStatus = [NSString stringWithFormat:@"fps monitor is ...%f",fps];
    self.text = fpsStatus;
    NSLog(@"fps output:%@",fpsStatus);
}


@end
