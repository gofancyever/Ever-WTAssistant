//
//  WTScheduleListTool.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTScheduleListTool.h"
#import "AFNetworking.h"
#import "WTUserInfoTool.h"
#import "MJExtension.h"
#import "WTSchedule.h"
#import "WTScheduleFrame.h"
#import "WTScheduleMain.h"



#define WTScheduleMainsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"scheduleDict.data"]



@implementation WTScheduleListTool


/**
 *  获取并保存课表数据
 */
+(void)getScheduleMains{
    
//    WTUserInfo *userInfo=[WTUserInfo userInfo];
    //获取课程表数据
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"grade"] = userInfo.grade;
//    params[@"college"] = userInfo.college;
//    params[@"marjor"] = userInfo.major;
    
    [mgr GET:@"http://apis.baidu.com/apistore/weatherservice/weather" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=responseObject;
        [self saveScheduleMain:dict];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
}

/**
 *  模型转化
 */
+ (NSArray *)scheduleFramesWithSchedule:(NSArray *)schedules{
    NSMutableArray *frames = [NSMutableArray array];
    for (WTSchedule *schedule in schedules) {
        WTScheduleFrame *f = [[WTScheduleFrame alloc] init];
        f.schedule = schedule;
        [frames addObject:f];
    }
    return frames;
}
/**
 *  存储课表信息为模型
 */
+ (void)saveScheduleMain:(NSDictionary *)scheduleMainDict{
    
    [WTScheduleMain mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"mon" : @"WTSchedule",
                 @"tue" : @"WTSchedule",
                 @"wed" : @"WTSchedule",
                 @"thurs" : @"WTSchedule",
                 @"fri" : @"WTSchedule",
                 @"sat" : @"WTSchedule",
                 @"sun" : @"WTSchedule",
                 };
    }];
    WTScheduleMain *result = [WTScheduleMain mj_objectWithKeyValues:scheduleMainDict];
    
    [NSKeyedArchiver archiveRootObject:result toFile:WTScheduleMainsPath];
}
/**
 *  返回课表信息
 */
+ (WTScheduleMain *)scheduleMain{

//    //// 加载模型
//    WTScheduleMain *scheduleMain = [NSKeyedUnarchiver unarchiveObjectWithFile:WTScheduleMainsPath];
//    return scheduleMain;
    
    
#warning 测试数据
    
    NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"schedule.plist" ofType:nil]];
    
    
    
    [WTScheduleMain mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"mon" : @"WTSchedule",
                 @"tue" : @"WTSchedule",
                 @"wed" : @"WTSchedule",
                 @"thurs" : @"WTSchedule",
                 @"fri" : @"WTSchedule",
                 @"sat" : @"WTSchedule",
                 @"sun" : @"WTSchedule",
                 };
    }];
    WTScheduleMain *result = [WTScheduleMain mj_objectWithKeyValues:dict];
    [self saveScheduleMain:dict];
    return result;
    

}

/**
 *  当前时间课表数据
 */
+(NSArray *)currentScheduleFrameArray{
    NSDate *nowDate=[NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitWeekday fromDate:nowDate];
    NSArray *scheduleArray = [self scheduleFramesWithWeek:nowCmps.weekday];
    return [self scheduleFramesWithSchedule:scheduleArray];
}

/**
  *返回当前schedule数组
 */
+(NSArray *)scheduleFramesWithWeek:(NSInteger)week{
    WTScheduleMain *main=[self scheduleMain];
    if(week==1)
    {
        return main.sun;
    }else if(week==2){
       return main.mon;
        
    }else if(week==3){
        return main.tue;
        
    }else if(week==4){
        return main.wed;
        
    }else if(week==5){
        return main.thurs;
        
    }else if(week==6){
        return main.fri;
        
    }else if(week==7){
        return main.sat;
        
    }
    else {
        return nil;
    }
}

@end
