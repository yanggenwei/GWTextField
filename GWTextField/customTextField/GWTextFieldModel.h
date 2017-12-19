//
//  PMBTextFieldModel.h
//  Pangmaobao
//
//  Created by 杨根威 on 2017/9/1.
//  Copyright © 2017年 Shanghai Birkin Network Technology Co. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 自定义输入框控件数据源
 */
@interface GWTextFieldModel : NSObject
//标题内容
@property (nonatomic,readwrite,strong)id titleViewContent;
//右视图内容
@property (nonatomic,readwrite,strong)id rightViewContent;
//文本颜色
@property (nonatomic,readwrite,strong)UIColor *textColor;
//边框线宽度
@property (nonatomic,readwrite,unsafe_unretained)CGFloat borderWidth;
//边框线颜色
@property (nonatomic,readwrite,strong)UIColor *borderColor;
//背景颜色
@property (nonatomic,readwrite,strong)UIColor *backgroundColor;
//默认提示语
@property (nonatomic,readwrite,copy)NSString *placeholder;
//默认提示语颜色
@property (nonatomic,readwrite,strong)UIColor *placeHolderColor;
//键盘类型
@property (nonatomic,readwrite,unsafe_unretained)UIKeyboardType keyboardType;
//是否显示密码
@property (nonatomic,readwrite,unsafe_unretained)BOOL isPassword;

@end
