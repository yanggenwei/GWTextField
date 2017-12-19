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




@interface GWTextViewController ()
@property (nonatomic,readwrite,strong)GWTransTextField *txtUserName;
@property (nonatomic,readwrite,strong)GWTransTextField *txtPassword;
@property (nonatomic,readwrite,strong)GWTransTextField *txtWidthDraw;
@end

@implementation GWTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor cyanColor]];
    [self addSubView];
}

- (void)addSubView{
    
    [self.view addSubview:self.txtUserName];
    [self.view addSubview:self.txtPassword];
    [self.view addSubview:self.txtWidthDraw];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.txtUserName resignFirstResponder];
    [self.txtWidthDraw resignFirstResponder];
    [self.txtPassword resignFirstResponder];
}

- (void)withDrawButtonAction:(UIButton *)button{
    self.txtWidthDraw.text = @"777";
}

#pragma mark getter and setter
- (GWTransTextField *)txtUserName{
    if(!_txtUserName){
        NSInteger buttonMargin = 20;
        CGFloat buttonHeight = 50;
        GWTextFieldModel *textFieldModel = [GWTextFieldModel new];
        textFieldModel.placeholder = @"请输入手机密码";
        textFieldModel.titleViewContent = [UIImage imageNamed:@"Phone"];
        _txtUserName = [GWTransTextField createUnlineTextFieldWithFrame:(CGRect){buttonMargin,200,kSCREENWIDTH-buttonMargin*2,buttonHeight} textFieldModel:textFieldModel];
    }return _txtUserName;
}

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

        _txtPassword = [GWTransTextField createNormalTextFieldWithFrame:(CGRect){buttonMargin,marginTop(self.txtUserName)+5,kSCREENWIDTH-buttonMargin*2,buttonHeight} textFieldModel:model];
        _txtPassword.layer.cornerRadius = 3;
    }return _txtPassword;
}

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
        
        UIButton *withDrawButton = [[UIButton alloc] initWithFrame:(CGRect){0,0,100,40}];
        [withDrawButton setTitle:@"全部提现" forState:UIControlStateNormal];
        [withDrawButton setTitleColor:hexStrColor(@"#4A4A4A") forState:UIControlStateNormal];
        [[withDrawButton titleLabel] setFont:[UIFont systemFontOfSize:12]];
        [withDrawButton addTarget:self action:@selector(withDrawButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        model.rightViewContent = withDrawButton;
        
        _txtWidthDraw = [GWTransTextField createNormalTextFieldWithFrame:(CGRect){buttonMargin,marginTop(self.txtPassword)+5,kSCREENWIDTH-buttonMargin*2,buttonHeight} textFieldModel:model];
         _txtWidthDraw.layer.cornerRadius = 3;
    }return _txtWidthDraw;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
