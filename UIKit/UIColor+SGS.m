//
//  UIColor+SGSS.m
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import "UIColor+SGS.h"

@implementation UIColor (SGSS)
// red
- (CGFloat)redComponent {
    CGFloat r = 0.0;
    BOOL getSuccess = [self getRed:&r green:nil blue:nil alpha:nil];
    return getSuccess ? r : 0.0;
}

// green
- (CGFloat)greenComponent {
    CGFloat g = 0.0;
    BOOL getSuccess = [self getRed:nil green:&g blue:nil alpha:nil];
    return getSuccess ? g : 0.0;
}

// blue
- (CGFloat)blueComponent {
    CGFloat b = 0.0;
    BOOL getSuccess = [self getRed:nil green:nil blue:&b alpha:nil];
    return getSuccess ? b : 0.0;
}

// hue
- (CGFloat)hueComponent {
    CGFloat h = 0.0;
    BOOL getSuccess = [self getHue:&h saturation:nil brightness:nil alpha:nil];
    return getSuccess ? h : 0.0;
}

// saturation
- (CGFloat)saturationComponent {
    CGFloat s = 0.0;
    BOOL getSuccess = [self getHue:nil saturation:&s brightness:nil alpha:nil];
    return getSuccess ? s : 0.0;
}

- (CGFloat)brightnessComponent {
    CGFloat b = 0.0;
    BOOL getSuccess = [self getHue:nil saturation:nil brightness:&b alpha:nil];
    return getSuccess ? b : 0.0;
}

// alpha
- (CGFloat)alphaComponent {
    return CGColorGetAlpha(self.CGColor);
}

// 十六进制RGB数值，如：0xFF7F00
- (uint32_t)rgbValue {
    return ([self rgbaValue] >> 8);
}

// 十六进制RGBA数值，如：0xFF7F00FF
- (uint32_t)rgbaValue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    uint8_t red   = (uint8_t)(r * 255);
    uint8_t green = (uint8_t)(g * 255);
    uint8_t blue  = (uint8_t)(b * 255);
    uint8_t alpha = (uint8_t)(a * 255);
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

// 获取十六进制RGB字符串，如：#FF7F00
- (nullable NSString *)rgbHexString {
    return [self p_hexStringWithAlpha:NO];
}

- (nullable NSString *)rgbHexStringWithAlpha {
    return [self p_hexStringWithAlpha:YES];
}

// 私有方法，获取十六进制颜色码
- (nullable NSString *)p_hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        unsigned int white = (unsigned int)(components[0] * 255.0);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (unsigned int)(components[0] * 255.0),
               (unsigned int)(components[1] * 255.0),
               (unsigned int)(components[2] * 255.0)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02x",
               (unsigned int)(self.alphaComponent * 255.0 + 0.5)];
    }
    return hex;
}


// 通过RGB值实例化UIColor
+ (nonnull instancetype)colorWithHexRGBValue:(uint32_t)rgbValue {
    NSInteger r = (rgbValue >> 16) & 0xff;
    NSInteger g = (rgbValue >> 8) &0xff;
    NSInteger b = rgbValue & 0xff;
    
    return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:1.0f];
}

+ (nonnull instancetype)colorWithHexRGBValue:(uint32_t)rgbValue andAlpha:(CGFloat)alpha {
    NSInteger r = (rgbValue >> 16) & 0xff;
    NSInteger g = (rgbValue >> 8) &0xff;
    NSInteger b = rgbValue & 0xff;
    
    return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:alpha];
}

// 通过RGBA值实例化UIColor
+ (nonnull instancetype)colorWithHexRGBAValue:(uint32_t)rgbaValue {
    NSInteger r = (rgbaValue >> 24) & 0xff;
    NSInteger g = (rgbaValue >> 16) & 0xff;
    NSInteger b = (rgbaValue >> 8) & 0xff;
    NSInteger a = rgbaValue & 0xff;
    return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:(a / 255.0f)];
}

// 通过整型的RGB值实例化UIColor
+ (nonnull instancetype)colorWithRedUInt8Value:(uint8_t)red
                               greedUInt8Value:(uint8_t)greed
                                blueUInt8Value:(uint8_t)blue
                                         alpha:(CGFloat)alpha {
    uint8_t r = red & 0xff;
    uint8_t g = greed & 0xff;
    uint8_t b = blue & 0xff;
    
    return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:alpha];
}

// 通过十六进制数值字符串实例化UIColor
+ (nullable instancetype)colorWithHexString:(nonnull NSString *)hexString {
    NSMutableString *hexStr = [hexString.uppercaseString mutableCopy];
    if ([hexStr hasPrefix:@"#"]) {
        NSRange range = {0, 1};
        [hexStr deleteCharactersInRange:range];
    }
    
    if (hexStr.length != 6 || hexStr.length != 8) {
        return nil;
    }
    
    unsigned int hex = 0;
    [[NSScanner scannerWithString:hexStr] scanHexInt:&hex];
    return (hexStr.length == 6) ? [UIColor colorWithHexRGBValue:hex] : [UIColor colorWithHexRGBAValue:hex];
}
@end
