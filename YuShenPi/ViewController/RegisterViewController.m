//
//  RegisterViewController.m
//  CustomAPP
//
//  Created by xieguocheng on 14-9-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "RegisterViewController.h"
#import "UITextField+LabelAndImage.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    UIView *_baseView;
    UITextField *_accountTF;
    UITextField *_securityTF;
    UITextField *_pwdTF;
    UITextField *_rePwdTF;
    UITextField *_nickNameTF;
    
    UIButton *_sendCodeBtn;
    NSTimer *_timer;
    int  _waitSeconds;
    BOOL _isAlreadySlide;
    CGRect _baseViewDefaultFrame;
}
@end

@implementation RegisterViewController

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
    self.titleLabel.text = @"注册";
    [self addBackBtn];
    
    [self addSubViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSubViews
{
    _baseView = [[UIView alloc]initWithFrame:CGRectOffset(self.view.frame, 0, NAVBAR_HEIGHT)];
    [_baseView setBackgroundColor:UCBGCOLOR];
    [self.view insertSubview:_baseView atIndex:0];
    _baseViewDefaultFrame = _baseView.frame;
    
    const float textFontSize = 16.0;
    float TFWidth  = 300.0;
    float TFHeight = 40.0;
    float itemSpace = 5.0;
    
    float logoHeight = 60 ;
    UIImageView *iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-logoHeight)/2.0, 20, logoHeight, logoHeight)];
    [iconImgView setImage:[UIImage imageNamed:@"暂无数据@2x"]];
    [_baseView addSubview:iconImgView];
    logoHeight += 40;
    
    CGRect telRect = CGRectMake((SCREEN_WIDTH-TFWidth)/2.0, logoHeight, TFWidth, TFHeight);
    _accountTF = [[UITextField alloc]initWithFrame:telRect];
    [_accountTF setBackground:[UIImage imageNamed:@"red_login_account_bg@2x"]];
    [_accountTF setBackgroundColor:[UIColor clearColor]];
    _accountTF.placeholder = @"请输入手机号";
    _accountTF.font = [UIFont systemFontOfSize:textFontSize];
    _accountTF.delegate = self;
    [_accountTF setLeftSpace:40.0];
    [_accountTF setKeyboardType:UIKeyboardTypeNumberPad];
    _accountTF.tag = 101;
    [_baseView addSubview:_accountTF];
    
    float btnWidth = 100;
    float btnHeight = 30;
    _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendCodeBtn setFrame:CGRectMake(telRect.origin.x+TFWidth-btnWidth-itemSpace, telRect.origin.y+(_accountTF.frame.size.height-btnHeight)/2.0, btnWidth, btnHeight)];
    
    [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:textFontSize];
    [_sendCodeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_sendCodeBtn addTarget:self action:@selector(onGetVerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:_sendCodeBtn];
    
    CGRect secRect = CGRectOffset(telRect, 0, TFHeight+itemSpace*2);
    _securityTF = [[UITextField alloc]initWithFrame:secRect];
    [_securityTF setBackground:[UIImage imageNamed:@"red_reg_security_bg@2x"]];
    [_securityTF setBackgroundColor:[UIColor clearColor]];
    _securityTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _securityTF.placeholder = @"请输入验证码";
    _securityTF.font = [UIFont systemFontOfSize:textFontSize];
    _securityTF.delegate = self;
    [_securityTF setLeftSpace:40.0];
    [_securityTF setKeyboardType:UIKeyboardTypeNumberPad];
    _securityTF.tag = 102;
    [_baseView addSubview:_securityTF];
    
    CGRect pwdRect = CGRectOffset(secRect, 0, TFHeight+itemSpace*2);
    _pwdTF = [[UITextField alloc]initWithFrame:pwdRect];
    [_pwdTF setBackground:[UIImage imageNamed:@"red_login_pwd_bg@2x"]];
    _pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTF.secureTextEntry = YES;
    _pwdTF.placeholder = @"请输入4至6位密码";
    _pwdTF.font = [UIFont systemFontOfSize:textFontSize];
    [_pwdTF setLeftSpace:40.0];
    _pwdTF.delegate = self;
    _pwdTF.tag = 103;
    _pwdTF.returnKeyType = UIReturnKeyNext;
    [_baseView addSubview:_pwdTF];
    
    CGRect rePwdRect = CGRectOffset(pwdRect, 0, TFHeight+itemSpace*2);
    _rePwdTF = [[UITextField alloc]initWithFrame:rePwdRect];
    [_rePwdTF setBackground:[UIImage imageNamed:@"red_login_pwd_bg@2x"]];
    _rePwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _rePwdTF.secureTextEntry = YES;
    _rePwdTF.placeholder = @"请再次输入密码";
    _rePwdTF.font = [UIFont systemFontOfSize:textFontSize];
    [_rePwdTF setLeftSpace:40.0];
    _rePwdTF.delegate = self;
    _rePwdTF.tag = 104;
    _rePwdTF.returnKeyType = UIReturnKeyNext;
    [_baseView addSubview:_rePwdTF];
    
    CGRect nickNameRect = CGRectOffset(rePwdRect, 0, TFHeight+itemSpace*2);
    _nickNameTF = [[UITextField alloc]initWithFrame:nickNameRect];
    [_nickNameTF setBackground:[UIImage imageNamed:@"red_reg_nickName_bg@2x"]];
    _nickNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nickNameTF.placeholder = @"请输入昵称";
    _nickNameTF.font = [UIFont systemFontOfSize:textFontSize];
    [_nickNameTF setLeftSpace:40.0];
    _nickNameTF.delegate = self;
    _nickNameTF.tag = 105;
    _nickNameTF.returnKeyType = UIReturnKeyDone;
    [_baseView addSubview:_nickNameTF];
    
    //添加注册按钮
    CGRect registerRect = CGRectOffset(nickNameRect, 0, TFHeight+itemSpace*5);
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setFrame:registerRect];
    registerBtn.tag = 106;
    [registerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [registerBtn addTarget:self action:@selector(onRegisterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:registerBtn];
}
- (void)onGetVerBtnClick:(id)sender
{
    /*
    if ([XCommon isBlankString:_accountTF.text]) {
        [self.view makeToast:@"请输入手机号码"];
        return;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", K_PHONE];
    if(![pred evaluateWithObject:_accountTF.text]){  //是不是手机号格式
        [self.view makeToast:KInputRightTelNumber];
        return;
    }
    
    NSURL *baseURL = [NSURL URLWithString:Base_URL];
    
    NSMutableDictionary *pams = [[NSMutableDictionary alloc]initWithCapacity:2];
    [pams setObject:_accountTF.text forKey:@"phoneNumber"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    client.parameterEncoding  = AFFormURLParameterEncoding;
    [self hudShowWithLabel:@"正在发送验证码..."];
    [client postPath:@"getRegCode"
          parameters:pams
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self hudHidden];
                 NSError *error;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&error];
                 if (dic==nil) {  //json解析失败
                     [XCommon showAlertWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@",error]];
                 }else if (IS_NETREQUEST_SUCCESS([dic objectForKey:@"state"])) {
                     [self.view makeToast:[dic objectForKey:@"msg"]];
                     
                     [self startTimer];
                 }else{
                     [XCommon showAlertWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"]];
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [self netFailureWithError:error];
             }
     ];
}
- (void)onRegisterBtnClick:(id)sender
{
    
     if (![AFNetworkReachability checkNetworkConnectivity]) {
     [self.view makeToast:KNetwork_NotReachable];
     return;
     }
    
    if ([XCommon isNullString:_securityTF.text]) {
        [self.view makeToast:@"请输入验证码"];
        return;
    }
     
     if ([XCommon isNullString:_pwdTF.text]) {
     [self.view makeToast:@"请输入密码"];
     return;
     }else if([XCommon isNullString:_rePwdTF.text]){
     [self.view makeToast:@"请再次输入密码"];
     return;
     }else if(![_pwdTF.text isEqualToString:_rePwdTF.text]){
     [self.view makeToast:@"两次输入的密码不一致，请重新输入"];
     return;
     }
     
     if (_pwdTF.text.length<6||_pwdTF.text.length>15) {
     [self.view makeToast:@"密码的长度不合法，需6-15位"];
     return;
     }
    
    if ([XCommon isNullString:_nickNameTF.text]) {
        [self.view makeToast:@"请输入昵称"];
        return;
    }
     
     NSURL *baseURL = [NSURL URLWithString:Base_URL];
     NSMutableDictionary *pams = [[NSMutableDictionary alloc]initWithCapacity:2];
     [pams setObject:_accountTF.text forKey:@"phoneNumber"];
     [pams setObject:[XCommon md5:_pwdTF.text] forKey:@"password"];
     [pams setObject:_nickNameTF.text forKey:@"nickname"];
    [pams setObject:_securityTF.text forKey:@"authCode"];
     
     AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
     [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    client.parameterEncoding  = AFFormURLParameterEncoding;
     [self hudShowWithLabel:@"正在注册..."];
     [client postPath:@"register"
           parameters:pams
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self hudHidden];
             NSError *error;
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&error];
             if (dic==nil) {  //json解析失败
             [XCommon showAlertWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@",error]];
             }else if (IS_NETREQUEST_SUCCESS([dic objectForKey:@"state"])) {
                 [self.view makeToast:@"注册成功"];
             
                 [XCommon UserDefaultSetValue:_accountTF.text forKey:USERNAME];
                 [XCommon UserDefaultSetValue:_pwdTF.text forKey:PASSWORD];
                 [XCommon UserDefaultSetValue:@"1" forKey:ISLOGINKEY];

                 [self performSelector:@selector(retunToHomepage) withObject:nil afterDelay:1.0];
             }else{
                 [XCommon showAlertWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"]];
            }
            }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [self netFailureWithError:error];
         }
     ];
    */
}

- (void)retunToHomepage
{
    [appDelegate.navController popToRootViewControllerAnimated:YES];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag >= 103) {
        
        if (!_isAlreadySlide) {
            [UIView animateWithDuration:0.5 animations:^{
                _baseView.frame = CGRectOffset(_baseViewDefaultFrame, 0, -180);
            } completion:^(BOOL finished) {
                _isAlreadySlide = YES;
            }];
        }
    }else{
        if (_isAlreadySlide) {
            [UIView animateWithDuration:0.5 animations:^{
                _baseView.frame = CGRectOffset(_baseViewDefaultFrame, 0, 0);
            } completion:^(BOOL finished) {
                _isAlreadySlide = NO;
            }];
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    if (textField==_accountTF) {
        if (range.location>=11) {
            return NO;
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField==_pwdTF) {
        [_rePwdTF becomeFirstResponder];
        return NO;
    }else if(textField==_rePwdTF){
        [_nickNameTF becomeFirstResponder];
        return NO;
    }
    
    if (_isAlreadySlide) {
        [UIView animateWithDuration:0.5 animations:^{
            _baseView.frame = _baseViewDefaultFrame;
        } completion:^(BOOL finished) {
            _isAlreadySlide = NO;
        }];
    }
    
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_accountTF resignFirstResponder];
    [_securityTF resignFirstResponder];
	[_pwdTF resignFirstResponder];
    [_rePwdTF resignFirstResponder];
    [_nickNameTF resignFirstResponder];
    
    
    if (_isAlreadySlide) {
        [UIView animateWithDuration:0.5 animations:^{
            _baseView.frame = _baseViewDefaultFrame;
        } completion:^(BOOL finished) {
            _isAlreadySlide = NO;
        }];
    }
}


- (void)startTimer
{
    _waitSeconds = 60;
    if (_timer==nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendCodeTimer) userInfo:nil repeats:YES];
        [_timer fire];
        
        [_sendCodeBtn setBackgroundImage:[UIImage imageNamed:@"red_reg_security_waiting@2x"] forState:UIControlStateNormal];
        [_sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒",_waitSeconds] forState:UIControlStateNormal];
        [_sendCodeBtn setEnabled:NO];
    }
}
- (void)sendCodeTimer
{
    _waitSeconds--;
    if (_waitSeconds>0) {
        [_sendCodeBtn setEnabled:YES];
        [_sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒",_waitSeconds] forState:UIControlStateNormal];
        [_sendCodeBtn setEnabled:NO];
    }else{
        //可以重发验证码
        [_sendCodeBtn setEnabled:YES];
        [_sendCodeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendCodeBtn setBackgroundColor:[UIColor grayColor]];
        [_timer invalidate];
        _timer = nil;
    }
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
