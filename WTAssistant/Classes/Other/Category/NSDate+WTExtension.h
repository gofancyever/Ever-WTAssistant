//
//  NSDate+WTExtension.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WTExtension)
/**
 *  判断当前时间是否在指定范围内
 *
 *  @param fromTime  传入格式 HH:mm
 *  @param toTime   HH:mm
 */
+ (BOOL)isBetweenFromTime:(NSString *)fromTime toHour:(NSString *)toTime;

@end
