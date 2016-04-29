//
//  NSNumber+SGS.h
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (SGS)
/**
 *  根据字符串实例化 NSNumber 对象
 *
 *  字符串格式可以为：@"18", @"-0x1F", @"3.14", @" .12e5 ", @"true", @"NO", @"nil" 等
 *
 *  @param string 字符串
 *
 *  @return NSNumber or nil
 */
+ (nullable instancetype)numberWithString:(nonnull NSString *)string;
@end
