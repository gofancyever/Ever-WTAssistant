//
//  WCXMPPTool.m
//  WeChat
//

//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "WCXMPPTool.h"
NSString *const NSLoginStatusChangeNotification=@"NSLoginStatusChangeNotification";
/*
 * 在AppDelegate实现登录
 
 1. 初始化XMPPStream
 2. 连接到服务器[传一个JID]
 3. 连接到服务成功后，再发送密码授权
 4. 授权成功后，发送"在线" 消息
 */
@interface WCXMPPTool ()<XMPPStreamDelegate>{
    
    XMPPResultBlock _resultBlock;
    //电子名片存储
    XMPPvCardCoreDataStorage *_vCardStorage;
    //头像
    XMPPvCardAvatarModule *_vCardAvatar;
    //自动连接模块
    XMPPReconnect *_reconnect;
    
    //聊天
    XMPPMessageArchiving *_msgArchiving;
    

    
}

// 1. 初始化XMPPStream
-(void)setupXMPPStream;


// 2.连接到服务器
-(void)connectToHost;

// 3.连接到服务成功后，再发送密码授权
-(void)sendPwdToHost;


// 4.授权成功后，发送"在线" 消息
-(void)sendOnlineToHost;
@end


@implementation WCXMPPTool


SingletonM



#pragma mark  -私有方法
/**
 *  通知登录的状态
 *
 *  @param resultType <#resultType description#>
 */
-(void)postNotification:(XMPPResultType)resultType{
    //将登陆状态放入字典
    NSDictionary *userInfo=@{@"loginStatus":@(resultType)};
    [[NSNotificationCenter defaultCenter] postNotificationName:NSLoginStatusChangeNotification object:nil userInfo:userInfo];
}
-(void)tearDownXmpp{
    //移除代理
    [_xmppStream removeDelegate:self];
    //停止模块
    [_reconnect deactivate];
    [_vCardAvatar deactivate];
    [_vCard deactivate];
    [_roster deactivate];
    [_msgArchiving deactivate];
    //断开连接
    [_xmppStream disconnect];

    //清空资源
    _reconnect=nil;
    _vCard=nil;
    _vCardStorage=nil;
    _vCardAvatar=nil;
    _xmppStream=nil;
    _roster=nil;
    _rosterStorge=nil;
    _msgArchiving=nil;
    _msgStorage=nil;
    
}


#pragma mark 初始化XMPPStream
-(void)setupXMPPStream{
    
    _xmppStream = [[XMPPStream alloc] init];
    //名片
    _vCardStorage=[XMPPvCardCoreDataStorage sharedInstance];
    _vCard=[[XMPPvCardTempModule alloc] initWithvCardStorage:_vCardStorage];
    [_vCard activate:_xmppStream];
    //头像
    _vCardAvatar = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_vCard];
    [_vCardAvatar activate:_xmppStream];
    //自动连接
    _reconnect=[[XMPPReconnect alloc] init];
    [_reconnect activate:_xmppStream];
    
    //花名册模块
    _rosterStorge=[[XMPPRosterCoreDataStorage alloc] init];
    _roster=[[XMPPRoster alloc] initWithRosterStorage:_rosterStorge];
    [_roster activate:_xmppStream];
    
    //聊天模块
    _msgStorage=[[XMPPMessageArchivingCoreDataStorage alloc] init];
    _msgArchiving=[[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_msgStorage];
    [_msgArchiving activate:_xmppStream];
    
    _xmppStream.enableBackgroundingOnSocket=YES;
    
    // 设置代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

#pragma mark 连接到服务器
-(void)connectToHost{
    NSLog(@"connectToHost-开始连接到服务器");

    //发送通知 正在连接
    [self postNotification:XMPPResultTypeConntecting];
    
    if (!_xmppStream) {
        [self setupXMPPStream];
    }
    
    
    // 设置登录用户JID
    // 从单例获取用户名
    NSString *user = nil;
    if (self.isRegisterOperation) {
        user=[WTUserInfoTool sharedInstance].registerUser;
    }
    else{
        user=[WTUserInfoTool sharedInstance].user;
    }
    
    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:@"Ever-Never.local" resource:@"iphone" ];
    _xmppStream.myJID = myJID;
    
    // 设置服务器域名
    _xmppStream.hostName = @"Ever-Never.local";//不仅可以是域名，还可是IP地址
    
    // 设置端口 如果服务器端口是5222，可以省略
    _xmppStream.hostPort = 5222;
    
    // 连接
    NSError *err = nil;
    if(![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&err]){
        NSLog(@"%@",err);
    }
    
}

