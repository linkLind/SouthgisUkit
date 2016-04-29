//
//  UIImageView+SGS.h
//  ARK_Objective-C
//
//  Created by Lee on 16/4/24.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SGS)
/**
 *  为UIImageView设置图片，并且自动将图片切为圆角
 *
 *  @param image  图片
 *  @param radius 圆角角度
 */
- (void)setRoundRectImage:(nonnull UIImage *)image withCornerRadius:(CGFloat)radius;
@end
