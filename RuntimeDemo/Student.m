//
//  Student.m
//  RTCSolution
//
//  Created by user on 2021/7/6.
//  Copyright © 2021 Aliyun. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void)say{
    NSLog(@"say:::%s",__func__);
}

+ (void)say{
    NSLog(@"sya:::%s",__func__);
}

+(void)studentMethod{
    NSLog(@"Class method...%s",__func__);
}
-(void)studentMethod{
    NSLog(@"instance... method...%s",__func__);
}
@end
