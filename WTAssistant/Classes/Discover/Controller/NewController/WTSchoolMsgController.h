//
//  WTSchoolMsgController.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTMessageDeleage.h"
@interface WTSchoolMsgController : UITableViewController
@property (nonatomic,weak) id<WTMessageDeleage> delegate;
@end
