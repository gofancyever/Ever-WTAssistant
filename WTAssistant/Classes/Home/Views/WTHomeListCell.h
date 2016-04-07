//
//  WTHomeListCell.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//


#import "WTPublicCell.h"
#define WTCellTextColor ([UIColor colorWithRed:77.0/255 green:77.0/255 blue:77.0/255 alpha:1])
#define WTCellBackgroundColor ([UIColor whiteColor])
typedef enum {
    WTHomeListCellTypeSchedule=0,
    WTHomeListCellTypeSearch=1,
    WTHomeListCellTypeClass=2,
    WTHomeListCellTypeClassRoom=3,
    WTHomeListCellTypeEvaluate=4
}WTHomeListCellType;
@class WTHomeList;

@interface WTHomeListCell :WTPublicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) WTHomeList *homeList;
@property (nonatomic,assign) WTHomeListCellType ID;

@end
