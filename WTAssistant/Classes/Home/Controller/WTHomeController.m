//
//  WTTHomeController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTHomeController.h"
#import "WTScheduleFrame.h"
#import "WTCourseCell.h"


#import "WTWeather.h"
#import "WTWeatherView.h"
#import "WTWeatherTool.h"
#import "WTSchedule.h"
#import "MJRefresh.h"
#import "WTHomeList.h"
#import "WTHomeListCell.h"
#import "NSDate+WTExtension.h"
#import "WTScheduleListTool.h"
#import "MBProgressHUD+MJ.h"
#import "WTScheduleController.h"
#import "WTWebNewsViewController.h"
@interface WTHomeController ()
/**
 *  存放课表的数组
 */
@property (nonatomic,strong) NSArray *schedules;
@property (nonatomic,strong) NSArray *scheduleFrames;

@property (nonatomic,weak) WTWeatherView *weatherView;

/**
 *  homeList
 */
@property (nonatomic,strong) NSArray *HomeList;

@end

@implementation WTHomeController

-(NSArray *)scheduleFrames{
    if (_scheduleFrames==nil) {
        _scheduleFrames=[WTScheduleListTool currentScheduleFrameArray];    }
    return _scheduleFrames;
}
-(NSArray *)HomeList{
    if (_HomeList==nil) {
        _HomeList=[WTHomeList homeList];
    }
    return _HomeList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [WTScheduleListTool currentScheduleFrameArray];
    //初始化nav
    [self setupNav];
    //初始化tableView
    [self setupTableView];
//    加载天气
    [self setupWeather];
    //下拉刷新
    [self setupDownRefresh];
}
#pragma mark-初始化方法
//Nav
-(void)setupNav{
    self.navigationItem.title=@"武体助手";
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(HomeNavLeftBtnClick)];
    self.navigationItem.leftBarButtonItem=leftItem;
}
//tableView
-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor=[UIColor colorWithRed:226.0/255 green:226.0/255 blue:226.0/255 alpha:1];
}
//weather
-(void)setupWeather{
    [WTWeatherTool getWeather];
    WTWeatherView *weatherView=[WTWeatherView weatherView];
    weatherView.weather=[WTWeatherTool weather];
    self.weatherView=weatherView;
    self.tableView.tableHeaderView=weatherView;
    [self.tableView.tableHeaderView setNeedsLayout];
}
//下拉刷新
-(void)setupDownRefresh{
    // 1.添加刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadStatus)];
    
    // 2.进入刷新状态
    [self.tableView headerBeginRefreshing];
}


#pragma mark-其他方法
/**
 *  点击nav left btn
 */
-(void)HomeNavLeftBtnClick{
    
}
//下拉刷新
-(void)loadStatus{
    //刷新天气
    [self setupWeather];
    //刷新课表
    [WTScheduleListTool getScheduleMains];
    //刷新表格
    [self.tableView reloadData];
    //结束刷新
     [self.tableView headerEndRefreshing];
}

#pragma mark-UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {//第一组
        return self.scheduleFrames.count;
        
    }
    else{//第二组
        return self.HomeList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        WTCourseCell *cell=[WTCourseCell cellWithTableView:tableView];
        WTScheduleFrame *scheduleFrame=self.scheduleFrames[indexPath.row];
        cell.scheduleFrame=scheduleFrame;
        if ([NSDate isBetweenFromTime:scheduleFrame.schedule.startTime toHour:scheduleFrame.schedule.endTime]) {
            cell.selected=YES;
        }
        return cell;
    }
    else{
        NSInteger ID=indexPath.row;
        WTHomeListCell *cell=[WTHomeListCell cellWithTableView:tableView];
        WTHomeList *homelist=self.HomeList[indexPath.row];
        cell.homeList=homelist;
        cell.ID=ID;
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        WTScheduleFrame *frame = self.scheduleFrames[indexPath.row];
        return frame.cellHeight;
    }
    else{
        return 44;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        WTHomeListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        switch (cell.ID) {
            case WTHomeListCellTypeSchedule:{
                if ([WTUserInfoTool sharedInstance].loginStatus) {
                    WTScheduleController *scheduleVC=[[WTScheduleController alloc] init];
                    scheduleVC.title=cell.homeList.listName;
                    [self.navigationController pushViewController:scheduleVC animated:YES];
                }else{
                    [MBProgressHUD showError:@"请登录并设置学号" toView:self.view];
                }
            }
                break;
                
            case WTHomeListCellTypeSearch:{
                if ([WTUserInfoTool sharedInstance].loginStatus) {
#warning 这里在做是否保存学号判断
                    WTWebNewsViewController *searchVC=[[WTWebNewsViewController alloc] init];
                    searchVC.title=cell.homeList.listName;
                    searchVC.url=@"http://218.197.70.95/";
                    [self.navigationController pushViewController:searchVC animated:YES];
                }else {
                    [MBProgressHUD showError:@"请登录并设置学号" toView:self.view];
                }
            }
                break;
                
            case WTHomeListCellTypeClass:{
                UITableViewController *classVC=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
                classVC.title=cell.homeList.listName;
                [self.navigationController pushViewController:classVC animated:YES];
            }
                break;
                
            case WTHomeListCellTypeClassRoom:{
                UITableViewController *classRoomVC=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
                classRoomVC.title=cell.homeList.listName;
                [self.navigationController pushViewController:classRoomVC animated:YES];
            }
                break;
                
            case WTHomeListCellTypeEvaluate:{
                UITableViewController *evaluateVC=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
                evaluateVC.title=cell.homeList.listName;
                [self.navigationController pushViewController:evaluateVC animated:YES];
            }
                break;

            
            default:
                break;
        }
    }
}

@end
