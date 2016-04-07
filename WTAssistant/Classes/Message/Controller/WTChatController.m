//
//  WTChatController.m
//  WTAssistant
//
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTChatController.h"
#import "WTMessageCell.h"
#import "WTCellFrame.h"
@interface WTChatController()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottom;
@property (nonatomic,strong) NSMutableArray *cellFrameArray;


@end

@implementation WTChatController{
    NSFetchedResultsController *_resultVC;
}
-(NSMutableArray *)cellFrameArray{
    if (_cellFrameArray==nil) {
        _cellFrameArray=[[NSMutableArray alloc] init];
        for (XMPPMessageArchiving_Message_CoreDataObject *model in _resultVC.fetchedObjects) {
            WTCellFrame *cellFrame=[[WTCellFrame alloc] init];
            cellFrame.model=model;
            [_cellFrameArray addObject:cellFrame];
        }
    }
    return _cellFrameArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.delegate=self;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //cell 不可选中
    self.tableView.allowsSelection = NO;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //键盘通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradFrameDidChange) name:UIKeyboardDidChangeFrameNotification object:nil];
    //加载聊天数据
    [self loadMsg];
    [self scrollToTableBottom];
}
-(void)keyboradFrameChange:(NSNotification*)noti{
    //窗口高度
    CGFloat windowH=[UIScreen mainScreen].bounds.size.height;
    //键盘结束的Frame
    CGRect kEndFrame=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kEndY=kEndFrame.origin.y;
    self.inputViewBottom.constant=windowH-kEndY;
}
-(void)keyboradFrameDidChange{
//    键盘滚动
    [self scrollToTableBottom];
}
/**
 *  加载聊天数据
 */
-(void)loadMsg{
    NSManagedObjectContext *context=[WCXMPPTool sharedInstance].msgStorage.mainThreadManagedObjectContext;
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    //获取条件
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",[WTUserInfoTool sharedInstance].jid,self.friendJid.bare];
    
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors=@[sort];
    request.predicate=pre;
    //执行
    _resultVC=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _resultVC.delegate=self;
    NSError *error=nil;
    [_resultVC performFetch:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}
- (IBAction)btnSendClick:(id)sender {
    [self sendMsgWithText:self.textView.text];
    self.textView.text=nil;
    [self scrollToTableBottom];
}

- (IBAction)btnSeletImg:(id)sender {
}


#pragma  mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    return _resultVC.fetchedObjects.count;
    return self.cellFrameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WTMessageCell *cell=[WTMessageCell messageCellWithTableView:tableView];
    WTCellFrame *modelFrame=self.cellFrameArray[indexPath.row];
    cell.modelFrame=modelFrame;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
    return cellFrame.cellH;
}

#pragma  mark - NSFetchedResultsControllerDelegata

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    self.cellFrameArray=nil;
    [self.tableView reloadData];
    [self scrollToTableBottom];
}
#pragma mark -uitextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
    NSString *text=textView.text;
    if ([text rangeOfString:@"\n"].length!=0) {
        [self sendMsgWithText:text];
        textView.text=nil;
    }else{
        
    }
}
#pragma mark- 其他方法
/**
 *  发送信息
 */
-(void)sendMsgWithText:(NSString *)text{
    
    XMPPMessage *msg=[XMPPMessage messageWithType:@"chat" to:self.friendJid];
    [msg addBody:text];
    [[WCXMPPTool sharedInstance].xmppStream sendElement:msg];
}
/**
 *  滚动底部
 */
-(void)scrollToTableBottom{
    NSIndexPath *lastPath=[NSIndexPath indexPathForRow:_resultVC.fetchedObjects.count-1 inSection:0];
    if (lastPath.row<2)   return;
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
