//
//  GWButtonModel.h
//  GWTextField
//
//  Created by genwei yang on 2017/12/20.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWButtonModel : NSObject
//标题
@property (nonatomic,readwrite,copy)NSString *title;
//标题颜色
@property (nonatomic,readwrite,strong)UIColor *titleColor;
//边框颜色
@property (nonatomic,readwrite,strong)UIColor *borderColor;
//边框宽度
@property (nonatomic,readwrite,unsafe_unretained)CGFloat borderWidth;
//刷新计时
@property (nonatomic,readwrite,unsafe_unretained)NSTimeInterval refreshTime;
//字体
@property (nonatomic,readwrite,strong)UIFont *font;
//背景色
@property (nonatomic,readwrite,strong)UIColor *backgroundColor;
//圆角
@property (nonatomic,readwrite,unsafe_unretained)CGFloat cornerRadius;
@end
