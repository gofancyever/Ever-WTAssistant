//
//  WTDiscover.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTDiscover : NSObject
@property (nonatomic,strong) NSString *listIcon;
@property (nonatomic,strong) NSString *listName;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)discoverWithDict:(NSDictionary *)dict;
+(NSArray *)discover;
@end
