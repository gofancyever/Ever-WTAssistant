//
//  WTSearchController.m
//  WTAssistant
//
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTSearchController.h"
#import "MBProgressHUD+MJ.h"
@interface WTSearchController()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) UITextField *textfield;

@end

@implementation WTSearchController
-(void)viewDidLoad{
    [super viewDidLoad];
    //初始化Nav
    [self setupNavBarItem];
    //初始化输入框
    [self setupTextField];
    [self setupTableView];
}
-(void)setupTableView{
    self.tableView=[[UITableView alloc] init];
    self.tableView.frame=CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
-(void)setupTextField{
    UITextField *textField=[[UITextField alloc] init];
    textField.frame=CGRectMake(0,0, self.view.frame.size.width, 44);
    [textField setTextFieldLeftView];
    textField.background=[UIImage imageNamed:@"operationbox_text"];
    textField.backgroundColor=[UIColor whiteColor];
    [textField addTarget:self action:@selector(textFieldContentChange) forControlEvents:UIControlEventEditingChanged];
    self.textfield=textField;
    self.textfield.delegate=self;
    [self.view addSubview:textField];
}
-(void)setupNavBarItem{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
}
/**
 *  输入框文字改变调用
 */
-(void)textFieldContentChange{
    NSString *user=self.textfield.text;
    if (user.length>0) {
        self.navigationItem.rightBarButtonItem.enabled=YES;
    }
}
/**
 *  取消按钮
 */
-(void)cancelClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  添加好友按钮
 */
-(void)addFriend{
    [self.view endEditing:YES];
    NSString *user=self.textfield.text;
    NSString *jidStr=[NSString stringWithFormat:@"%@@%@",user,domain];
    XMPPJID *friend=[XMPPJID jidWithString:jidStr];
    //判断添加自己
    if ([user isEqualToString:[WTUserInfoTool sharedInstance].user]) {
        [MBProgressHUD showError:@"不能添加自己" toView:self.view];
        return;
    }
    //判断好友是否存在
    if( [[WCXMPPTool sharedInstance].rosterStorge userExistsWithJID:friend xmppStream:[WCXMPPTool sharedInstance].xmppStream]){
        [MBProgressHUD showError:@"当前好友已经存在" toView:self.view];
        return;
    }
    [MBProgressHUD showSuccess:@"请求发送成功" toView:self.view];
    if (!user) return;
    [[WCXMPPTool sharedInstance].roster subscribePresenceToUser:friend];
}


#pragma mark -UITableView 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //可重用标示符
    static NSString *ID=@"Cell";
    //让表哥从缓冲区查找可重用
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    //如果没有找到可重用标示符
    if (cell==nil) {
        //实例化cell
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
#pragma mark -uitextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self addFriend];
    return YES;
}

@end
