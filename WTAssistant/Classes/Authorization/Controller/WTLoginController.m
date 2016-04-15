//
//  WTLoginController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTLoginController.h"
#import "MBProgressHUD+MJ.h"
#import "WTTabBarControllerViewController.h"

@interface WTLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginType;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation WTLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置光标
    [self.userTextField setTextFieldLeftView];
    [self.passwordTextField setTextFieldLeftView];
    
    }
/**
 *  用户登陆
 */
- (IBAction)btnLoginClick:(id)sender {
    [self.view endEditing:YES];
//    存储用户名密码
    [WTUserInfoTool sharedInstance].user=self.userTextField.text;
    [WTUserInfoTool sharedInstance].pwd=self.passwordTextField.text;
    //登陆
    WCXMPPTool *tool=[WCXMPPTool sharedInstance] ;
    tool.registerOperation=NO;
    [tool xmppUserLogin:^(XMPPResultType type) {
        [MBProgressHUD showMessage:@"正在登陆..." toView:self.view];
        [self loginResult:type];
    }];
    
    
}


//游客登录
- (IBAction)btnVistorClick:(id)sender {
    //跳转控制器
    [UIApplication sharedApplication].keyWindow.rootViewController=[[WTTabBarControllerViewController alloc] init];
    [[WCXMPPTool sharedInstance] xmppUserlogout];
    //发出登陆状态
    [WTUserInfoTool sharedInstance].loginStatus=NO;
}
#pragma mark -扩展方法
//登陆状态
-(void)loginResult:(XMPPResultType)type{
   dispatch_async(dispatch_get_main_queue(), ^{
       [MBProgressHUD hideHUDForView:self.view];
       switch (type) {
           case XMPPResultTypeLoginSuccess:
               [MBProgressHUD showSuccess:@"登陆成功" toView:self.view];
               [self loginSuccess];
               break;
           case XMPPResultTypeLoginFailure:
               [MBProgressHUD showSuccess:@"登陆失败:证号或密码错误" toView:self.view];
               break;
               
           default:
               break;
       }

   });
}
-(void)loginSuccess{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //发出登陆状态
        [WTUserInfoTool sharedInstance].loginStatus=YES;
        //吧数据保存到沙盒
        [[WTUserInfoTool sharedInstance] saveUserInfoToSanbox];

      //切换控制器
        [UIApplication sharedApplication].keyWindow.rootViewController=[[WTTabBarControllerViewController alloc] init];
        
    });
//    [WTUserInfoTool sharedInstance].loginStatus=YES;
   
}


@end
