//
//  WTSchedule.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTSchedule.h"

@implementation WTSchedule


/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.courseOrder forKey:@"courseOrder"];
    [encoder encodeObject:self.courseName forKey:@"courseName"];
    [encoder encodeObject:self.courseLocation forKey:@"courseLocation"];
    [encoder encodeObject:self.startTime forKey:@"startTime"];
    [encoder encodeObject:self.endTime forKey:@"endTime"];

}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.courseOrder = [decoder decodeObjectForKey:@"courseOrder"];
        self.courseName = [decoder decodeObjectForKey:@"courseName"];
        self.courseLocation = [decoder decodeObjectForKey:@"courseLocation"];
        self.startTime = [decoder decodeObjectForKey:@"startTime"];
        self.endTime = [decoder decodeObjectForKey:@"endTime"];
    }
    return self;
}




@end
