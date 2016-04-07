//
//  WTWeather.h
//  WTAssistant
//
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTWeather : NSObject
/**
 *  城市
 */
@property (nonatomic,copy) NSString *city;

/**
 *  当前天气
 */
@property (nonatomic,copy) NSString *weather;
/**
 *  气温
 */
@property (nonatomic,copy) NSString *temp;
/**
 *  最低气温
 */
@property (nonatomic,copy) NSString *l_tmp;
/**
 *  最高气温
 */
@property (nonatomic,copy) NSString *h_tmp;
/**
 *  风力
 */
@property (nonatomic,copy) NSString *WS;
@end
