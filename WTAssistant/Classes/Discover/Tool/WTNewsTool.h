//
//  WTNewsTool.h
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WTMessageNews;
@interface WTNewsTool : NSObject

/**
 *  返回年级所有新闻
 */
+ (NSMutableArray *)newsMessageArray;


/**
 *  返回年级轮播器新闻
 */
+ (NSArray *)newsMessageImageWheelArray:(int)count;

/**
 *  返回年级列表新闻
 */
+ (NSArray *)newsMessageTableArrayRestImageWheelCount:(int)count;


/**
 *  返回校园所有新闻
 */
+ (NSMutableArray *)newsSchoolMsgArray;


/**
 *  返回校园轮播器新闻
 */
+ (NSArray *)newsSchoolMsgImageWheelArray:(int)count;

/**
 *  返回校园列表新闻
 */
+ (NSArray *)newsSchoolMsgTableArrayRestImageWheelCount:(int)count;


/**
 *  获取并保存新闻
 */
+(void)getNews;
@end
