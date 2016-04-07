//
//  WTWeather.m
//  WTAssistant
//
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTWeather.h"

@implementation WTWeather
/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.temp forKey:@"temp"];
    [encoder encodeObject:self.l_tmp forKey:@"l_tmp"];
    [encoder encodeObject:self.h_tmp forKey:@"h_tmp"];
    [encoder encodeObject:self.weather forKey:@"weather"];
    [encoder encodeObject:self.WS forKey:@"WS"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.city = [decoder decodeObjectForKey:@"city"];
        self.temp = [decoder decodeObjectForKey:@"temp"];
        self.l_tmp = [decoder decodeObjectForKey:@"l_tmp"];
        self.h_tmp = [decoder decodeObjectForKey:@"h_tmp"];
        self.weather = [decoder decodeObjectForKey:@"weather"];
        self.WS = [decoder decodeObjectForKey:@"WS"];
    }
    return self;
}
@end
