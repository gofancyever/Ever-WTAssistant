//
//  WTCourseCell.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTPublicCell.h"

#define WTTextColor ([UIColor colorWithRed:77.0/255 green:77.0/255 blue:77.0/255 alpha:1])
#define WTTextBackgroundColor ([UIColor whiteColor])
#define WTSelectedColor ([UIColor colorWithRed:17.0/255 green:142.0/255 blue:255.0/255 alpha:1])

@class WTScheduleFrame;

@interface WTCourseCell : WTPublicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)  WTScheduleFrame *scheduleFrame;

@end
