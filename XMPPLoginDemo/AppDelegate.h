//
//  AppDelegate.h
//  XMPPLoginDemo
//
//  Created by Kevin on 14/12/11.
//  Copyright (c) 2014年 HGG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"

#define kXMPPUserNameKey    @"xmppUserName"
#define kXMPPPasswordKey    @"xmppPassword"
#define kXMPPHostNameKey    @"xmppHostName"

#define kNotificationUserLogonState @"NotificationUserLogon"

// 连接完成的Block
typedef void(^CompletionBlock)();

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#pragma mark - XMPP相关的属性和方法定义

/** 成功的块代码 */
@property (nonatomic, copy) CompletionBlock completionBlock;
/** 失败的块代码 */
@property (nonatomic, copy) CompletionBlock faildBlock;
/** 全局的XMPPStream，只读属性 */
@property (nonatomic, strong, readonly) XMPPStream *xmppStream;
/** 是否注册用户标示 */
@property (nonatomic, assign, getter=isRegisterUser) BOOL registerUser;
/** 用户是否登录成功 */
@property (nonatomic, assign, getter=isUserLogon) BOOL userLogon;

/**
 *  连接到服务器
 *
 *  注释：用户信息保存在系统偏好中
 *
 *  @param completion 连接正确的块代码
 *  @param faild      连接错误的块代码
 */
- (void)connectWithCompletion:(CompletionBlock)completion failed:(CompletionBlock)failed;

@end

