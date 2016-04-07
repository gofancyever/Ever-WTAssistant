//
//  WTLoseTool.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTLoseTool.h"
#import "MJExtension.h"
#import "WTTest.h"
@implementation WTLoseTool
+(void)getLoseStatus{
    //获取数据
}
+(NSArray *)loseStatus{
    // 1.初始化数据
    NSArray *testArray = [WTTest mj_objectArrayWithFilename:@"1.plist"];
    return testArray;
}
@end
