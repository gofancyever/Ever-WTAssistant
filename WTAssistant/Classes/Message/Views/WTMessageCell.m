//
//  WTChatController.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
// Created by apple on 14-8-22.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "WTMessageCell.h"
#import "XMPPMessageArchiving_Message_CoreDataObject.h"
#import "XMPPvCardTemp.h"
#import "WTCellFrame.h"
@interface WTMessageCell()
//时间
@property (nonatomic, weak)UILabel *time;
//正文
@property (nonatomic, weak)UIButton *textView;
//用户头像
@property (nonatomic, weak)UIImageView *icon;



@end

@implementation WTMessageCell

+ (instancetype)messageCellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"messageCell";
    WTMessageCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       //1.时间
        UILabel *time = [[UILabel alloc]init];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:time];
        self.time = time;
        
        //1.正文
        UIButton *textView = [[UIButton alloc]init];
        textView.titleLabel.font = [UIFont systemFontOfSize:12];
        textView.titleLabel.numberOfLines = 0;//自动换行
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //1.头像
        UIImageView *icon = [[UIImageView alloc]init];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

//设置内容Frame
//设置内容和frame
- (void)setModelFrame:(WTCellFrame *)modelFrame{
    _modelFrame = modelFrame;
    
    XMPPMessageArchiving_Message_CoreDataObject *model = modelFrame.model;
    //1.时间
    self.time.frame = modelFrame.timeF;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"EEE MMM dd HH:mm";
    self.time.text = [formatter stringFromDate:model.timestamp];
    
    //2.头像
    self.icon.frame = modelFrame.iconF;
    if ([model.outgoing boolValue]) {
        UIImage *icon=[UIImage imageWithData:[WCXMPPTool sharedInstance].vCard.myvCardTemp.photo];
        self.icon.image =icon;
    }else{
        XMPPvCardTemp *friendvCard = [[WCXMPPTool sharedInstance].vCard vCardTempForJID:model.bareJid shouldFetch:YES];
        UIImage *image=[UIImage imageWithData:friendvCard.photo];
        self.icon.image = image;
    }

    //3.正文
    self.textView.frame = modelFrame.textViewF;
    [self.textView setTitle:model.body forState:UIControlStateNormal];
    
    if ([model.outgoing boolValue]){
        [self.textView setBackgroundImage:[UIImage imageNamed:@"chat_send_nor"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage imageNamed:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
    }else{
        [self.textView setBackgroundImage:[UIImage imageNamed:@"chat_recive_nor"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage imageNamed:@"chat_recive_press_pic"] forState:UIControlStateNormal];
    }
}




@end
