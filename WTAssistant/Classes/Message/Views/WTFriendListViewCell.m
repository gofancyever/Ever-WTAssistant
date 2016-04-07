//
//  WTFriendListViewCell.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTFriendListViewCell.h"
#import "XMPPUserCoreDataStorageObject.h"
@interface WTFriendListViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *unread;

@end

@implementation WTFriendListViewCell
+ (instancetype)friendCellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"friendCell";
    WTFriendListViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WTFriendListViewCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

-(void)setFriend:(XMPPUserCoreDataStorageObject *)friend{
    _friend=friend;
    self.icon.image=[UIImage imageNamed:@"icon"];
    self.nickName.text=friend.nickname;
    switch ([friend.sectionNum intValue]) {//好友状态
        case 0:
            self.unread.text = @"在线";
            break;
        case 1:
            self.unread.text = @"离开";
            break;
        case 2:
            self.unread.text = @"离线";
            break;
        default:
            break;
    }

}

@end
