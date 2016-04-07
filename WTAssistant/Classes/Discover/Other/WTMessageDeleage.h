//
//  WTMessageDeleage.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTMessageDeleage <NSObject>
@optional
-(void)WTMessageController:(UIViewController *)messageController pushViewController:(UIViewController *)newsContentController;

@end
