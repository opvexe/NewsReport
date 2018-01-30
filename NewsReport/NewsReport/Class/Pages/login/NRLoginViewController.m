//
//  NRLoginViewController.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NRLoginViewController.h"
#import "CPMessageEventButton.h"
#import "NRIMUserModel.h"

@interface NRLoginViewController ()<UITextFieldDelegate,CPMessageEventButtonDelegate>
@property(nonatomic,strong)UIScrollView *loginScrollView;
@property (strong, nonatomic)  UIView *loginBGView;
@property (strong, nonatomic)  UIButton *CloseBt;
@property (strong, nonatomic)  UILabel *TitleLabel;
@property (strong, nonatomic)  UIButton *weiBT;
@property (strong, nonatomic)  UIButton *QQBT;
@property (strong, nonatomic)  UIButton *weboBT;
@property (strong, nonatomic)  UIView *phoneBGView;
@property (strong, nonatomic)  UITextField *phoneTF;
@property (strong, nonatomic)  CPMessageEventButton *codeBT;
@property (strong, nonatomic)  UIView *lineView;
@property (strong, nonatomic)  UITextField *passwordTF;
@property (strong, nonatomic)  UIView *passwordLineView;
@property (strong, nonatomic)  UILabel *tipLabel;
@property (strong, nonatomic)  UIButton *loginBT;
@property(nonatomic,strong)UIButton *passwordBT;
@end

@implementation NRLoginViewController

