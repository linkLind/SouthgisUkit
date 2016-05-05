//
//  UIImage+SGS.h
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SGS)
/**
 *  生成纯颜色的图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 */
+ (nullable instancetype)imageWithColor:(nonnull UIColor *)color size:(CGSize)size;

/**
 *  生成圆形图片
 */
- (nullable UIImage *)circleImage;

/**
 *  生成圆角图片
 *
 *  @param radius 圆角角度
 */
- (nullable UIImage *)roundRectWithCornerRadius:(CGFloat)radius;

/**
 *  转换成新的尺寸（有拉伸）
 *
 *  @param newSize 新尺寸
 */
- (nullable UIImage *)transformToSize:(CGSize)newSize;

/**
 *  等比例缩放
 *
 *  @param newSize 新尺寸
 */
- (nullable UIImage *)scaleAspectWithSize:(CGSize)newSize;

/**
 *  旋转图片
 *
 *  @param radians 旋转角度，向左转为正数，向右转为负数
 *  @param fitSize 是否自适应大小
 */
- (nullable UIImage *)rotate:(CGFloat)radians fitSize:(BOOL)fitSize;

/**
 *  让图片向左旋转90°
 */
- (nullable UIImage *)rotateLeft90;

/**
 *  让图片向右旋转90°
 */
- (nullable UIImage *)rotateRight90;

/**
 *  将图片保存到Document的指定文件夹中
 *
 *  @param folderName 文件夹名称
 *  @param fileName   图片保存的名称（不包含后缀名）
 *  @param compress   压缩比
 */
- (BOOL)saveToFolder:(nonnull NSString *)folderName saveName:(nonnull NSString *)fileName compressionQuality:(CGFloat)compress;

/**
 *  从Document目录的指定文件夹中读取图片
 *
 *  @param imageName  图片名称（不包含后缀名）
 *  @param folderName 文件夹名称
 *
 *  @return NSImage or nil
 */
+ (nullable instancetype)readImage:(nonnull NSString *)imageName fromFolder:(nonnull NSString *)folderName;


///================================================================
///  MARK: 高斯模糊效果
///        源码来自苹果官方：https://developer.apple.com/downloads/index.action?name=WWDC%202013 -> 'UIImageEffects'
///================================================================

/**
 *  浅色模糊
 */
- (nullable UIImage *)lightEffect;

/**
 *  另一种浅色模糊
 */
- (nullable UIImage *)extraLightEffect;

/**
 *  深色模糊
 */
- (nullable UIImage *)darkEffect;

/**
 *  使用特定颜色渲染
 */
- (nullable UIImage *)tintEffectWithColor:(nonnull UIColor *)tintColor;

/**
 *  高斯模糊效果
 *
 *  @param blurRadius            模糊程度，0表示无模糊渲染
 *  @param tintColor             模糊渲染颜色
 *  @param saturationDeltaFactor 饱和度
 *  @param maskImage             掩膜
 *
 *  @return 高斯模糊渲染的图片
 */
- (nullable UIImage *)blurWithRadius:(CGFloat)blurRadius tintColor:(nonnull UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(nullable UIImage *)maskImage;




/**
 *  从原点开始截取图片，按照长，宽的实际情况截取
 *  @param image 需要截取的图片
 *  @return image 返回截取后的图片
 */
-(nullable UIImage *)getImageByHeightOrWidth:(nullable UIImage *)image;

/**
 *  截取部分图像
 *  image = [image getSubImage:CGRectMake(0, 0, image.size.height, image.size.height)];
 *
 */
-(nullable UIImage*)getSubImage:(CGRect)rect;


/**
 *  等比例压缩图片
 *  @param 压缩的尺寸
 *  @return 返回需要压缩的图片
 */

-(nullable UIImage*)scaleToSize:(CGSize)size;


@end
