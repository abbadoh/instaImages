//
//  IIServerManager.m
//  InstaImages
//
//  Created by Gumo on 15/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIServerManager.h"
#import <AFNetworking/AFNetworking.h>

static NSString * const ACCESS_TOKEN = @"1959485209.1677ed0.58acc367fbcb422cbaf4f5c6375bd997";
static NSString * const BASE_URL = @"https://api.instagram.com/v1/";

static NSString * const USER_SEARCH_URL_SUFFIX = @"users/search?q=%@&access_token=%@";
static NSString * const USER_MEDIA_RICENT_URL_SUFFIX = @"users/%@/media/recent/?access_token=%@";
static NSString * const USER_RELATIONSHIP_URL_SUFFIX = @"users/%@/relationship?access_token=%@";
static NSString * const USER_MEDIA_FOR_MAX_ID_URL_SUFFIX = @"users/%@/media/recent/?access_token=%@&max_id=%@";
static NSString * const USER_MEDIA_FOR_MIN_ID_URL_SUFFIX = @"users/%@/media/recent/?access_token=%@&min_id=%@";

@interface IIServerManager ()

@property (strong, nonatomic, readonly) AFHTTPSessionManager * requestManager;

@end


@implementation IIServerManager

+ (instancetype)sharedManager{
    static dispatch_once_t pred;
    static IIServerManager *_sharedManager = nil;
    dispatch_once(&pred, ^{
        _sharedManager = [[IIServerManager alloc] init];
        [_sharedManager initRequestManager];
    });
    return _sharedManager;
}

- (void)initRequestManager {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    _requestManager = manager;
}

- (NSString *)constructUrl:(NSString *)prefix {
    return [NSString stringWithFormat:@"%@%@", BASE_URL, prefix];
}

-(void)getUserDataForUserWithUsername:(NSString*)username completion:(void (^)(NSDictionary * response, NSError * error))completion {
    NSString * urlSuffix = [NSString stringWithFormat:USER_SEARCH_URL_SUFFIX, username, ACCESS_TOKEN];
    NSString * url = [self constructUrl:urlSuffix];
    [self doGetRequestWithUrl:url parameters:nil completion:completion];
}

- (void)getRelationshipOfuserWithUserId:(NSString*)userId completion:(void (^)(NSDictionary * response, NSError * error))completion {
    NSString * urlSuffix = [NSString stringWithFormat:USER_RELATIONSHIP_URL_SUFFIX, userId, ACCESS_TOKEN];
    NSString * url = [self constructUrl:urlSuffix];
    [self doGetRequestWithUrl:url parameters:nil completion:completion];
}

- (void)getRicentMediaForUserWithUserId:(NSString*)userId completion:(void (^)(NSDictionary * response, NSError * error))completion {
    NSString * urlSuffix = [NSString stringWithFormat:USER_MEDIA_RICENT_URL_SUFFIX, userId, ACCESS_TOKEN];
    NSString * url = [self constructUrl:urlSuffix];
    [self doGetRequestWithUrl:url parameters:nil completion:completion];
}

- (void)getMediaForMaxId:(NSString*)maxId forUserWithId:(NSString*)userId completion:(void (^)(NSDictionary * response, NSError * error))completion {
    NSString * urlSuffix = [NSString stringWithFormat:USER_MEDIA_FOR_MAX_ID_URL_SUFFIX, userId, ACCESS_TOKEN, maxId];
    NSString * url = [self constructUrl:urlSuffix];
    [self doGetRequestWithUrl:url parameters:nil completion:completion];
}

- (void)getMediaForMinId:(NSString*)minId forUserWithId:(NSString*)userId completion:(void (^)(NSDictionary * response, NSError * error))completion {
    NSString * urlSuffix = [NSString stringWithFormat:USER_MEDIA_FOR_MIN_ID_URL_SUFFIX, userId, ACCESS_TOKEN, minId];
    NSString * url = [self constructUrl:urlSuffix];
    [self doGetRequestWithUrl:url parameters:nil completion:completion];
}

#pragma mark - httpMethods

-(void)doGetRequestWithUrl:(NSString*)url parameters:(NSDictionary*)parameters completion:(void (^)(NSDictionary * response, NSError * error))completion {
    [self.requestManager GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%s success %@", __func__, responseObject);
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%s error %@", __func__, error);
        completion(nil, error);
    }];
}

-(void)doPostRequestWithUrl:(NSString*)url parameters:(NSDictionary*)parameters completion:(void (^)(NSDictionary * response, NSError * error))completion {
    [self.requestManager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%s success %@", __func__, responseObject);
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%s error %@", __func__, error);
        completion(nil, error);
    }];
}

@end
