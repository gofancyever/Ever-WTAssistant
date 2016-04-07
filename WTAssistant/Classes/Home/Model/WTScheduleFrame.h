//
//  WTScheduleFrame.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTSchedule;
@interface WTScheduleFrame : NSObject
@property (nonatomic,strong) WTSchedule *schedule;
/**
 *  状态
 */
@property (nonatomic,assign) CGRect status;

/**
 *  课程名称
 */
@property (nonatomic,assign) CGRect courseName;

/**
 *  教室
 */
@property (nonatomic,assign) CGRect courseLocation;
/**
 *  节数
 */
@property (nonatomic,assign) CGRect courseOrder;
/**
 *  cell高度
 */
@property (nonatomic,assign) CGFloat cellHeight;

@end
