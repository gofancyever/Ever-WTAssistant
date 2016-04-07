//
//  WTDiscoverCell.h
//  WTAssistant
//
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTPublicCell.h"
@class WTDiscover;
@interface WTDiscoverCell : WTPublicCell
@property (nonatomic,strong) WTDiscover *discover;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
