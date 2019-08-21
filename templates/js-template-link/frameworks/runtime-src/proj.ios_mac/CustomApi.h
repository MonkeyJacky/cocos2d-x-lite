//
//  CustomApi.h
//  biwan-mobile
//
//  Created by Jacky on 2019/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomApi : NSObject

+ (NSString *)getWifiName;
+ (NSString *)getMac;
+ (void)openWeb:(NSString*) url;

@end

NS_ASSUME_NONNULL_END
