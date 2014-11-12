//
//  ForgetPswViewController.m
//  CustomAPP
//
//  Created by xieguocheng on 14-9-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "ForgetPswViewController.h"
#import "UITextField+LabelAndImage.h"

@interface ForgetPswViewController ()<UITextFieldDelegate>
{
    UIView *_baseView;
    BOOL _isAlreadySlide;  //已经滑动过.
    UITextField *_telTF;
    UITextField *_verifyTF;
    UITextField *_pwdTF;
    UITextField *_rePwdTF;
    UIButton *_sendCodeBtn;
    
    NSTimer *_timer;
    int  _waitSeconds;
}
@end

@implementation ForgetPswViewController

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
    
    self.titleLabel.text = @"找回密码";
    
    [self addBackBtn];
    
    [self addSubViews];
}

- (void)addSubViews
{
    _baseView = [[UIView alloc]initWithFrame:CGRectOffset(self.view.frame, 0, NAVBAR_HEIGHT)];
    [_baseView setBackgroundColor:UCBGCOLOR];
    [self.view insertSubview:_baseView atIndex:0];
    
    const float textFontSize = 16.0;
    const float btnFontSize = 18.0;
    float TFWidth  = 300.0;
    float TFHeight = 50.0;
    float itemSpace = 5.0;
    
    CGRect telRect = CGRectMake((SCREEN_WIDTH-TFWidth)/2.0, 20, TFWidth, TFHeight);
    _telTF = [[UITextField alloc]initWithFrame:telRect];
    [_telTF setBackground:[UIImage imageNamed:@"table_up@2x"]];
    [_telTF setBackgroundColor:[UIColor clearColor]];
    _telTF.placeholder = @"请输入手机号码";
    _telTF.font = [UIFont systemFontOfSize:textFontSize];
    _telTF.delegate = self;
    [_telTF setLeftSpace];
    [_telTF setKeyboardType:UIKeyboardTypeNumberPad];
    _telTF.tag = 101;
    [_baseView addSubview:_telTF];
    
    float btnWidth = 100;
    float btnHeight = 30;
    _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendCodeBtn setFrame:CGRectMake(telRect.origin.x+TFWidth-btnWidth-itemSpace, telRect.origin.y+(_telTF.frame.size.height-btnHeight)/2.0, btnWidth, btnHeight)];
    [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendCodeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:textFontSize];
    [_sendCodeBtn addTarget:self action:@selector(onGetVerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:_sendCodeBtn];
    
    CGRect lineRect = CGRectOffset(telRect, 0, TFHeight-1);
    lineRect.size.height = 1;
    UIImageView *lineImgView = [[UIImageView alloc]initWithFrame:lineRect];
    [lineImgView setImage:[UIImage imageNamed:@"table_line@2x"]];
    [_baseView addSubview:lineImgView];
    
    CGRect verifyRect = CGRectOffset(telRect, 0, TFHeight);
    _verifyTF = [[UITextField alloc]initWithFrame:verifyRect];
    [_verifyTF setBackground:[UIImage imageNamed:@"table_down@2x"]];
    _verifyTF.placeholder = @"请输入验证码";
    _verifyTF.font = [UIFont systemFontOfSize:textFontSize];
    [_verifyTF setLeftSpace];
    _verifyTF.delegate = self;
    [_verifyTF setKeyboardType:UIKeyboardTypeNumberPad];
    _verifyTF.tag = 102;
    [_baseView addSubview:_verifyTF];
    
    CGRect pswRect = CGRectOffset(verifyRect, 0, TFHeight);
    _pwdTF = [[UITextField alloc]initWithFrame:pswRect];
    [_pwdTF setBackground:[UIImage imageNamed:@"table_down@2x"]];
    _pwdTF.placeholder = @"请输入新密码(6-15位)";
    _pwdTF.font = [UIFont systemFontOfSize:textFontSize];
    [_pwdTF setLeftSpace];
    _pwdTF.delegate = self;
    _pwdTF.secureTextEntry = YES;
    _pwdTF.tag = 103;
    [_baseView addSubview:_pwdTF];
    
    CGRect rePswRect = CGRectOffset(pswRect, 0, TFHeight);
    _rePwdTF = [[UITextField alloc]initWithFrame:rePswRect];
    [_rePwdTF setBackground:[UIImage imageNamed:@"table_down@2x"]];
    _rePwdTF.placeholder = @"请再次输入新密码";
    _rePwdTF.font = [UIFont systemFontOfSize:textFontSize];
    [_rePwdTF setLeftSpace];
    _rePwdTF.delegate = self;
    _rePwdTF.secureTextEntry = YES;
    _rePwdTF.tag = 104;
    [_baseView addSubview:_rePwdTF];
    
    CGRect findbackRect = CGRectOffset(rePswRect, 0, TFHeight+itemSpace*5);
    UIButton *findbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [findbackBtn setFrame:findbackRect];
    [findbackBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [findbackBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [findbackBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    findbackBtn.titleLabel.font = [UIFont systemFontOfSize:btnFontSize];
    [findbackBtn addTarget:self action:@selector(onFindbackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:findbackBtn];
}

- (void)onGetVerBtnClick:(id)sender
{
    if ([XCommon isBlankString:_telTF.text]) {
        [self.view makeToast:@"请输入手机号码"];
        return;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", K_PHONE];
    if(![pred evaluateWithObject:_telTF.text]){  //是不是手机号格式
        [self.view makeToast:KInputRightTelNumber];
        return;
    }
    
    NSURL *baseURL = [NSURL URLWithString:Base_URL];
    
    NSMutableDictionary *pams = [[NSMutableDictionary alloc]initWithCapacity:2];
    [pams setObject:_telTF.text forKey:@"phoneNumber"];
    
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

- (void)onFindbackBtnClick:(id)sender
{
    if (![AFNetworkReachability checkNetworkConnectivity]) {
        [self.view makeToast:KNetwork_NotReachable];
        return;
    }
    
    
    if ([XCommon isNullString:_verifyTF.text]) {
        [self.view makeToast:@"请输入验证码"];
        return;
    }
    if ([XCommon isNullString:_pwdTF.text]) {
        [self.view makeToast:@"请输入新密码"];
        return;
    }else if([XCommon isNullString:_rePwdTF.text]){
        [self.view makeToast:@"请再次输入新密码"];
        return;
    }else if(![_pwdTF.text isEqualToString:_rePwdTF.text]){
        [self.view makeToast:@"两次输入的密码不一致，请重新输入"];
        return;
    }
    if (_pwdTF.text.length<6||_pwdTF.text.length>15) {
        [self.view makeToast:@"密码的长度不合法，需6-15位"];
        return;
    }
    
    NSURL *baseURL = [NSURL URLWithString:Base_URL];
    NSMutableDictionary *pams = [[NSMutableDictionary alloc]initWithCapacity:2];

    [pams setObject:_telTF.text forKey:@"phoneNumber"];
    [pams setObject:[XCommon md5:_pwdTF.text] forKey:@"newPassword"];
    [pams setObject:_verifyTF.text forKey:@"authCode"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    client.parameterEncoding = AFFormURLParameterEncoding;
    [self hudShowWithLabel:@"正在联网..."];
    [client postPath:@"findPassword"
          parameters:pams
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self hudHidden];
                 NSError *error;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingAllowFragments error:&error];
                 if (dic==nil) {  //json解析失败
                     [XCommon showAlertWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@",error]];
                 }else if (IS_NETREQUEST_SUCCESS([dic objectForKey:@"state"])) {
                     [self.view makeToast:[dic objectForKey:@"msg"]];
                     
                 }else{
                     [XCommon showAlertWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"]];
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [self netFailureWithError:error];
             }
     ];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 103||textField.tag == 104) {
        
        if (!_isAlreadySlide) {
            [UIView animateWithDuration:0.5 animations:^{
                _baseView.frame = CGRectOffset(_baseView.frame, 0, -40);
            } completion:^(BOOL finished) {
                _isAlreadySlide = YES;
            }];
        }
    }else{
        if (_isAlreadySlide) {
            [UIView animateWithDuration:0.5 animations:^{
                _baseView.frame = CGRectOffset(_baseView.frame, 0, 40);
            } completion:^(BOOL finished) {
                _isAlreadySlide = NO;
            }];
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    if (textField==_telTF) {
        if (range.location>=11) {
            return NO;
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (_isAlreadySlide) {
        [UIView animateWithDuration:0.5 animations:^{
            _baseView.frame = CGRectOffset(_baseView.frame, 0, 40);
        } completion:^(BOOL finished) {
            _isAlreadySlide = NO;
        }];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (_timer!=nil&&[_timer isValid]) {
        _waitSeconds = 0;
        [self sendCodeTimer];
    }
    
    [self touchesEnded:nil withEvent:nil];
    [super viewWillDisappear:animated];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_telTF resignFirstResponder];
    [_verifyTF resignFirstResponder];
	[_pwdTF resignFirstResponder];
    [_rePwdTF resignFirstResponder];
    
    if (_isAlreadySlide) {
        [UIView animateWithDuration:0.5 animations:^{
            _baseView.frame = CGRectOffset(_baseView.frame, 0, 40);
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


@end
