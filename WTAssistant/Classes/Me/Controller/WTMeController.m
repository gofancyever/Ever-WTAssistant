//
//  WTTMeController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTMeController.h"
#import "UIImage+Tool.h"
#import "UINavigationBar+Awesome.h"
#import "MBProgressHUD+MJ.h"
#import "XMPPvCardTemp.h"
#import "WTLoginController.h"
@interface WTMeController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *logoutLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIView *headerContentView;
@property (nonatomic,strong) NSArray *profileGroups;
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (nonatomic,assign) BOOL messageAlert;
@end

@implementation WTMeController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImg"]]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}
- (void)viewDidLoad {
    if ([WTUserInfoTool sharedInstance].loginStatus) {
        self.logoutLabel.text=@"退出登陆";
    }else{
        self.logoutLabel.text=@"登陆";
    }
    [super viewDidLoad];
    //初始化headerView
    [self setupHeaderView];
    //初始化头像
    [self setupIconView];
    
}

#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (![WTUserInfoTool sharedInstance].loginStatus) {
            self.logoutLabel.text=@"退出登录";
            [tableView reloadData];
            WTLoginController *loginVC=[UIStoryboard storyboardWithName:@"Authorization" bundle:nil].instantiateInitialViewController;
            [self presentViewController:loginVC animated:YES completion:nil];
            
        }else{
           self.logoutLabel.text=@"登陆";
            [tableView reloadData];
            [self clickLogout];
        }
    }
}

//初始化headerView
-(void)setupHeaderView{
    self.headerView.image=[UIImage imageNamed:@"profile_bg"];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView.scrollEnabled=NO;

}
//初始头像
-(void)setupIconView{
    self.title=[WTUserInfoTool sharedInstance].user;
    XMPPvCardTemp *myCard = [WCXMPPTool sharedInstance].vCard.myvCardTemp;
    if (myCard.photo) {
        self.iconView.image=[UIImage imageWithData:myCard.photo border:3 borderColor:[UIColor whiteColor] ];
    }else{
        self.iconView.image=[UIImage imageWithName:@"icon" border:3 borderColor:[UIColor whiteColor]];
    }

}

#pragma mark-初始化方法
-(void)clickLogout{
    [[WCXMPPTool sharedInstance] xmppUserlogout];
    //发出登陆状态
    [WTUserInfoTool sharedInstance].loginStatus=NO;
    [[WTUserInfoTool sharedInstance] saveUserInfoToSanbox];
    [MBProgressHUD showError:@"退出登录" toView:self.view];
    self.title=@"请登录";

}
@end
