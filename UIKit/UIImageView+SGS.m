//
//  UIImageView+SGS.m
//  ARK_Objective-C
//
//  Created by Lee on 16/4/24.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import "UIImageView+SGS.h"
#import "UIImage+SGS.h"

@implementation UIImageView (SGS)
// 为UIImageView添加圆角图片
- (void)setRoundRectImage:(nonnull UIImage *)image withCornerRadius:(CGFloat)radius {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *roundRectImage = [image roundRectWithCornerRadius:radius];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = (roundRectImage) ? roundRectImage : image;
        });
    });
}
@end
