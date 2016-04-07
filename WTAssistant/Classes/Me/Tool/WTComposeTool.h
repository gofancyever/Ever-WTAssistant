//
//  WTComposeTool.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WTcomposeToolResultSuccess,
    WTcomposeToolResultFailed
}WTcomposeToolResult;
@interface WTComposeTool : NSObject
+(void)composeLost:(NSString *)content image:(UIImage *)ContentImage result:(void (^)(WTcomposeToolResult result))result;
+(NSArray *)getComposeInfo;
@end
