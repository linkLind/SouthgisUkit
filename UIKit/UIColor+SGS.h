//
//  UIColor+SGS.h
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SGS)
/**
 *  RGB颜色Red通道数值（0.0~1.0）
 */
@property (nonatomic, assign, readonly) CGFloat redComponent;

/**
 *  RGB颜色Green通道数值（0.0~1.0）
 */
@property (nonatomic, assign, readonly) CGFloat greenComponent;

/**
 *  RGB颜色Blue通道数值（0.0~1.0）
 */
@property (nonatomic, assign, readonly) CGFloat blueComponent;

/**
 *  HSB颜色Hue通道数值（0.0~1.0)
 */
@property (nonatomic, assign, readonly) CGFloat hueComponent;

/**
 *  HSB颜色saturation通道数值（0.0~1.0)
 */
@property (nonatomic, assign, readonly) CGFloat saturationComponent;

/**
 *  HSB颜色brightness通道数值（0.0~1.0)
 */
@property (nonatomic, assign, readonly) CGFloat brightnessComponent;

/**
 *  Alpha通道数值（0.0~1.0）
 */
@property (nonatomic, assign, readonly) CGFloat alphaComponent;

/**
 *  色域
 */
@property (nonatomic, assign, readonly) CGColorSpaceModel colorSpaceModel;

/**
 *  十六进制RGB数值，如：0xFF7F00
 */
- (uint32_t)rgbValue;

/**
 *  十六进制RGBA数值，如：0xFF7F00FF
 */
- (uint32_t)rgbaValue;

/**
 *  获取十六进制RGB字符串，如：orangeColor -> #FF7F00
 */
- (nullable NSString *)rgbHexString;

/**
 *  获取十六进制RGBA字符串，如：orangeColor -> #FF7F00FF
 */
- (nullable NSString *)rgbHexStringWithAlpha;


/**
 *  通过十六进制RGB数值实例化NSColor
 *
 *  @param rgbValue 十六进制RGB数值, 如:0xFF7F00 -> orangeColor
 *
 *  @return NSColor
 */
+ (nonnull instancetype)colorWithHexRGBValue:(uint32_t)rgbValue;

/**
 *  通过十六进制RGB数值以及alpha实例化NSColor
 *
 *  如:0xFF7F00 + 1.0 -> orangeColor
 *
 *  @param rgbValue 十六进制RGB数值
 *  @param alpha    alpha
 *
 *  @return NSColor
 */
+ (nonnull instancetype)colorWithHexRGBValue:(uint32_t)rgbValue andAlpha:(CGFloat)alpha;

/**
 *  通过十六进制RGBA数值实例化NSColor
 *
 *  @param rgbaValue 十六进制RGB数值, 如:FF7F00FF -> orangeColor
 *
 *  @return NSColor
 */
+ (nonnull instancetype)colorWithHexRGBAValue:(uint32_t)rgbaValue;



/**
 *  通过输入UInt8的RGB以及alpha值实例化NSColor
 *
 *  @param red   Red（0~255）
 *  @param greed Green（0~255）
 *  @param blue  Blue（0~255）
 *  @param alpha alpha（0.0~1.0）
 *
 *  @return NSColor
 */
+ (nonnull instancetype)colorWithRedUInt8Value:(uint8_t)red greedUInt8Value:(uint8_t)greed blueUInt8Value:(uint8_t)blue alpha:(CGFloat)alpha;


/**
 *  通过十六进制数值字符串实例化NSColor
 *  其格式为：0xRRGGBB 或 0xRRGGBBAA（R：red，G：green，B：blue，A：alpha）
 *
 *  @param hexString 十六进制数值字符串，如: #FF7F00 或#FF7F00FF -> orangeColor
 *
 *  @return NSColor or nil
 */
+ (nullable instancetype)colorWithHexString:(nonnull NSString *)hexString;
@end
