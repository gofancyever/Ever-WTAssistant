//
//  WTLoginController.h
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//
@class WTLoginController;
@protocol WTLoginControllerDelegate <NSObject>
@optional
-(void)loginControllerLoginStatusChange:(WTLoginController *)loginController;

@end
#import <UIKit/UIKit.h>

@interface WTLoginController : UIViewController
@property (nonatomic,weak) id<WTLoginControllerDelegate> delegate;
@end
