//
//  WTDiscover.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTDiscover.h"

@implementation WTDiscover
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)discoverWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)discover{
    NSArray *array=[self setupDiscoverListData];
    NSMutableArray *arrayM=[NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self discoverWithDict:dict]];
    }
    return arrayM;
}

+(NSArray *)setupDiscoverListData{
    NSMutableArray *homeList=[NSMutableArray array];
    NSDictionary *dict0=@{
                          @"listIcon":@"news_ustl",
                          @"listName":@"新闻公告"
                          };
    [homeList addObject:dict0];
    NSDictionary *dict1=@{
                          @"listIcon":@"classroom",
                          @"listName":@"行政办公"
                          };
    [homeList addObject:dict1];
    
    NSDictionary *dict2=@{
                          @"listIcon":@"lost_found",
                          @"listName":@"寻物公告"
                          };
    [homeList addObject:dict2];
    
       return homeList;
}

@end