-(void)dealloc{
    [NRNotificationCenter removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登陆";
    [self setupUI];
    [self configViews];
    [self eventHandling];
    [NRNotificationCenter addObserver:self selector:@selector(loginStatus:) name:NRIMMessageLoginStatusConfigurationNotificationCenterKey object:nil];
}

-(void)eventHandling{
    UITapGestureRecognizer *tipTaG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.tipLabel addGestureRecognizer:tipTaG];
    self.tipLabel.userInteractionEnabled =YES;
    self.passwordTF.delegate = self;
    self.phoneTF.delegate =  self;
    [self.phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginBT addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.weiBT addTarget:self action:@selector(weiXinAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.QQBT addTarget:self action:@selector(QQAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.weboBT addTarget:self action:@selector(weiBoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.CloseBt addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark < TextFieldDelegate >
-(void)textFieldDidChange:(UITextField *)textField{
    if ([textField isEqual:self.phoneTF]) {
        if (textField.text.length >11) {
            self.phoneTF.text = [textField.text substringToIndex:11];
        }else
        {
            self.phoneTF.text = textField.text;
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark < CPMessageEventButtonDelegate >
-(void)ClickedWithMessageButton:(CPMessageEventButton *)messageButton{
    NSLog(@"点击获取验证码");
}

/*!
 * 登录
 */
-(void)loginAction:(UIButton *)sender{
    WS(weakSelf)
    [NRBusinessNetworkTool PostLoginWithUserPassword:@"web" username:@"user45" CompleteSuccessfull:^(id responseObject) {
        NRIMUserModel *user = [NRIMUserModel mj_objectWithKeyValues:responseObject];
        WSSTRONG(strongSelf)
        [[NRUserTools defaultCenter]updateUserID:([NSString stringWithFormat:@"%ld",user.userId])];
        [strongSelf loginImpl:[[NRUserTools defaultCenter]getUserID] withToken:@"web"];
        
    } failure:^(id error) {
        NSLog(@"error:%@",error);
    }];
}

/*!
 * 登录IMSDK
 */
-(void)loginImpl:(NSString *)loginUserId withToken:(NSString *)loginPassword{
    int code = [[LocalUDPDataSender sharedInstance] sendLogin:loginUserId withToken:loginPassword];
    if (code == COMMON_CODE_OK) {
        NSLog(@"登陆请求已发出");
    }else{
        NSLog(@"登陆请求发送失败，错误码：%d", code);
    }
}

/*!
 * 登录状态通知
 */
- (void)loginStatus:(NSNotification *)notification{
    NSNumber *code = notification.userInfo[@"key"];
    if ([code intValue] == COMMON_CODE_OK) {
        NSLog(@"登录成功");
        [self switchRootController];
    }else{
        NSLog(@"登录失败");
    }
}

/*!
 * 微信登录
 */
-(void)weiXinAction:(UIButton *)sender{
    
}

/*!
 * QQ登录
 */
-(void)QQAction:(UIButton *)sender{
    
}
/*!
 * 微博登录
 */
-(void)weiBoAction:(UIButton *)sender{
    
}

-(void)Click:(UIButton *)sender{
    self.passwordTF.secureTextEntry  =!self.passwordTF.secureTextEntry;
}
/*!
 * 点击新闻编辑
 */
-(void)tap:(UITapGestureRecognizer *)tap{
    NSLog(@"用户协议");
}

/*!
 * 返回
 */
-(void)popBack{
    NSLog(@"返回");
}

-(void)configViews{
    
    [self.CloseBt setBackgroundImage:[UIImage imageNamed:@"NewClose"] forState:UIControlStateNormal];
    [self.CloseBt setBackgroundImage:[UIImage imageNamed:@"NewClose"] forState:UIControlStateHighlighted];
    [self.CloseBt setBackgroundImage:[UIImage imageNamed:@"NewClose"] forState:UIControlStateDisabled];
    [self.CloseBt setBackgroundImage:[UIImage imageNamed:@"NewClose"] forState:UIControlStateSelected];
    self.CloseBt.showsTouchWhenHighlighted = NO;
    
    [self.weboBT setBackgroundImage:[UIImage imageNamed:@"Newweibo"] forState:UIControlStateNormal];
    [self.weboBT setBackgroundImage:[UIImage imageNamed:@"Newweibo"] forState:UIControlStateHighlighted];
    [self.weboBT setBackgroundImage:[UIImage imageNamed:@"Newweibo"] forState:UIControlStateDisabled];
    [self.weboBT setBackgroundImage:[UIImage imageNamed:@"Newweibo"] forState:UIControlStateSelected];
    self.weboBT.showsTouchWhenHighlighted = NO;
    
    [self.QQBT setBackgroundImage:[UIImage imageNamed:@"Newqq"] forState:UIControlStateNormal];
    [self.QQBT setBackgroundImage:[UIImage imageNamed:@"Newqq"] forState:UIControlStateHighlighted];
    [self.QQBT setBackgroundImage:[UIImage imageNamed:@"Newqq"] forState:UIControlStateDisabled];
    [self.QQBT setBackgroundImage:[UIImage imageNamed:@"Newqq"] forState:UIControlStateSelected];
    self.QQBT.showsTouchWhenHighlighted = NO;
    
    [self.weiBT setBackgroundImage:[UIImage imageNamed:@"Newweixin"] forState:UIControlStateNormal];
    [self.weiBT setBackgroundImage:[UIImage imageNamed:@"Newweixin"] forState:UIControlStateHighlighted];
    [self.weiBT setBackgroundImage:[UIImage imageNamed:@"Newweixin"] forState:UIControlStateDisabled];
    [self.weiBT setBackgroundImage:[UIImage imageNamed:@"Newweixin"] forState:UIControlStateSelected];
    self.weiBT.showsTouchWhenHighlighted = NO;
    self.phoneTF.font  = FontHelFont(16);
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTF.textColor =UIColorFromRGB(0x323232);
    self.phoneTF.placeholder =@"请输入手机号";
    [self.phoneTF setValue:UIColorFromRGB(0x777777) forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.borderStyle =UITextBorderStyleNone;
    self.passwordTF.font  = FontHelFont(16);
    self.passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTF.textColor =UIColorFromRGB(0x323232);
    self.passwordTF.placeholder =@"请输入密码或验证码";
    [self.passwordTF setValue:UIColorFromRGB(0x777777) forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTF.secureTextEntry =YES;
    self.passwordTF.borderStyle =UITextBorderStyleNone;
    self.lineView.backgroundColor = UIColorFromRGB(0xe1e1e1);
    self.passwordLineView.backgroundColor = UIColorFromRGB(0xe1e1e1);
    
    [self.codeBT setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBT setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [self.codeBT setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.codeBT setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [self.codeBT .titleLabel setFont:FontHelFont(13)];
    [self.codeBT setTitleColor:UIColorFromRGB(0xff758c) forState:UIControlStateNormal];
    [self.codeBT setTitleColor:UIColorFromRGB(0xff758c) forState:UIControlStateHighlighted];
    [self.codeBT setTitleColor:UIColorFromRGB(0x909090) forState:UIControlStateSelected];
    self.codeBT.showsTouchWhenHighlighted=NO;
    self.codeBT.cornerRadius = 3;
    self.codeBT.countdownBeginNumber                      = 60;
    self.codeBT.delegate                                  = self;
    self.codeBT.clipsToBounds =YES;
    self.tipLabel.text =@"登录即同意《新闻编辑》用户协议";
    self.tipLabel.font =FontHelFont(13);
    self.tipLabel.textColor = UIColorFromRGB(0X909090);
    self.tipLabel.attributedText = [NSString getOtherColorString:@"用户协议" Color:UIColorFromRGB(0xff758c) withString:self.tipLabel.text];
    [self.loginBT setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBT setTitle:@"登录" forState:UIControlStateHighlighted];
    [self.loginBT setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.loginBT setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [self.loginBT .titleLabel setFont:FontHelFont(18)];
    [self.loginBT setTitleColor:UIColorFromRGB(0xff758c) forState:UIControlStateNormal];
    [self.loginBT setTitleColor:UIColorFromRGB(0xff758c) forState:UIControlStateHighlighted];
    self.loginBT.showsTouchWhenHighlighted=NO;
    self.TitleLabel.text  =@"新闻编辑";
    [self.phoneTF becomeFirstResponder];
    [self.passwordBT setImage:[UIImage imageNamed:@"password"] forState:UIControlStateNormal];
    [self.passwordBT setImage:[UIImage imageNamed:@"password"] forState:UIControlStateHighlighted];
    [self.passwordBT setImage:[UIImage imageNamed:@"password"] forState:UIControlStateDisabled];
    [self.passwordBT setImage:[UIImage imageNamed:@"password"] forState:UIControlStateSelected];
    self.passwordBT.showsTouchWhenHighlighted = NO;
    [self.passwordBT addTarget:self action:@selector(Click:) forControlEvents: UIControlEventTouchUpInside];
}

/*!
 * 初始化视图
 */
-(void)setupUI{
    
    self.loginScrollView = [UIScrollView  new];
    [self.view addSubview:self.loginScrollView];
    self.loginBGView = [UIView new];
    [self.loginScrollView addSubview:self.loginBGView];
    self.CloseBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBGView addSubview:self.CloseBt];
    self.weboBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBGView addSubview:self.weboBT];
    self.QQBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBGView addSubview:self.QQBT];
    self.weiBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBGView addSubview:self.weiBT];
    self.TitleLabel = [UILabel new];
    [self.loginBGView addSubview:self.TitleLabel];
    self.phoneBGView = [UIView new];
    [self.loginBGView addSubview:self.phoneBGView];
    self.codeBT = [CPMessageEventButton buttonWithType:UIButtonTypeCustom];
    [self.loginBGView addSubview:self.codeBT];
    self.phoneTF =[[UITextField alloc] init];
    [self.loginBGView addSubview:self.phoneTF];
    self.lineView =[UIView new];
    [self.loginBGView addSubview:self.lineView];
    self.passwordTF =[[UITextField alloc] init];
    [self.loginBGView addSubview:self.passwordTF];
    self.passwordLineView =[UIView new];
    [self.loginBGView addSubview:self.passwordLineView];
    self.loginBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBGView addSubview:self.loginBT];
    self.tipLabel = [UILabel new];
    [self.loginBGView addSubview:self.tipLabel];
    self.passwordBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBGView addSubview:self.passwordBT];
    [self.loginScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.loginBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.CloseBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(StatusBar_HEIGHT+NumberHeight(18));
        make.left.mas_equalTo(Number(30));
        make.size.mas_equalTo(CGSizeMake(Number(20), Number(20)));
    }];
    [self.weboBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.CloseBt.mas_bottom).offset(NumberHeight(30));
        make.right.mas_equalTo(self.loginBGView.mas_right).offset(Number(-32));
        make.size.mas_equalTo(CGSizeMake(Number(20), Number(20)));
    }];
    [self.QQBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.weboBT.mas_top);
        make.right.mas_equalTo(self.weboBT.mas_left).offset(Number(-36));
        make.size.mas_equalTo(self.weboBT);
    }];
    [self.weiBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.QQBT.mas_top);
        make.right.mas_equalTo(self.QQBT.mas_left).offset(Number(-36));
        make.size.mas_equalTo(CGSizeMake(Number(25), Number(20)));
    }];
    [self.TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.CloseBt.mas_bottom).offset(NumberHeight(30));
        make.left.mas_equalTo(self.CloseBt);
        make.height.mas_equalTo(NumberHeight(20));
        make.right.mas_equalTo(self.weiBT.mas_left);
    }];
    [self.phoneBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.TitleLabel.mas_bottom).offset(NumberHeight(63));
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(NumberHeight(100));
    }];
    [self.codeBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.TitleLabel.mas_bottom).offset(NumberHeight(74));
        make.right.mas_equalTo(self.weboBT.mas_right);
        make.size.mas_equalTo(CGSizeMake(Number(80), NumberHeight(20)));
    }];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.TitleLabel.mas_bottom).offset(NumberHeight(63));
        make.right.mas_equalTo(self.codeBT.mas_left);
        make.left.mas_equalTo(self.TitleLabel.mas_left);
        make.height.mas_equalTo(NumberHeight(44));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTF.mas_bottom).offset(NumberHeight(1));
        make.right.mas_equalTo(self.codeBT.mas_right);
        make.left.mas_equalTo(self.phoneTF.mas_left);
        make.height.mas_equalTo(NumberHeight(0.5));
    }];
    [self.passwordBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(NumberHeight(20));
        make.right.mas_equalTo(self.codeBT.mas_right);
        make.size.mas_equalTo(CGSizeMake(Number(22), Number(22)));
    }];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(NumberHeight(10));
        make.right.mas_equalTo(self.passwordBT.mas_left);
        make.left.mas_equalTo(self.lineView.mas_left);
        make.height.mas_equalTo(NumberHeight(44));
    }];
    
    [self.passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(NumberHeight(1));
        make.right.mas_equalTo(self.passwordBT.mas_right);
        make.left.mas_equalTo(self.passwordTF.mas_left);
        make.height.mas_equalTo(NumberHeight(0.5));
    }];
    [self.loginBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordLineView.mas_bottom).offset(NumberHeight(140));
        make.right.mas_equalTo(self.weboBT.mas_right);
        make.size.mas_equalTo(CGSizeMake(Number(80), Number(30)));
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordLineView.mas_bottom).offset(NumberHeight(150));
        make.right.mas_equalTo(self.loginBT.mas_left);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self.passwordLineView.mas_left);
    }];
}


@end

