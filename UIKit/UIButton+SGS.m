//
//  UIButton+SGS.m
//  RTLibrary-ios
//
//  Created by 吴小星 on 16/5/5.
//  Copyright © 2016年 zlycare. All rights reserved.
//

#import "UIButton+SGS.h"

@implementation UIButton (SGS)


/**
 *  @author crash         crash_wu@163.com   , 16-05-05 08:05:49
 *
 *  @brief  button Image 与Title 垂直方向上居中
 *
 *  @param spacing Image 与Title 垂直方向上的间距
 */
- (void)centerImageAndTitle:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(
                                            - (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(
                                            0.0, - imageSize.width, - (totalHeight - titleSize.height), 0.0);
}


@end
