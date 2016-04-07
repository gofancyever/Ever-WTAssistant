//
//  WTTabBarControllerViewController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTTabBarControllerViewController.h"
#import "WTNavControllerViewController.h"
#import "WTHomeController.h"
#import "WTDiscoverController.h"
#import "WTStatusController.h"
#import "WTMeController.h"
#import "MBProgressHUD+MJ.h"
@interface WTTabBarControllerViewController ()<UITabBarControllerDelegate>
@end

@implementation WTTabBarControllerViewController

- (void)viewDidLoad {
    WTHomeController *homeVC=[[WTHomeController alloc] init];
    [self setupController:homeVC title:@"首页" tabImage:@"tabbar_home"];
    
     UIStoryboard *statusStoryBoard=[UIStoryboard storyboardWithName:@"Status" bundle:nil];
    WTStatusController *statusVC=statusStoryBoard.instantiateInitialViewController;

    [self setupController:statusVC title:@"消息" tabImage:@"tabbar_message_center"];
    
    WTDiscoverController *discoverVC=[[WTDiscoverController alloc] init];
    [self setupController:discoverVC title:@"发现" tabImage:@"tabbar_discover"];
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"profileInfo" bundle:nil];
    WTMeController *meVC=[storyBoard instantiateViewControllerWithIdentifier:@"me"];
    meVC.tabBarItem.title=@"我";
    [self setupController:meVC title:@"我" tabImage:@"tabbar_profile"];
    self.delegate=self;
    
}

-(void)setupController:(UIViewController *)childVC title:(NSString *)title tabImage:(NSString *)image{
    WTNavControllerViewController *navChild=[[WTNavControllerViewController alloc] initWithRootViewController:childVC];
//    childVC.tabBarItem.title=title;
    childVC.title=title;
    navChild.tabBarItem.image=[UIImage imageNamed:image];
    [self addChildViewController:navChild];
}
#pragma mark - UITabbarControllerDelegate
//判断消息控制器是否用
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[WTNavControllerViewController class]]) {
        WTNavControllerViewController *nav=(WTNavControllerViewController *)viewController;
        if ([nav.topViewController isKindOfClass:[WTStatusController class]]) {

            if ([WTUserInfoTool sharedInstance].loginStatus) {
                return YES;
            }else{
                [MBProgressHUD showError:@"请登录"];
                return NO;
            }
        }
    }

    return YES;
}

@end
