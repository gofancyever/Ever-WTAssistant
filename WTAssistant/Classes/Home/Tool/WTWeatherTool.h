//
//  WTWeatherTool.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WTWeather;
@interface WTWeatherTool : NSObject
/**
 * 保存天气信息
 */
+ (void)saveWeather:(WTWeather *)weather;

/**
 *  返回天气信息
 */
+ (WTWeather *)weather;
/**
 *  获取并保存天气数据
 */
+(void)getWeather;
@end
