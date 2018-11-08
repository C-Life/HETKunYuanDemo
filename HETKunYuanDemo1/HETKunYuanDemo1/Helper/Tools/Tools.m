//
//  Tools.m
//  HETKunYuanDemo
//
//  Created by JustinYang on 2018/10/10.
//  Copyright © 2018年 JustinYang. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(NSString *)timestamp{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *_timestamp = [NSString stringWithFormat: @"%lld", (long long)(time * 1000)];
    NSTimeInterval offsetTime = [[NSUserDefaults standardUserDefaults] doubleForKey:@"kHETOffsetTime"];
    NSString *timeTamp = [NSString stringWithFormat:@"%lld",(long long)(_timestamp.doubleValue + offsetTime *1000)];
    return timeTamp;
}

+(NSString *)getHostName{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *env = [defaults objectForKey:kHETEnviroment];
    if (env.integerValue == 0) {
        return @"https://dp.clife.net";
    }else if (env.integerValue == 1){
        return @"https://pre.open.api.clife.cn";
    }else{
        return @"https://open.api.clife.cn";
    }
}

@end
