//
//  UITextField+WTExtension.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "UITextField+WTExtension.h"

@implementation UITextField (WTExtension)
//设置文本框光标位置
-(void)setTextFieldLeftView{
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 1)];
    self.leftView=leftView;
    self.leftViewMode=UITextFieldViewModeAlways;
}
@end
