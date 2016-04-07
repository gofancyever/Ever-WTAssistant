//
//  WTHomeList.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTHomeList.h"

@implementation WTHomeList
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)homeListWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


+(NSArray *)homeList{
    NSArray *array=[self setupHomeListData];
    NSMutableArray *arrayM=[NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self homeListWithDict:dict]];
    }
    return arrayM;
}

+(NSArray *)setupHomeListData{
    NSMutableArray *homeList=[NSMutableArray array];
    NSDictionary *dict1=@{
                          @"listIcon":@"timetable",
                          @"listName":@"详细课表"
                          };
    [homeList addObject:dict1];
    
    NSDictionary *dict2=@{
                          @"listIcon":@"report",
                          @"listName":@"成绩查询"
                          };
    [homeList addObject:dict2];
    
    NSDictionary *dict3=@{
                          @"listIcon":@"mark",
                          @"listName":@"选课"
                          };
    [homeList addObject:dict3];
    
    NSDictionary *dict4=@{
                          @"listIcon":@"classroom",
                          @"listName":@"空教室"
                          };
    [homeList addObject:dict4];
    
    NSDictionary *dict5=@{
                          @"listIcon":@"evaluate",
                          @"listName":@"评教"
                          };
    [homeList addObject:dict5];
    return homeList;
}


@end
