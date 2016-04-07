//
//  WTStatusController.m
//  WTAssistant
//

//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTStatusController.h"
#import "WTSearchController.h"
#import "WTNavControllerViewController.h"
#import "WTChatController.h"
#import "WTFriendListViewCell.h"
@interface WTStatusController ()<NSFetchedResultsControllerDelegate>{
    /**
     *  抓取好友
     */
    NSFetchedResultsController *_resultControl;
}

@end

@implementation WTStatusController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self loadFriends];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addFriendClick)];
   
}
#pragma mark - 其他方法
-(void)addFriendClick{
    WTSearchController *searchController=[[WTSearchController alloc] init];
    WTNavControllerViewController *nav=[[WTNavControllerViewController alloc] initWithRootViewController:searchController];
    [self presentViewController:nav animated:YES completion:nil];
}
/**
 *  获取好友
 */
-(void)loadFriends{
    
    NSManagedObjectContext *context = [WCXMPPTool sharedInstance].rosterStorge.mainThreadManagedObjectContext;
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    //过滤
    NSString *jid=[WTUserInfoTool sharedInstance].jid;
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"streamBareJidStr=%@",jid];
    request.predicate=pre;
    //排序
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors=@[sort];
    _resultControl=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _resultControl.delegate=self;
    NSError *error=nil;
    [_resultControl performFetch:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultControl.fetchedObjects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WTFriendListViewCell *cell=[WTFriendListViewCell friendCellWithTableView:tableView];
    XMPPUserCoreDataStorageObject *friend=_resultControl.fetchedObjects[indexPath.row];
    cell.friend=friend;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XMPPUserCoreDataStorageObject *friend=_resultControl.fetchedObjects[indexPath.row];
    XMPPJID *friendJid=friend.jid;
    [self performSegueWithIdentifier:@"chatSegue" sender:friendJid];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        XMPPUserCoreDataStorageObject *friend=_resultControl.fetchedObjects[indexPath.row];
        [[WCXMPPTool sharedInstance].roster removeUser:friend.jid];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark - NSFetchedResultsControllerDelegate
/**
 *  当数据库内容改变时调用
 */
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
    NSLog(@"数据发生改变");
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id destVC=segue.destinationViewController;
    if ([destVC isKindOfClass:[WTChatController class]]) {
        WTChatController *chatVC=destVC;
        chatVC.friendJid=sender;
    }
}

@end
