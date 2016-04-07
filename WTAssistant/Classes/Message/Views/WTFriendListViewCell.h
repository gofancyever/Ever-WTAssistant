//
//  WTFriendListViewCell.h
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMPPUserCoreDataStorageObject;
@interface WTFriendListViewCell : UITableViewCell
@property (nonatomic,strong) XMPPUserCoreDataStorageObject *friend;
+ (instancetype)friendCellWithTableView:(UITableView *)tableview;

@end
