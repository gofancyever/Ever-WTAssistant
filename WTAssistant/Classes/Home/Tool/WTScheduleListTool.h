//
//  WTScheduleListTool.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WTScheduleMain;
@interface WTScheduleListTool : NSObject

/**
 *  返回所有课表信息
 */
+ (WTScheduleMain *)scheduleMain;


/**
 *  当前时间课表信息
 */
+(NSArray *)currentScheduleFrameArray;
/**
 *  获取并保存课表信息
 */
+(void)getScheduleMains;

@end
