//
//  LoginController.m
//  XMPPLoginDemo
//
//  Created by Kevin on 14/12/11.
//  Copyright (c) 2014年 HGG. All rights reserved.
//

#import "LoginController.h"
#import "AppDelegate.h"
#import "NSString+Helper.h"

@interface LoginController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *hostNameTextField;

- (IBAction)loginAndRegisterClick:(UIButton *)sender;

@end

@implementation LoginController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.userNameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kXMPPUserNameKey];
    self.hostNameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kXMPPHostNameKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - AppDelegate 的助手方法

- (AppDelegate *)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

#pragma mark - User Action

- (IBAction)loginAndRegisterClick:(UIButton *)sender
{
    // 1. 检查用户输入是否完整
    NSString *userName = [self.userNameTextField.text trimString];
    NSString *password = self.passwordTextField.text;
    NSString *hostName = [self.hostNameTextField.text trimString];
    
    if ([userName isEmptyString] || [password isEmptyString] || [hostName isEmptyString]){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录信息不完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
        return;
    }
    
    // 2. 将用户登录信息写入系统偏好
    [userName saveToNSDefaultsWithKey:kXMPPUserNameKey];
    [password saveToNSDefaultsWithKey:kXMPPPasswordKey];
    [hostName saveToNSDefaultsWithKey:kXMPPHostNameKey];
    
    // 3. 让AppDelegate开始连接
    NSString *actionName = nil;
    
    if (sender.tag == 1) {
        [self appDelegate].registerUser = YES;
        actionName = @"注册用户";
    } else {
        actionName = @"用户登录";
    }
    
    [[self appDelegate] connectWithCompletion:^{
        NSLog(@"%@成功！", actionName);
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLogonState object:nil];
    } failed:^{
        NSLog(@"%@失败！", actionName);
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.hostNameTextField becomeFirstResponder];
    } else {
        [self loginAndRegisterClick:nil];
    }
    
    return YES;
}

@end
