//
//  GWButton.m
//  GWTextField
//
//  Created by genwei yang on 2017/12/20.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import "GWButton.h"

@implementation GWButton

+ (instancetype)securityCodeButtonWithFrame:(CGRect)frame
                                buttonModel:(GWButtonModel *)buttonModel{
    
    GWButton *button = [[GWButton alloc] initWithFrame:frame
                                           refreshTime:(buttonModel.refreshTime)];
    [button setTitle:buttonModel.title forState:UIControlStateNormal];
    [[button titleLabel] setFont:buttonModel.font];
    button.layer.masksToBounds = YES;
    [button setBackgroundImage:[PMBTools convertUIColorToUIImage:buttonModel.backgroundColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = buttonModel.cornerRadius;
    [button setTitleColor:buttonModel.titleColor forState:UIControlStateNormal];
    [button addTarget:button action:@selector(securityCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame
                  refreshTime:(CGFloat)refresTime{
    if(self = [super initWithFrame:frame]){
     
    }
    return self;
}

- (void)securityCodeType:(NSString *)type
           userTelephone:(NSString *)tel
              refresTime:(NSTimeInterval)intervalTime{
    [self beginToCountDownWithRefresTime:intervalTime];
}

- (void)beginToCountDownWithRefresTime:(NSTimeInterval)intervalTime{
    __block int timeout = intervalTime; //倒计时时间
    kWeakSelf
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){//倒计时结束,关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself setUserInteractionEnabled:YES];
                [weakself setTitle:@"获取验证码" forState:UIControlStateNormal];
                [weakself setBackgroundImage:[PMBTools convertUIColorToUIImage:[PMBTools colorWithHexString:@"#FF9129"]] forState:UIControlStateNormal];
            });
        }else{
            int seconds = (timeout==60?timeout-1:timeout) % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [weakself setBackgroundImage:[PMBTools convertUIColorToUIImage:getColor(207, 204, 207, 1)] forState:UIControlStateNormal];
                [weakself setTitle:[NSString stringWithFormat:@"重新获取(%ds)",seconds]
                          forState:UIControlStateNormal];
                [weakself setUserInteractionEnabled:NO];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}

#pragma mark 验证码刷新事件
- (void)securityCodeButtonAction:(GWButton *)button{
    
    button.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
    
    if([button.securityCodeDelegate respondsToSelector:@selector(sendSecurityCode)]){
        [button.securityCodeDelegate sendSecurityCode];
    }
}
@end
