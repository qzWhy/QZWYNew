//
//  ViewController.m
//  QZWYNew
//
//  Created by 000 on 17/10/11.
//  Copyright © 2017年 faner. All rights reserved.
//

#import "ViewController.h"
#import "QZNetworkTools.h"
#import "QZNewsEntity.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *arrayList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // url  http://c.m.163.com/nc/article/headline/T1348647853363/full.html
    // http://c.m.163.com/nc/article/headline/T1348647853363/0-30.html
    
    // netconnect
    [[[QZNetworkTools shareNetworkTools] GET:@"nc/article/headline/T1348647853363/0-20.html" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        //取出第一个数组，扩展性好的
        NSString *key = [responseObject.keyEnumerator nextObject];
        
        NSArray *temArray = responseObject[key];
        
        //取出小的一组 遍历打印出声明
        [self writeInfoWithDict:temArray[1]];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:temArray.count];
        [temArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"======>%tu",idx);
            QZNewsEntity *news = [QZNewsEntity newModelWithDict:obj];
            [arrayM addObject:news];
        }];
        self.arrayList = arrayM;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }] resume];
}

#pragma mark - *****通过此方法打印出成员变量
- (void)writeInfoWithDict:(NSDictionary *)dict
{
    NSMutableString *strM = [NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@ %@",key,[obj class]);
        
        NSString *className = NSStringFromClass([obj class]);
        
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] ) {
            [strM appendFormat:@"@property (nonatomic,copy) NSString *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFArray"]){
            [strM appendFormat:@"@property (nonatomic,strong)NSArray *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@"@property (nonatomic,copy)NSNumber *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFBoolean"]){
            [strM appendFormat:@"@property (nonatomic,assign)BOOL %@;\n",key];
        }
        NSLog(@"\n%@",strM);
    }];
}


@end
