//
//  WTLoginController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTLoginController.h"
#import "MBProgressHUD+MJ.h"
#import "WTTabBarControllerViewController.h"
#import <pop/pop.h>
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
    //设置btn圆角
    [self setupBtnRadius];
    //加载动画
    [self setupAnimation];
    }
/**
 *  用户登陆
 */
- (IBAction)btnLoginClick:(id)sender {
  
    POPSpringAnimation *iconAnimation=[POPSpringAnimation animation];
    iconAnimation.property=[POPAnimatableProperty propertyWithName:kPOPLayerSize];
    iconAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(80, 30)];
    iconAnimation.springSpeed = 0;
    [self.btnLoginType.layer pop_addAnimation:iconAnimation forKey:@"SizeW"];
    
    
    
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
               //移除动画
               [self.btnLoginType.layer pop_removeAnimationForKey:@"SizeW"];
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
/**加载动画*/
-(void)setupAnimation{
    POPSpringAnimation *iconAnimation=[POPSpringAnimation animation];
    iconAnimation.property=[POPAnimatableProperty propertyWithName:kPOPLayerScaleXY];
    iconAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
    iconAnimation.springSpeed = 0.f;
    [self.iconView.layer pop_addAnimation:iconAnimation forKey:@"ScaleXY"];
    
    
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationX];
    animation.fromValue = @(-300.0);
    animation.toValue = @0.0;
    animation.springBounciness = 10.0;
    animation.springSpeed = 12.0;
    [self.userTextField.layer pop_addAnimation:animation forKey:@"pop"];
    [self.passwordTextField.layer pop_addAnimation:animation forKey:@"pop"];

}
/**设置btn圆角*/
-(void)setupBtnRadius{
    
    self.btnLoginType.layer.borderWidth=3;
    self.btnLoginType.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor clearColor]);
    self.btnLoginType.layer.cornerRadius=5;
    self.btnLoginType.clipsToBounds=YES;

}

@end
