//
//  GWButton.h
//  GWTextField
//
//  Created by genwei yang on 2017/12/20.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWButtonModel.h"

@protocol GWSecurityCodeDelegate <NSObject>

/**
 发送验证码
 */
- (void)sendSecurityCode;
@end

@interface GWButton : UIButton

@property (nonatomic,readwrite,weak)id<GWSecurityCodeDelegate>   securityCodeDelegate;


/**
 验证码

 @param frame 布局
 @param buttonModel 按钮数据模型

 */
+ (instancetype)securityCodeButtonWithFrame:(CGRect)frame
                                buttonModel:(GWButtonModel *)buttonModel;


/**
 发送获取验证码请求

 @param type 验证码类型
 @param tel 手机号码
 @param intervalTime 倒计时时间
 */
- (void)securityCodeType:(NSString *)type
           userTelephone:(NSString *)tel
              refresTime:(NSTimeInterval)intervalTime;
@end
