//
//  wclNetTool.h
//  ceshi
//
//  Created by banbo on 2017/9/12.
//  Copyright © 2017年 banbo. All rights reserved.
//

#import <AFNetworking.h>
typedef NS_ENUM(NSInteger)
{
    GET,
    POST,
}HTTPMethod;
@interface wclNetTool : AFHTTPSessionManager
+ (instancetype) sharedTools;
- (void) request:(HTTPMethod)method urlString:(NSString *)urlString  parameters:(NSMutableDictionary *)parameters finished:(void(^)(id responseObject,NSError * error))finished;
-(void)updateRequest:(NSString *)url
               params:(NSMutableDictionary *)params
      fileConfigArray:(NSMutableArray *)fileConfigArray
              finished:(void(^)(id responseObject,NSError * error))finished;
@property(nonatomic, strong)AFNetworkReachabilityManager *reachabManager;

-(AFNetworkReachabilityStatus)netStatus;
@end
