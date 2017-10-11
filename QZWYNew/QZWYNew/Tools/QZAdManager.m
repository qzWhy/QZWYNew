//
//  QZAdManager.m
//  QZNews
//
//  Created by 000 on 17/10/11.
//  Copyright © 2017年 faner. All rights reserved.
//

#import "QZAdManager.h"
#import "QZNetworkTools.h"

#define kCachedCurrentImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingString:@"/adcurrent.png"])
#define kCachedNewImage     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingString:@"/adnew.png"])
@interface QZAdManager ()

+ (void)downloadImage:(NSString *)imageUrl;

@end

@implementation QZAdManager

/**
 *  在缓存中取图片
 **/
+ (BOOL)isShouldDisplayAd
{
    return ([[NSFileManager defaultManager] fileExistsAtPath:kCachedCurrentImage isDirectory:NULL]||[[NSFileManager defaultManager] fileExistsAtPath:kCachedNewImage isDirectory:NULL]);
}
+ (UIImage *)getAdImage
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:kCachedNewImage isDirectory:NULL]) {
        [[NSFileManager defaultManager] removeItemAtPath:kCachedCurrentImage error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:kCachedNewImage error:nil];
    }
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:kCachedCurrentImage]];
}

+ (void)downloadImage:(NSString *)imageUrl
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imageUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            [data writeToFile:kCachedNewImage atomically:YES];
        }
    }];
    [task resume];
}

+ (void)loadLatesAdImage
{
    NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
    
    [[[QZNetworkTools shareNetworkToolsWithoutBaseUrl] GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *adArray = [responseObject valueForKey:@"ads"];
        NSString *imgUrl = adArray[0][@"res_url"][0];
        NSString *imgUrl2 = nil;
        if (adArray.count >1) {
            imgUrl2 = adArray[1][@"res_url"][0];
        }
        
        BOOL one = [[NSUserDefaults standardUserDefaults] boolForKey:@"one"];
        if (imgUrl2.length >0) {
            if (one) {
                [self downloadImage:imgUrl];
                [[NSUserDefaults standardUserDefaults] setBool:!one forKey:@"one"];
            }else {
                [self downloadImage:imgUrl2];
                [[NSUserDefaults standardUserDefaults] setBool:!one forKey:@"one"];
            }
        } else{
            [self downloadImage:imgUrl];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }] resume];
}

@end
