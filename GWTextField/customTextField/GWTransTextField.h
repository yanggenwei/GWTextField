//
//  GWTransTextField.h
//  GWTextField
//
//  Created by genwei yang on 2017/12/18.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GWTextFieldModel;

typedef NS_ENUM(NSInteger,GWTextFieldStyle){
    GWTextFieldStyleWithNormal,    //正常
    GWTextFieldStyleWithUnline,    //下滑线
};


/**
 自定义输入框控件类
 */
@interface GWTransTextField : UITextField<UITextFieldDelegate>


/**
 创建一个默认样式的输入框·

 @param frame 布局
 @param textFieldModel 文本框属性设置数据源
 @return instance of GWTransTextField
 */
+ (instancetype)createNormalTextFieldWithFrame:(CGRect)frame
                                textFieldModel:(GWTextFieldModel *)textFieldModel;


/**
 创建一个带有下划线的输入框

 @param frame 布局
 @param textFieldModel 文本框属性设置数据源
 @return instance of GWTransTextField
 */
+(instancetype)createUnlineTextFieldWithFrame:(CGRect) frame
                               textFieldModel:(GWTextFieldModel *)textFieldModel;


@end
