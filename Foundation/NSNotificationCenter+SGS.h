//
//  NSNotificationCenter+SGS.h
//  ARK_Objective-C
//
//  Created by Lee on 16/4/24.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (SGS)
// 参考：YYKit
- (void)postNotificationOnMainThread:(nonnull NSNotification *)notification;
- (void)postNotificationOnMainThread:(nonnull NSNotification *)notification waitUntilDone:(BOOL)wait;

- (void)postNotificationNameOnMainThread:(nonnull NSString *)name object:(nullable id)object;
- (void)postNotificationNameOnMainThread:(nonnull NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;
- (void)postNotificationNameOnMainThread:(nonnull NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo waitUntilDone:(BOOL)wait;
@end
