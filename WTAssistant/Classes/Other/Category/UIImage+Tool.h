//
//  UIImage+Tool.h
//  02-图片裁剪
//

//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)

/**
 *  根据图片名称圆环图
 */
+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color;

/**
 *  根据图片设置圆环图
 */
+(UIImage *)image:(UIImage *)image border:(CGFloat)border borderColor:(UIColor *)color;

/**
 *  根据data设置圆环图
 */
+ (instancetype)imageWithData:(NSData *)data border:(CGFloat)border borderColor:(UIColor *)color;
@end
