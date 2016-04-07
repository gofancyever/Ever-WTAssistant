//
//  WTScheduleFrame.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTScheduleFrame.h"

@implementation WTScheduleFrame
-(void)setSchedule:(WTSchedule *)schedule{
    _schedule=schedule;
    
    CGFloat margin = 1;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    //courseOrder
    CGFloat courseOderWH=60;
    self.courseOrder=CGRectMake(0, margin, courseOderWH, courseOderWH);

    //status
    CGFloat statusX=courseOderWH;
    CGFloat statusY=margin;
    CGFloat statusW=courseOderWH;
    CGFloat statusH=courseOderWH;
    self.status=CGRectMake(statusX, statusY, statusW, statusH);

    //courseName
    CGFloat courseNameX=CGRectGetMaxX(self.status);
    CGFloat courseNameY=margin;
    CGFloat courseNameH=courseOderWH/2;
    CGFloat courseNameW=cellW-CGRectGetMaxX(self.status);
    self.courseName=CGRectMake(courseNameX, courseNameY, courseNameW, courseNameH);

    //location
    CGFloat coutseLocationX=courseNameX;
    CGFloat coutseLocationY=CGRectGetMaxY(self.courseName);
    CGFloat coutseLocationH=courseOderWH/2;
    CGFloat coutseLocationW=courseNameW;
    self.courseLocation=CGRectMake(coutseLocationX, coutseLocationY, coutseLocationW, coutseLocationH);
    
    //cell高度
    self.cellHeight = courseOderWH+margin;

}
@end
