//
//  WTSchedule.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTSchedule : NSObject


/**
 *  课程顺序
 */
@property (nonatomic,copy) NSString *courseOrder;
/**
 *  课程名称
 */
@property (nonatomic,copy) NSString *courseName;
/**
 *  教室
 */
@property (nonatomic,copy) NSString *courseLocation;
/**
 *  上课时间
 */
@property (nonatomic,copy) NSString *startTime;
/**
 *  下课时间
 */
@property (nonatomic,copy) NSString *endTime;


@end
