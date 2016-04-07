//
//  WTCellFrame.h
//  WTAssistant
//
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMPPMessageArchiving_Message_CoreDataObject;
@interface WTCellFrame : NSObject
//时间的frame
@property (nonatomic, assign,readonly)CGRect timeF;

//正文的frame
@property (nonatomic, assign,readonly)CGRect textViewF;

//图片
@property (nonatomic, assign,readonly)CGRect iconF;

//cell
@property (nonatomic, assign,readonly)CGFloat cellH;

//数据模型
@property (nonatomic, strong)XMPPMessageArchiving_Message_CoreDataObject *model;
@end
