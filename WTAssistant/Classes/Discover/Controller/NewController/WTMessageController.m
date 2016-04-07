//
//  WTMessageController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTMessageController.h"
#import "WTNewsCell.h"
#import "WTNewsTool.h"
//#import "WTScrollImageView.h"
#import "WTWebNewsViewController.h"
#import "WTMessageNews.h"
#import "MJRefresh.h"


#import "WTImageWheelController.h"
@interface WTMessageController ()
@property (nonatomic,strong) NSArray *messageNewsArr;
//@property (nonatomic,weak) WTScrollImageView *scrollNews;
@end

@implementation WTMessageController
-(NSArray *)messageNewsArr{
    if (_messageNewsArr==nil) {
        _messageNewsArr=[WTNewsTool newsMessageTableArrayRestImageWheelCount:5];
    }
    return _messageNewsArr;
}
static NSString *const ID = @"newsCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    //图片轮播器
    [self setupImageWheel];
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0,self.tableView.tableHeaderView.height, 0);
    
    
    
    [self setupDownRefresh];
    // 2.进入刷新状态
    [self.tableView headerBeginRefreshing];

}
//下拉刷新
-(void)setupDownRefresh{
    // 1.添加刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadMessageStatus)];
    // 2.进入刷新状态
    [self.tableView headerBeginRefreshing];
    
  
}
-(void)loadMessageStatus{
    //获取新数据
    
    //刷新表格
    [self.tableView reloadData];

    //结束刷新
    [self.tableView headerEndRefreshing];
}
-(void)setupImageWheel{
    
    WTImageWheelController *imgWheelVC=[[WTImageWheelController alloc] initWithImageWheelType:WTImageWheelControllerImageWheelMessage];
    imgWheelVC.view.backgroundColor=[UIColor whiteColor];
    [self addChildViewController:imgWheelVC];
    self.tableView.tableHeaderView=imgWheelVC.view;

    
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageNewsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //让表哥从缓冲区查找可重用
    WTNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    //如果没有找到可重用标示符
    if (cell==nil) {
        //实例化cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WTNewsCell" owner:nil options:nil] lastObject];
    }
    
   
    cell.messageNews=self.messageNewsArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTMessageNews *messageNews = self.messageNewsArr[indexPath.row];
    if(messageNews) {
       
        WTWebNewsViewController *webNewsVC=[[WTWebNewsViewController alloc] init];
        webNewsVC.url=messageNews.newsContent;
        
        if ([self.delegate respondsToSelector:@selector(WTMessageController:pushViewController:)]) {
            [self.delegate WTMessageController:self pushViewController:webNewsVC];
        }
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


@end
