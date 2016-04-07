//
//  WTChatController.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTCellFrame;
@interface WTMessageCell : UITableViewCell

+ (instancetype)messageCellWithTableView:(UITableView *)tableview;

//frame 的模型
@property (nonatomic, strong)WTCellFrame *modelFrame;

@end
