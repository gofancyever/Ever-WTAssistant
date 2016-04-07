//
//  WTComposeTool.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTComposeTool.h"
#import "AFNetworking.h"


//用户授权
NSString *const WTUserToken=nil;
NSString *const WTPostUrl=nil;
@implementation WTComposeTool
+(void)composeLost:(NSString *)content image:(UIImage *)ContentImage result:(void (^)(WTcomposeToolResult result))result{

    return;
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = WTUserToken;
    params[@"status"] = content;
    
    // 3.发送请求
    [mgr POST:WTPostUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        NSData *data = UIImageJPEGRepresentation(ContentImage, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
       
          __block  result=WTcomposeToolResultSuccess;
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            __block result=WTcomposeToolResultFailed;
    }];

}
/**
 *  获取发布过的信息
 *
 *  @return 返回一个模型数组
 */
+(NSArray *)getComposeInfo{
    return 0;
}
@end
