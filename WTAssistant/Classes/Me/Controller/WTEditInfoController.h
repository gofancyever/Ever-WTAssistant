//
//  WTEditInfoController.h
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WTEditInfoControllerDelegate <NSObject>
@optional
-(void)editProfileViewControllerDidSave;
@end

@interface WTEditInfoController : UITableViewController
@property (nonatomic,strong) UITableViewCell *cell;
@property (nonatomic,weak) id <WTEditInfoControllerDelegate>delegate;
@end
