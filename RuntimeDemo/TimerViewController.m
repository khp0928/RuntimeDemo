//
//  TimerViewController.m
//  RuntimeDemo
//
//  Created by user on 2021/7/8.
//

#import "TimerViewController.h"
#import <dispatch/object.h>
#import "TimerProxy.h"
#import "Timer_NsProxy.h"
@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property(nonatomic,strong) NSTimer * timer;/**ins*/
@property(nonatomic,strong) CADisplayLink * displayLink;/**ins*/


@property(nonatomic,assign) int countNum;/**ins*/



@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    __weak typeof(self)wSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        wSelf.countNum ++;
//        NSLog(@"count is ...%d",wSelf.countNum);
//    }];
//    self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        wSelf.countNum ++;
//        NSLog(@"count is ...%d",wSelf.countNum);
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[Timer_NsProxy proxyWithTarget:self] selector:@selector(timerMethod) userInfo:nil repeats:YES];
 
    
    /***This method is the only way to
     remove a timer from an [NSRunLoop]object.
     The NSRunLoop object removes its strong reference to the timer,
     either just before the [invalidate] method returns or at some later point.
    停止timer、从runloop中移除。。。。
     */
//    [self.timer invalidate];
    
    
    /***
    vc 持有 timer
    timer 持有vc
    runloop 持有timer
     */
    
   
}

- (void)stopTimer{
    self.timer = nil;
    [self.timer invalidate];
}

 
- (IBAction)btn1Click:(UIButton *)sender  {
    [self.timer fire];
//    [self.timer invalidate];
//    self.timer = nil;
}


- (IBAction)btn2Click:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)timerMethod{
    self.countNum ++;
    NSLog(@"count is ...%d",self.countNum);
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"self.timer invalidate && self.timer = nil %s",__func__);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.timer invalidate];
//    self.timer = nil;
//    NSLog(@"%s",__func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
