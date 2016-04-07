//
//  WTMessageContentController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTMessageContentController.h"
#import "WTSchoolMsgController.h"
#import "WTMessageController.h"
#import "WTMessageNews.h"
#import "WTWebNewsViewController.h"

typedef  void (^changeBtnEnabled)();

@interface WTMessageContentController ()<WTMessageDeleage>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) WTMessageController *messageVC;
@property (nonatomic,strong) WTSchoolMsgController *schoolMsgVC;
@property (nonatomic,copy) changeBtnEnabled block;

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end

@implementation WTMessageContentController
-(WTMessageController *)messageVC{
    if (_messageVC==nil) {
        _messageVC=[[WTMessageController alloc] init];
         _messageVC.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _messageVC.delegate=self;
    }
    return _messageVC;
}
-(WTSchoolMsgController *)schoolMsgVC{
    if (_schoolMsgVC==nil) {
        _schoolMsgVC=[[WTSchoolMsgController alloc] init];
        _schoolMsgVC.view.frame=CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        _schoolMsgVC.delegate=self;
    }
    return _schoolMsgVC;
}

static int indexPage=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化scrollview
    [self setupScrollView];
//    初始化topview
    [self setupTopView];
    
    
    //接受图片轮播的通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WTScrollViewDidClickModel:) name:@"contentViewClick:" object:nil];

  }


-(void)setupTopView{
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
    topView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    //年级通知
    UIButton *gradeMsgBtn=[self buttonWithTitle:@"年级通知"];
    gradeMsgBtn.frame=CGRectMake(0, 0, self.view.frame.size.width*0.5, 22);
    [topView addSubview:gradeMsgBtn];
    //校园新闻
    UIButton *schoolMsgBtn=[self buttonWithTitle:@"校园新闻"];
    schoolMsgBtn.frame=CGRectMake(self.view.frame.size.width*0.5, 0, self.view.frame.size.width*0.5, 22);
    schoolMsgBtn.enabled=NO;
    [topView addSubview:schoolMsgBtn];
    self.block= ^{
        gradeMsgBtn.enabled=!gradeMsgBtn.enabled;
        schoolMsgBtn.enabled=!schoolMsgBtn.enabled;
    };
    [self.view addSubview:topView];


}
-(void)setupScrollView{
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.backgroundColor=[UIColor redColor];
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width*2, 0);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.messageVC.view];

}
-(UIButton *)buttonWithTitle:(NSString *)title{
    UIButton *btn=[[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    return btn;
}
#pragma mark - ScrollView的代理方法
// 滚动视图停下来，修改页面控件的小点（页数）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page =scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (page==indexPage) return;
    self.block();
    indexPage=page;
}
//开始左右牵引在加载schoolView
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.scrollView addSubview:self.schoolMsgVC.view];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 用contentOffset来计算当前的页码
    double pageCount = self.scrollView.contentOffset.x/self.scrollView.bounds.size.width*1.0;

    //当在第二页时移除不用的View
    if (pageCount==1) {
        [self.messageVC.view removeFromSuperview];
    }
    if (pageCount<1) {
        [self.scrollView addSubview:self.messageVC.view];
    }
    if (pageCount==0) {
        [self.schoolMsgVC.view removeFromSuperview];
    }
    
}


#pragma MARK-WTMessageDeleage
-(void)WTMessageController:(WTMessageController *)messageController pushViewController:(UIViewController *)newsContentController{
    [self.navigationController pushViewController:newsContentController animated:YES];
}

//图片轮播器 通知
-(void)WTScrollViewDidClickModel:(NSNotification*)noteInfo{
    WTMessageNews *messageNews = noteInfo.userInfo[@"model"];
    WTWebNewsViewController *newsContentController=[[WTWebNewsViewController alloc] init];
    newsContentController.url=messageNews.newsContent;
     [self.navigationController pushViewController:newsContentController animated:YES];
}
//销毁通知
-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
