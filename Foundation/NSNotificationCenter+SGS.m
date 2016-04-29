//
//  NSNotificationCenter+SGS.m
//  ARK_Objective-C
//
//  Created by Lee on 16/4/24.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import "NSNotificationCenter+SGS.h"
#import <pthread.h>

@implementation NSNotificationCenter (SGS)
- (void)postNotificationOnMainThread:(nonnull NSNotification *)notification {
    if(pthread_main_np()) return [self postNotification:notification];
    [self postNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void)postNotificationOnMainThread:(nonnull NSNotification *)notification waitUntilDone:(BOOL)wait {
    if(pthread_main_np()) return [self postNotification:notification];
    [[self class] performSelectorOnMainThread:@selector(p_postNotification:) withObject:notification waitUntilDone:wait];
}

- (void)postNotificationNameOnMainThread:(nonnull NSString *)name object:(nullable id)object {
    if(pthread_main_np()) return [self postNotificationName:name object:object];
    [self postNotificationNameOnMainThread:name object:object userInfo:nil waitUntilDone:NO];
}

- (void)postNotificationNameOnMainThread:(nonnull NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo {
    if(pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    [self postNotificationNameOnMainThread:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void)postNotificationNameOnMainThread:(nonnull NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo waitUntilDone:(BOOL)wait {
    if(pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] initWithCapacity:3];
    if(name) [info setObject:name forKey:@"name"];
    if(object) [info setObject:object forKey:@"object"];
    if(userInfo) [info setObject:userInfo forKey:@"userInfo"];
    
    [[self class] performSelectorOnMainThread:@selector(p_postNotificationWithInfo:) withObject:info.copy waitUntilDone:wait];
}

+ (void)p_postNotification:(nonnull NSNotification *)notification {
    [[self defaultCenter] postNotification:notification];
}

+ (void)p_postNotificationWithInfo:(nonnull NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    
    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}
@end
