//
//  NSDate+WTExtension.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "NSDate+WTExtension.h"

@implementation NSDate (WTExtension)

/**
 *  判断当前时间是否在指定范围内
 *
 *  @param fromTime  传入格式 HH:mm
 *  @param toTime   HH:mm
 */
+ (BOOL)isBetweenFromTime:(NSString *)fromTime toHour:(NSString *)toTime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    
    //当前时间
    NSDate *now = [NSDate date];
    NSString *nowStr = [fmt stringFromDate:now];
    now = [fmt dateFromString:nowStr];

    //fromTime
    NSDate *fromTimeDate = [fmt dateFromString:fromTime];
    //toTime
    NSDate *toTimeDate = [fmt dateFromString:toTime];
    
//    NSLog(@"formtime %@ totime %@ now%@",fromTimeDate,toTimeDate,now);
    if ([now compare:fromTimeDate]==NSOrderedDescending && [now compare:toTimeDate]==NSOrderedAscending)
    {
        return YES;
    }
    return NO;
}

@end
