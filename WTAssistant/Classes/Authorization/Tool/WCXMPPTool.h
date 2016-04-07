//
//  WCXMPPTool.h
//  WCXMPPTool
//
//  Copyright (c) 2014年 heima. All rights reserved.


#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "XMPPFramework.h"
extern NSString *const WCLoginStatusChangeNotification;
typedef enum {
    XMPPResultTypeLoginSuccess,//登录成功
    XMPPResultTypeLoginFailure,//登录失败
    XMPPResultTypeNetErr,//网络不给力
    XMPPResultTypeRegisterSuccess,//注册成功
    XMPPResultTypeRegisterFailure,//注册失败
    XMPPResultTypeConntecting//连接中
}XMPPResultType;

typedef void (^XMPPResultBlock)(XMPPResultType type);// XMPP请求结果的block

@interface WCXMPPTool : NSObject

SingletonH

/**
 *  注册标识 YES 注册 / NO 登录
 */
@property (nonatomic, assign,getter=isRegisterOperation) BOOL  registerOperation;//注册操作
//名片
@property (nonatomic,strong,readonly) XMPPvCardTempModule *vCard;
/**
 *  用户注销
 
 */
-(void)xmppUserlogout;
/**
 *  用户登录
 */
-(void)xmppUserLogin:(XMPPResultBlock)resultBlock;


/**
 *  用户注册
 */
-(void)xmppUserRegister:(XMPPResultBlock)resultBlock;
//名册存储
@property (nonatomic,strong,readonly) XMPPRosterCoreDataStorage *rosterStorge;

@property (nonatomic,strong,readonly) XMPPRoster *roster;

@property (nonatomic,strong,readonly) XMPPStream *xmppStream;

@property (nonatomic,strong,readonly) XMPPMessageArchivingCoreDataStorage *msgStorage;
@end
