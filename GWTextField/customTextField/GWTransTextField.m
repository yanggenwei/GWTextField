//
//  GWTransTextField.m
//  GWTextField
//
//  Created by genwei yang on 2017/12/18.
//  Copyright © 2017年 YangGenWei. All rights reserved.
//

#import "GWTransTextField.h"
#import "GWTextFieldModel.h"

@interface GWTransTextField()
{
    CGSize imageSize;
    UIView *_titleView;
    GWTextFieldStyle _textfieldStyle;
    UIView *_rightView;
}
@property (nonatomic,readwrite,strong)UILabel *lblLeftView;
@property (nonatomic,readwrite,strong)UIImageView *imgLeftView;
@end

@implementation GWTransTextField

#pragma mark - 初始化
- (instancetype)initWithNormalFrame:(CGRect)frame textFieldModel:(GWTextFieldModel *)textFieldModel{
    if(self = [super initWithFrame:frame])
    {
        textFieldModel.placeHolderColor = nil;
        [self createUILayoutWithModel:textFieldModel textFieldStyle:GWTextFieldStyleWithNormal];
    }
    return  self;
}

- (instancetype)initWithUnlineFrame:(CGRect)frame textFieldModel:(GWTextFieldModel *)textFieldModel{
    if(self = [super initWithFrame:frame])
    {
        textFieldModel.placeHolderColor = [UIColor whiteColor];
        textFieldModel.borderWidth = 0;
        textFieldModel.textColor = [UIColor whiteColor];
        textFieldModel.borderColor = [UIColor clearColor];
        textFieldModel.backgroundColor = [UIColor clearColor];
        [self createUILayoutWithModel:textFieldModel textFieldStyle:GWTextFieldStyleWithUnline];
    }
    return  self;
}


#pragma mark - 创建默认样式的输入框
+ (instancetype)createNormalTextFieldWithFrame:(CGRect)frame
                                textFieldModel:(GWTextFieldModel *)textFieldModel{
    
    return [[GWTransTextField alloc] initWithNormalFrame:frame textFieldModel:textFieldModel];
}


#pragma mark - 创建具有下划线的输入框
+ (instancetype)createUnlineTextFieldWithFrame:(CGRect)frame
                                textFieldModel:(GWTextFieldModel *)textFieldModel
{
    return [[GWTransTextField alloc] initWithUnlineFrame:frame textFieldModel:textFieldModel];
}

- (instancetype)createUILayoutWithModel:(GWTextFieldModel *)textFieldModel
                         textFieldStyle:(GWTextFieldStyle)textFieldStyle
{
    
    if([textFieldModel.titleViewContent isKindOfClass:[NSString class]]){
        self.lblLeftView.text = textFieldModel.titleViewContent;
        self.lblLeftView.font = [UIFont systemFontOfSize:14];
        [self.lblLeftView sizeToFit];
        self.lblLeftView.textColor = hexStrColor(@"#4A4A4A");
        self.lblLeftView.frame = (CGRect){0,0,self.lblLeftView.width,self.lblLeftView.height};
        imageSize = self.lblLeftView.frame.size;
        _titleView = self.lblLeftView;
    }else if([textFieldModel.titleViewContent isKindOfClass:[UIImage class]]){
        imageSize = ((UIImage *)textFieldModel.titleViewContent).size;
        self.imgLeftView.image = (UIImage *)textFieldModel.titleViewContent;
        self.imgLeftView.frame = (CGRect){0,0,imageSize.width,imageSize.height};
        _titleView = self.imgLeftView;
    }
    
    UIButton *rightView;    //右视图
    if([textFieldModel.rightViewContent isKindOfClass:[UIView class]]){
        rightView = textFieldModel.rightViewContent;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = rightView;
    }
    
    _textfieldStyle = textFieldStyle;
    self.backgroundColor = textFieldModel.backgroundColor;
    self.placeholder = textFieldModel.placeholder;
    self.font = [UIFont systemFontOfSize:14];
    self.textColor = textFieldModel.textColor;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.layer.borderColor = textFieldModel.borderColor.CGColor;
    self.layer.borderWidth = textFieldModel.borderWidth;
    self.secureTextEntry = textFieldModel.isPassword;
    self.layer.cornerRadius = textFieldModel.cornerRadius;
    //设置placeholder颜色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = textFieldModel.placeHolderColor;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    [self setAttributedPlaceholder:attribute];
    
    //创建左边视图
    if(_titleView){
        CGRect rect = _titleView.frame;
        rect.origin.x = 10;
        rect.origin.y = -10;
        _titleView.frame = rect;
        [self setTintColor:hexStrColor(@"#BEBEBE")];
        
        self.leftView = _titleView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    //如果设定具有下划线的文本框
    if(textFieldStyle == GWTextFieldStyleWithUnline){
        CALayer *lineLayer = [CALayer new];
        [lineLayer setBackgroundColor:[UIColor whiteColor].CGColor];
        [lineLayer setFrame:(CGRect){0,self.height-1,self.width,1}];
        [lineLayer setBackgroundColor:hexStrColor(@"#DEDEDE").CGColor];
        [self.layer addSublayer:lineLayer];
    }
    
    _rightView = rightView;
    return self;
}

#pragma mark - 重写输入框方法
#pragma mark 文字状态设定
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    bounds.origin.x = marginLeft(_titleView) + 15;
    if(_titleView){
        bounds.size.width -=_titleView.width-10;
    }
    //如果有右视图的话,文本框输入的范围要缩小到右视图的前面
    if(_rightView){
        bounds.size.width = bounds.size.width-bounds.origin.x-_rightView.bounds.size.width-15;
    }
    return bounds;
}

#pragma mark 修改模式时设定
- (CGRect)editingRectForBounds:(CGRect)bounds{
    bounds.origin.x = _titleView.frame.size.width+_titleView.frame.origin.x + 15;
    if(_titleView){
        bounds.size.width -=_titleView.width-10;
    }
    if(_rightView){
        bounds.size.width = bounds.size.width-bounds.origin.x-_rightView.bounds.size.width-15;
    }
    return bounds;
}

#pragma mark 左边图标设置
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    bounds.origin.x = 10;
    bounds.origin.y = bounds.size.height/2-imageSize.height/2;
    bounds.size.width = imageSize.width;
    bounds.size.height = imageSize.height;
    return bounds;
}

#pragma mark 右边视图设置
- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGFloat width = self.bounds.size.width*0.275;
    bounds.origin.x = self.width -width -10;
    bounds.origin.y = self.bounds.size.height/2-self.bounds.size.height*0.6/2;
    bounds.size.height = self.bounds.size.height*0.6;
    bounds.size.width = width;
    return bounds;
}


#pragma mark getter and setter
- (UILabel *)lblLeftView{
    if(!_lblLeftView)
    {
        _lblLeftView = [[UILabel alloc] init];
    }
    return _lblLeftView;
}

- (UIImageView *)imgLeftView{
    if(!_imgLeftView){
        _imgLeftView = [[UIImageView alloc] init];
    }
    return _imgLeftView;
}
@end
