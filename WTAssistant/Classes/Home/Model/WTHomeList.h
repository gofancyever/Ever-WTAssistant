//
//  WTHomeList.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTHomeList : NSObject

@property (nonatomic,copy) NSString *listName;
@property (nonatomic,copy) NSString *listIcon;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)homeListWithDict:(NSDictionary *)dict;
+(NSArray *)homeList;
@end
