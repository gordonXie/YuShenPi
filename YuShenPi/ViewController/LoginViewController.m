//
//  LoginViewController.m
//  CustomAPP
//
//  Created by xieguocheng on 14-9-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPswViewController.h"
#import "RegisterViewController.h"
#import "UITextField+LabelAndImage.h"
#import "AFHTTPClient.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField *_accountTF;
    UITextField *_pwdTF;
    UIButton *_rememberPwdBtn;
    BOOL _isRememberPwd;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"登录";
    [self addBackBtn];
    
    if ([[XCommon UserDefaultGetValueFromKey:REMEMBERPS] isEqualToString:@"1"]) {
        _isRememberPwd = YES;
    }else{
        _isRememberPwd = NO;
    }
    
    [self addLoginView];
    [self addFuncLink];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLoginView
{
    const float textFontSize = 16.0;
    const float btnFontSize = 18.0;
    float TFWidth  = 300.0;
    float TFHeight = 40.0;
    float itemSpace = 5.0;
    
    float startH = NAVBAR_HEIGHT+20;
    
    float logoHeight = 60 ;
    UIImageView *iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-logoHeight)/2.0, startH, logoHeight, logoHeight)];
    [iconImgView setImage:[UIImage imageNamed:@"暂无数据@2x"]];
    [self.view addSubview:iconImgView];
    startH += logoHeight+20;

    
    CGRect telRect = CGRectMake((SCREEN_WIDTH-TFWidth)/2.0, startH, TFWidth, TFHeight);
    _accountTF = [[UITextField alloc]initWithFrame:telRect];
    [_accountTF setBackground:[UIImage imageNamed:@"red_login_account_bg@2x"]];
    [_accountTF setBackgroundColor:[UIColor clearColor]];
    _accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountTF.placeholder = @"请输入手机号码";
    _accountTF.font = [UIFont systemFontOfSize:textFontSize];
    _accountTF.delegate = self;
    [_accountTF setLeftSpace:40.0];
    if (![XCommon isNullString:[XCommon UserDefaultGetValueFromKey:USERNAME]]) {
        _accountTF.text = [XCommon UserDefaultGetValueFromKey:USERNAME];
    }
    [_accountTF setKeyboardType:UIKeyboardTypeNumberPad];
    _accountTF.tag = 101;
    [self.view addSubview:_accountTF];
    
    CGRect verifyRect = CGRectOffset(telRect, 0, TFHeight+itemSpace*2);
    _pwdTF = [[UITextField alloc]initWithFrame:verifyRect];
    [_pwdTF setBackground:[UIImage imageNamed:@"red_login_pwd_bg@2x"]];
    _pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTF.secureTextEntry = YES;
    if (_isRememberPwd&&[XCommon UserDefaultGetValueFromKey:PASSWORD]!=nil&&![XCommon isNullString:[XCommon UserDefaultGetValueFromKey:PASSWORD]]) {
        _pwdTF.text = [XCommon UserDefaultGetValueFromKey:PASSWORD];
    }else{
        _pwdTF.placeholder = @"请输入密码";
    }
    [_pwdTF setLeftSpace:40.0];
    _pwdTF.font = [UIFont systemFontOfSize:textFontSize];
    _pwdTF.delegate = self;
    _pwdTF.tag = 102;
    [self.view addSubview:_pwdTF];
    
    startH += TFHeight*2+itemSpace*3;
    _rememberPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rememberPwdBtn.frame = CGRectMake(verifyRect.origin.x, startH, 110, 30);
    if (_isRememberPwd) {
        [_rememberPwdBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        [_rememberPwdBtn setImage:[UIImage imageNamed:@"red_login_rmb_pwd_normal@2x"] forState:UIControlStateNormal];
    }
    [_rememberPwdBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 80)];
    [_rememberPwdBtn setTitle:@"记住密码" forState:UIControlStateNormal];
    _rememberPwdBtn.titleLabel.font = [UIFont systemFontOfSize:textFontSize];
    [_rememberPwdBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [_rememberPwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_rememberPwdBtn addTarget:self action:@selector(onRememberPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rememberPwdBtn];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(SCREEN_WIDTH-90-(SCREEN_WIDTH-TFWidth)/2.0, startH, 90, 30);
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:textFontSize];
    [forgetPwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(onForgetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
    
    //添加登录按钮
    CGRect loginRect = CGRectOffset(verifyRect, 0, TFHeight+itemSpace*7+44);
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setFrame:loginRect];
    loginBtn.tag = 103;
    [loginBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:btnFontSize];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [loginBtn addTarget:self action:@selector(onLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

//点击 记住密码按钮
- (void)onRememberPwdBtnClick:(id)sender
{
    _isRememberPwd = !_isRememberPwd;
    if (_isRememberPwd) {
        [_rememberPwdBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [XCommon UserDefaultSetValue:@"1" forKey:REMEMBERPS];
    }else{
        [_rememberPwdBtn setImage:[UIImage imageNamed:@"red_login_rmb_pwd_normal@2x"] forState:UIControlStateNormal];
        [XCommon UserDefaultSetValue:@"0" forKey:REMEMBERPS];
    }
}

- (void)onLoginBtnClick:(id)sender
{
    if (![AFNetworkReachability checkNetworkConnectivity]) {
        [self.view makeToast:KNetwork_NotReachable];
        return;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", K_PHONE];
    if ([XCommon isNullString:_accountTF.text]) {
        [self.view makeToast:@"请输入手机号码"];
        return;
    }else if(![pred evaluateWithObject:_accountTF.text]){  //是不是手机号格式
        [self.view makeToast:@"请输入正确的手机号码"];
        return;
    }
    if ([XCommon isNullString:_pwdTF.text]) {
        [self.view makeToast:@"请输入密码"];
        return;
    }
    [_accountTF resignFirstResponder];
	[_pwdTF resignFirstResponder];
    
    NSURL *baseURL = [NSURL URLWithString:Base_URL];
    NSMutableDictionary *pams = [[NSMutableDictionary alloc]initWithCapacity:3];
    [pams setObject:_accountTF.text forKey:@"phoneNumber"];
    [pams setObject:[XCommon md5:_pwdTF.text] forKey:@"password"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]]; //AFJSONRequestOperation
    client.parameterEncoding = AFFormURLParameterEncoding;
    [self hudShowWithLabel:@"正在登录..."];
    [client postPath:@"login"
          parameters:pams
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self hudHidden];
                 NSError *error;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&error];
                 if (dic==nil) {  //json解析失败
                     [XCommon showAlertWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@",error]];
                 }else if (IS_NETREQUEST_SUCCESS([dic objectForKey:@"state"])) {
                     [self.view makeToast:[dic objectForKey:@"msg"]];
                     
//                     [self writeUserDataToFile:dic];
                     
                     [XCommon UserDefaultSetValue:_accountTF.text forKey:USERNAME];
//                     [XCommon UserDefaultSetValue:[[dic objectForKey:@"userInfo"]objectForKey:@"nickname"] forKey:NIKENAME];
                     if (_isRememberPwd) {
                         [XCommon UserDefaultSetValue:_pwdTF.text forKey:PASSWORD];
                     }else{
                        [XCommon UserDefaultSetValue:@"" forKey:PASSWORD];
                     }

                     [XCommon UserDefaultSetValue:@"1" forKey:ISLOGINKEY];
                     [self backBtnClick:nil];
                 }else{
                     [XCommon showAlertWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"]];
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [self netFailureWithError:error];
             }
     ];
}

//添加功能链接
- (void)addFuncLink
{
    UIButton *loginBtn = (UIButton*) [self.view viewWithTag:103];
    CGRect loginRect = loginBtn.frame;
    
    CGRect regRect = CGRectOffset(loginRect,0, 60);
    UIButton *registBtn = [[UIButton alloc]initWithFrame:regRect];
    [registBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"red_regist_normal@2x"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"red_regist_sel@2x"] forState:UIControlStateHighlighted];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [registBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(onRegistBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}

- (void)onForgetPwdBtnClick:(id)sender
{
    ForgetPswViewController *forgetPswVC = [[ForgetPswViewController alloc]init];
    [appDelegate.navController pushViewController:forgetPswVC animated:YES];
}

- (void)onRegistBtnClick:(id)sender
{
    RegisterViewController *registVC = [[RegisterViewController alloc]init];
//    VerifyTelViewController *verifyVC = [[VerifyTelViewController alloc]init];
    [appDelegate.navController pushViewController:registVC animated:YES];
}


#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_accountTF resignFirstResponder];
	[_pwdTF resignFirstResponder];
}

- (void)writeUserDataToFile:(NSDictionary*)userDic
{
//    UserInfo *userInfo = [[UserInfo alloc]init];
//    userInfo.userId = [userDic objectForKey:@"dataID"];
//    userInfo.userName = [userDic objectForKey:@"name"];
//    userInfo.userSex = [userDic objectForKey:@"sex"];
//    userInfo.userPhone = [userDic objectForKey:@"phone"];
//    userInfo.userHeadImg = [userDic objectForKey:@"image"];
//    
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
//    [ud setObject:udObject forKey:USERINFO];
//    [ud synchronize];
}

@end
