//
//  WTLoseTool.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTLoseTool : NSObject
//获取lose 信息 并保存
+(void)getLoseStatus;
//返回模型数组
+(NSArray *)loseStatus;
@end
