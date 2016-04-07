//
//  WTWeatherView.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTWeather;
@interface WTWeatherView : UIView
/**
 *  天气模型
 */
@property (nonatomic,strong) WTWeather *weather;
+(instancetype)weatherView;
@end
