//
//  WTWeatherTool.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTWeatherTool.h"
#import "WTWeather.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#define WTWeatherPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weather.data"]

@implementation WTWeatherTool
/**
*  存储天气信息
*/
+ (void)saveWeather:(WTWeather *)weather{
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:weather toFile:WTWeatherPath];
}

/**
 *  返回天气号信息
 */
+ (WTWeather *)weather{
    // 加载模型
    WTWeather *weather = [NSKeyedUnarchiver unarchiveObjectWithFile:WTWeatherPath];
    return weather;
}

+(void)getWeather{
    //获取天气数据
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [mgr.requestSerializer setValue:@"5e30aa1fb8d5a5c6538faf2a4590f7df" forHTTPHeaderField:@"apikey"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"citypinyin"] = @"wuhan";
    
    [mgr GET:@"http://apis.baidu.com/apistore/weatherservice/weather" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        WTWeather *weather=[[WTWeather alloc] init];
        weather = [WTWeather mj_objectWithKeyValues:responseObject[@"retData"]];
        [self saveWeather:weather];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
