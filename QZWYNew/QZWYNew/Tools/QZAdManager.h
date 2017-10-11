//
//  QZAdManager.h
//  QZNews
//
//  Created by 000 on 17/10/11.
//  Copyright © 2017年 faner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QZAdManager : NSObject

+ (BOOL)isShouldDisplayAd;
+ (UIImage *)getAdImage;
+ (void)loadLatesAdImage;

@end
