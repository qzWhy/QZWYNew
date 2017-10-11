//
//  QZNetworkTools.h
//  QZNews
//
//  Created by 000 on 17/10/9.
//  Copyright © 2017年 faner. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface QZNetworkTools : AFHTTPSessionManager

+ (instancetype)shareNetworkTools;
+ (instancetype)shareNetworkToolsWithoutBaseUrl;

@end
