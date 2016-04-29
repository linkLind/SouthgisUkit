//
//  UIView+SGS.h
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SGS)
@property (nonatomic, assign) CGFloat left;        // left    == self.frame.origin.x.
@property (nonatomic, assign) CGFloat top;         // top     == self.frame.origin.y
@property (nonatomic, assign) CGFloat right;       // right   == self.frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat bottom;      // bottom  == self.frame.origin.y + frame.size.height
@property (nonatomic, assign) CGFloat width;       // width   == self.frame.size.width.
@property (nonatomic, assign) CGFloat height;      // height  == self.frame.size.height.
@property (nonatomic, assign) CGFloat centerX;     // centerX == self.center.x
@property (nonatomic, assign) CGFloat centerY;     // centerY == self. center.y
@property (nonatomic, assign) CGPoint origin;      // origin  == self.frame.origin.
@property (nonatomic, assign) CGSize  size;        // size    == self.frame.size.

/**
 *  实例化一个模糊效果的视图
 *
 *  @param frame       视图大小
 *  @param effectStyle 模糊效果:
 *              1.UIBlurEffectStyleExtraLight,
 *              2.UIBlurEffectStyleLight,
 *              3.UIBlurEffectStyleDark
 *
 *  @return UIVisualEffectView or nil
 */
+ (nullable instancetype)blurViewWithFrame:(CGRect)frame effectStyle:(UIBlurEffectStyle)effectStyle;
@end
