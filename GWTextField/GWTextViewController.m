//
//  GWTextViewController.m
//  GWTextField
//
//  Created by genwei yang on 2017/12/18.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import "GWTextViewController.h"
#import "GWTransTextField.h"
#import "GWTextFieldModel.h"
#import "GWButton.h"


@interface GWTextViewController ()<GWSecurityCodeDelegate>
@property (nonatomic,readwrite,strong)GWTransTextField *txtUserName;
@property (nonatomic,readwrite,strong)GWTransTextField *txtPassword;
@property (nonatomic,readwrite,strong)GWTransTextField *txtWidthDraw;
@property (nonatomic,readwrite,strong)GWTransTextField *txtSecurityCode;
@property (nonatomic,readwrite,strong)GWButton *securityButton;
@end

@implementation GWTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:hexStrColor(@"#EE9572")];
    [self addSubView];
}

- (void)addSubView{
    
    [self.view addSubview:self.txtUserName];
    [self.view addSubview:self.txtPassword];
    [self.view addSubview:self.txtWidthDraw];
    [self.view addSubview:self.txtSecurityCode];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.txtUserName resignFirstResponder];
    [self.txtWidthDraw resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtSecurityCode resignFirstResponder];
}

#pragma mark 提现按钮点击事件
- (void)withDrawButtonAction:(UIButton *)button{
    self.txtWidthDraw.text = @"777";
}

#pragma mark GWSecurityCodeDelegate
- (void)sendSecurityCode{
    [self.securityButton securityCodeType:@"" userTelephone:@"" refresTime:60];
}

#pragma mark - getter and setter

#pragma mark 手机号输入框
- (GWTransTextField *)txtUserName{
    if(!_txtUserName){
        NSInteger buttonMargin = 20;
        CGFloat buttonHeight = 50;
        GWTextFieldModel *textFieldModel = [GWTextFieldModel new];
        textFieldModel.placeholder = @"请输入手机号";
        textFieldModel.titleViewContent = [UIImage imageNamed:@"Phone"];
        _txtUserName = [GWTransTextField createUnlineTextFieldWithFrame:(CGRect){buttonMargin,200,kSCREENWIDTH-buttonMargin*2,buttonHeight} textFieldModel:textFieldModel];
    }return _txtUserName;
}

#pragma mark 密码框
- (GWTransTextField *)txtPassword{
    if(!_txtPassword){
        NSInteger buttonMargin = 20;
        CGFloat buttonHeight = 40;
        GWTextFieldModel *model = [GWTextFieldModel new];
        model.titleViewContent = @"原密码:";
        model.placeholder = @"请输入密码";
        model.borderColor = [UIColor clearColor];
        model.borderWidth = 1;
        model.backgroundColor = [UIColor whiteColor];
        model.isPassword = YES;
        model.cornerRadius = 3;
        
        _txtPassword = [GWTransTextField createNormalTextFieldWithFrame:(CGRect){buttonMargin,marginTop(self.txtUserName)+5,kSCREENWIDTH-buttonMargin*2,buttonHeight} textFieldModel:model];
        
    }return _txtPassword;
}
#pragma mark 提现框
- (GWTransTextField *)txtWidthDraw{
    if(!_txtWidthDraw){
        NSInteger buttonMargin = 20;
        CGFloat buttonHeight = 40;
        GWTextFieldModel *model = [GWTextFieldModel new];
        model.titleViewContent = [UIImage imageNamed:@"money"];
        model.placeholder = @"最后可提现777元";
        model.borderColor = [UIColor clearColor];
        model.borderWidth = 1;
        model.backgroundColor = [UIColor whiteColor];
        model.cornerRadius = 3;
        
        UIButton *withDrawButton = [[UIButton alloc] initWithFrame:(CGRect){0,0,100,40}];
        [withDrawButton setTitle:@"全部提现" forState:UIControlStateNormal];
        [withDrawButton setTitleColor:hexStrColor(@"#4A4A4A") forState:UIControlStateNormal];
        [[withDrawButton titleLabel] setFont:[UIFont systemFontOfSize:12]];
        [withDrawButton addTarget:self action:@selector(withDrawButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        model.rightViewContent = withDrawButton;
        
        _txtWidthDraw = [GWTransTextField createNormalTextFieldWithFrame:(CGRect){buttonMargin,marginTop(self.txtPassword)+5,kSCREENWIDTH-buttonMargin*2,buttonHeight} textFieldModel:model];
    }return _txtWidthDraw;
}

#pragma mark 验证码输入框
- (GWTransTextField *)txtSecurityCode{
    if(!_txtSecurityCode){
        NSInteger buttonMargin = 20;
        CGFloat buttonHeight = 40;
        GWTextFieldModel *model = [GWTextFieldModel new];
        model.titleViewContent = @"验证码: ";
        model.placeholder = @"请输入验证码";
        model.borderColor = [UIColor clearColor];
        model.borderWidth = 1;
        model.backgroundColor = [UIColor whiteColor];
        model.isPassword = NO;
        model.cornerRadius = 3;
        
        model.rightViewContent = self.securityButton;
        _txtSecurityCode = [GWTransTextField createNormalTextFieldWithFrame:(CGRect){buttonMargin,marginTop(self.txtWidthDraw)+5,kSCREENWIDTH-buttonMargin*2,buttonHeight} textFieldModel:model];
   }return _txtSecurityCode;
}

#pragma mark 验证码按钮
- (GWButton *)securityButton{
    if(!_securityButton){
        GWButtonModel *buttonModel = [GWButtonModel new];
        buttonModel.title = @"获取验证码";
        buttonModel.titleColor = [UIColor whiteColor];
        buttonModel.backgroundColor = hexStrColor(@"#FF9129");
        buttonModel.cornerRadius = 3;
        buttonModel.refreshTime = 60;
        buttonModel.borderColor = [UIColor clearColor];
        buttonModel.borderWidth = 1;
        buttonModel.font = [UIFont systemFontOfSize:12];
        
        _securityButton = [GWButton securityCodeButtonWithFrame:(CGRect){0,0,120,40} buttonModel:buttonModel];
        _securityButton.securityCodeDelegate = self;
    }return _securityButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
