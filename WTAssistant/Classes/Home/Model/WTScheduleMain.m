//
//  WTScheduleMain.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTScheduleMain.h"

@implementation WTScheduleMain

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.mon forKey:@"mon"];
    [encoder encodeObject:self.tue forKey:@"tue"];
    [encoder encodeObject:self.wed forKey:@"wed"];
    [encoder encodeObject:self.fri forKey:@"fri"];
    [encoder encodeObject:self.sat forKey:@"sat"];
    [encoder encodeObject:self.sun forKey:@"sun"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.mon = [decoder decodeObjectForKey:@"mon"];
        self.tue = [decoder decodeObjectForKey:@"tue"];
        self.wed = [decoder decodeObjectForKey:@"wed"];
        self.fri = [decoder decodeObjectForKey:@"fri"];
        self.sat = [decoder decodeObjectForKey:@"sat"];
        self.sun = [decoder decodeObjectForKey:@"sun"];
    }
    return self;
}
@end
