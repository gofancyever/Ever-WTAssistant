//
//  AppDelegate.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "AppDelegate.h"
#import "WTTabBarControllerViewController.h"
#import "WTNewFeatureController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置状态栏样式 默认状态栏的样式由控制器决定
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    self.window=[[UIWindow alloc] init];
    self.window.frame=[UIScreen mainScreen].bounds;
    //从沙盒加载数据到单例中
       [[WTUserInfoTool sharedInstance] loadUserInfoFromSanbox];
    
    //判断是否第一次进入应用
    [self switchFirstApp];
    
    
//    [self switchRootViewController];
//    self.window.rootViewController=[[WTNewFeatureController alloc] init];

    [self.window makeKeyAndVisible];
    

    return YES;
}


-(void)switchLogin{
    //判断是否在登录过
    [[WTUserInfoTool sharedInstance] loadUserInfoFromSanbox];
    if ([WTUserInfoTool sharedInstance].loginStatus) {
        self.window.rootViewController=[[WTTabBarControllerViewController alloc] init];
        [[WCXMPPTool sharedInstance] xmppUserLogin:nil];
    }else{
        //授权界面
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Authorization" bundle:nil];
        self.window.rootViewController=storyboard.instantiateInitialViewController;
    }
}

//判断是否显示新特性
- (void)switchFirstApp
{
    //判断是不是第一次启动应用
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
      self.window.rootViewController=[[WTNewFeatureController alloc] init];
    }
    else
    {
        [self switchLogin];
        
    }
}

@end