#pragma mark -XMPPStream的代理
#pragma mark 与主机连接成功
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"与主机连接成功");
    
    if (self.isRegisterOperation) {//注册操作，发送注册的密码
        NSString *pwd = [WTUserInfoTool sharedInstance].registerPwd;
        [_xmppStream registerWithPassword:pwd error:nil];
    }else{//登录操作
//         主机连接成功后，发送密码进行授权
    [self sendPwdToHost];
    }
    
}


#pragma mark 授权成功
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功");
    
    [self sendOnlineToHost];
    
    // 回调控制器登录成功
    if(_resultBlock){
        _resultBlock(XMPPResultTypeLoginSuccess);
    }
    
    [self postNotification:XMPPResultTypeLoginSuccess];
}

#pragma mark  授权成功后，发送"在线" 消息
-(void)sendOnlineToHost{
    
    NSLog(@"发送 在线 消息");
    XMPPPresence *presence = [XMPPPresence presence];
    NSLog(@"%@",presence);
    
    [_xmppStream sendElement:presence];
    
    
}

#pragma mark 授权失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"授权失败 %@",error);
    [self postNotification:XMPPResultTypeLoginFailure];
    // 判断block有无值，再回调给登录控制器
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
}
#pragma mark  与主机断开连接
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    // 如果有错误，代表连接失败
    
    // 如果没有错误，表示正常的断开连接(人为断开连接)
    
    
    if(error && _resultBlock){
        _resultBlock(XMPPResultTypeNetErr);
        [self postNotification:XMPPResultTypeNetErr];
    }
    NSLog(@"与主机断开连接 %@",error);
    
}


#pragma mark 连接到服务成功后，再发送密码授权
-(void)sendPwdToHost{
    NSLog(@"发送密码授权");
    NSError *err = nil;
    
//     从单例里获取密码
        NSString *pwd = [WTUserInfoTool sharedInstance].pwd;
    
        [_xmppStream authenticateWithPassword:pwd error:&err];
    
    if (err) {
        NSLog(@"%@",err);
    }
}




#pragma mark 注册成功
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功");
    if(_resultBlock){
        _resultBlock(XMPPResultTypeRegisterSuccess);
    }
    
}

#pragma mark 注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    
    NSLog(@"注册失败 %@",error);
    if(_resultBlock){
        _resultBlock(XMPPResultTypeRegisterFailure);
    }
    
}
/**
 *  接收到服务器数据调用
 */
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
  
    //判断当前程序是否在前台发出本地通知

    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        NSLog(@"不在前台");
        //发出本地通知
        UILocalNotification *localNoti=[[UILocalNotification alloc] init];
        //设置内容
        localNoti.alertBody=message.body;
        //通知执行的时间
        localNoti.fireDate=[NSDate date];
        //声音
        localNoti.soundName=@"default";
        //执行
        [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
    }
}

#pragma mark -公共方法
/**
 *  注销
 */
-(void)xmppUserlogout{
    // 1." 发送 "离线" 消息"
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
    
    // 2. 与服务器断开连接
    [_xmppStream disconnect];

}

-(void)xmppUserLogin:(XMPPResultBlock)resultBlock{
    
    // 先把block存起来
    _resultBlock = resultBlock;

    // 如果以前连接过服务，要断开
    [_xmppStream disconnect];
    
    // 连接主机 成功后发送登录密码
    [self connectToHost];
}


-(void)xmppUserRegister:(XMPPResultBlock)resultBlock{
    // 先把block存起来
    _resultBlock = resultBlock;
    
    // 如果以前连接过服务，要断开
    [_xmppStream disconnect];
    
    // 连接主机 成功后发送注册密码
    [self connectToHost];
}
-(void)dealloc{
    [self tearDownXmpp];
}
@end
