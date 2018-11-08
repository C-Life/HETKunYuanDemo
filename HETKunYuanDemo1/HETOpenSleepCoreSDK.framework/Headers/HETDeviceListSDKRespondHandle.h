//
//  HETDeviceListSDKRespondHandle.h
//  HETDeviceListSDK
//
//  Created by JustinYang on 2018/10/16.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HETDeviceListSDKRespondHandle : NSObject

typedef void (^HETHttpSuccessBlockEmptyParameter)(void);
typedef void (^HETHttpSuccessBlockIdParameter)(id response);
typedef void(^HETHttpSuccessBlockStringParameter)(NSString *stringValue);
typedef void(^HETHttpSuccessBlockNumberParameter)(NSNumber *numberValue);
typedef void(^HETHttpSuccessBlockDictionaryParameter)(NSDictionary *dictValue);
typedef void(^HETHttpSuccessBlockArrayParameter)(NSArray *arrayValue);
typedef void(^HETHttpSuccessBlockImageParameter)(UIImage *image);
typedef void (^HETHttpFailureBlock)(NSError *error);



+(void)emptyParseWithRespose:(NSDictionary *)respose result:(void (^)(NSError *err))resultBlock;
+(void)idParseWithResponse:(NSDictionary *)respose result:(void (^)(id value,NSError *err))resultBlock;
+(void)stringParseWithResponse:(NSDictionary *)respose result:(void (^)(NSString *value,NSError *err))resultBlock;
+(void)numberParseWithResponse:(NSDictionary *)respose result:(void (^)(NSNumber *value,NSError *err))resultBlock;
+(void)dictoryParseWithResponse:(NSDictionary *)respose result:(void (^)(NSDictionary *value,NSError *err))resultBlock;
+(void)arrayParseWithResponse:(NSDictionary *)respose result:(void (^)(NSArray *value,NSError *err))resultBlock;

@end

NS_ASSUME_NONNULL_END
