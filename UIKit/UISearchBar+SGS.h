//
//  UISearchBar+SGS.h
//  RTLibrary-ios
//
//  Created by 吴小星 on 16/5/5.
//  Copyright © 2016年 zlycare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (SGS)

/**
 *  设置searchbar背景颜色(图片)
 *  @param color 背景颜色
 *  @param 设置颜色的范围
 *  @return 返回背景图片
 */

- (nullable UIImage *)imageWithColor:(nullable UIColor *)color size:(CGSize)size;

@end
