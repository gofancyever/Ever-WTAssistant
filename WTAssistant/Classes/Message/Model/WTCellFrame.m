//
//  WTCellFrame.m
//  WTAssistant
//
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTCellFrame.h"
#define bScreenWidth [[UIScreen mainScreen] bounds].size.width

#define bNormalH 44

#define bIconW 50

#define bIconH 50

#define bBtnFont [UIFont systemFontOfSize:15.0f]

#define bBtnPadding 20

@implementation WTCellFrame

- (void)setModel:(XMPPMessageArchiving_Message_CoreDataObject *)model{
    _model=model;
    CGFloat padding = 10;
    //比较时间
    NSDate *nowDate=[NSDate date];
    NSDate *msgDate=model.timestamp;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit =  NSCalendarUnitMinute;
    NSDateComponents *cmps = [calendar components:unit fromDate:msgDate toDate:nowDate options:0];
    
    if ( cmps.minute>5) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = bScreenWidth;
        CGFloat timeH = bNormalH;
        
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    
    
    
    //2.头像
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconW = bIconW;
    CGFloat iconH = bIconH;
    
    if ([model.outgoing boolValue]) {//自己发的
        
        iconX = bScreenWidth - iconW - padding;
        
    }else{//别人发的
        iconX = padding;
    }
    
    _iconF =  CGRectMake(iconX, iconY, iconW, iconH);
    //3.正文
    
    CGFloat textX;
    CGFloat textY = iconY+ padding;
    
    CGSize textMaxSize = CGSizeMake(bScreenWidth*0.7, MAXFLOAT);
    CGSize textRealSize = [model.body boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bBtnFont} context:nil].size;
    
    CGSize btnSize = CGSizeMake(textRealSize.width + 40, textRealSize.height + 40);
    
    if ([model.outgoing boolValue]) {
        textX = bScreenWidth - iconW - padding*2 - btnSize.width;
    }else{
        textX = padding + iconW;
    }
    
    _textViewF = (CGRect){{textX,textY},btnSize};
    
    //4.cell高度
    
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    CGFloat textMaxY = CGRectGetMaxY(_textViewF);
    
    _cellH = MAX(iconMaxY, textMaxY);
}
@end
