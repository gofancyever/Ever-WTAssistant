//
//  WTNewsTool.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTNewsTool.h"
#import "WTMessageNews.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import <sqlite3.h>

#define WTNewsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"news.data"]


@implementation WTNewsTool

#pragma mark - 年级新闻
/**
 *  返回年级新闻
 */
+ (NSMutableArray *)newsMessageArray{
    NSArray *array=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"news.plist" ofType:nil]];
    NSArray *arrayNews = array[0][@"text"];
    NSMutableArray *messageNewsArr=[WTMessageNews mj_objectArrayWithKeyValuesArray:arrayNews];
    return messageNewsArr;
}

/**
 *  返回年级轮播新闻
 */
+ (NSArray *)newsMessageImageWheelArray:(int)count{
    NSArray *newsArray=[self newsMessageArray];
    NSArray *newses=[newsArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, count)]];
    return newses;
}

/**
 *  返回年级列表新闻
 */
+ (NSArray *)newsMessageTableArrayRestImageWheelCount:(int)count{
    NSArray *newsArray=[self newsMessageArray];
    NSArray *newses=[newsArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, newsArray.count-count)]];
    return newses;
}

#pragma mark - 校园新闻
/**
 *  返回校园新闻
 */
+ (NSMutableArray *)newsSchoolMsgArray{
    NSArray *array=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"news.plist" ofType:nil]];
    NSArray *arrayNews = array[0][@"text"];
    NSMutableArray *messageNewsArr=[WTMessageNews mj_objectArrayWithKeyValuesArray:arrayNews];
    return messageNewsArr;

}


/**
 *  返回校园轮播器新闻
 */
+ (NSArray *)newsSchoolMsgImageWheelArray:(int)count{
    NSArray *newsArray=[self newsSchoolMsgArray];
    NSArray *newses=[newsArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, count)]];
    return newses;

}

/**
 *  返回校园列表新闻
 */
+ (NSArray *)newsSchoolMsgTableArrayRestImageWheelCount:(int)count{
    NSArray *newsArray=[self newsMessageArray];
    NSArray *newses=[newsArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, newsArray.count-count)]];
    return newses;

}

/**
 *  获取并保存新闻
 */
+(void)getNews{
    NSArray *array=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"news.plist" ofType:nil]];
    NSArray *arrayNews = array[0][@"text"];
    NSMutableArray *messageNewsArr=[WTMessageNews mj_objectArrayWithKeyValuesArray:arrayNews];
 
}

@end
