//
//  WTRegisterController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "WTRegisterController.h"
#import "WTTabBarControllerViewController.h"
@interface WTRegisterController()
@property (weak, nonatomic) IBOutlet UITextField *registerUserName;
@property (weak, nonatomic) IBOutlet UITextField *registerPwd;
@property (weak, nonatomic) IBOutlet UITextField *registerEmail;
@property (weak, nonatomic) IBOutlet UITextField *registerEnterPwd;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation WTRegisterController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.registerBtn.enabled=NO;
    
    [self.registerUserName setTextFieldLeftView];
    [self.registerPwd setTextFieldLeftView];
    [self.registerEnterPwd setTextFieldLeftView];
    [self.registerEmail setTextFieldLeftView];
    
    
}
- (IBAction)registerBtnClick:(id)sender {
    if (self.registerPwd.text!=self.registerEnterPwd.text) {
        [MBProgressHUD showError:@"两次密码不一致" toView:self.view];
        return;
    }
    //保存用户注册数据
    [WTUserInfoTool sharedInstance].registerUser=self.registerUserName.text;
    [WTUserInfoTool sharedInstance].registerPwd=self.registerEnterPwd.text;
    //连接服务器
    [WCXMPPTool sharedInstance].registerOperation=YES;
    [[WCXMPPTool sharedInstance] xmppUserRegister:^(XMPPResultType type) {
        [self registerResult:type];
    }];
    
}
//登陆状态
-(void)registerResult:(XMPPResultType)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view];
        switch (type) {
            case XMPPResultTypeRegisterSuccess:
                [MBProgressHUD showSuccess:@"注册成功" toView:self.view];
                [self loginSuccess];
                break;
            case XMPPResultTypeRegisterFailure:
                [MBProgressHUD showError:@"注册失败" toView:self.view];
                break;
                
            default:
                break;
        }
        
    });
}
-(void)loginSuccess{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //跳转控制器
        [UIApplication sharedApplication].keyWindow.rootViewController=[[WTTabBarControllerViewController alloc] init];
    });
    //把注册成功的账号密码保存
    [WTUserInfoTool sharedInstance].user=self.registerUserName.text;
    [WTUserInfoTool sharedInstance].pwd=self.registerEnterPwd.text;
    //发出登陆状态
    [WTUserInfoTool sharedInstance].loginStatus=YES;
    //吧数据保存到沙盒
    [[WTUserInfoTool sharedInstance] saveUserInfoToSanbox];
    
}



@end
