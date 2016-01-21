//
//  IIModelManager.m
//  InstaImages
//
//  Created by Gumo on 16/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//
#import "Reachability.h"
#import "IIServerManager.h"
#import "IIModelManager.h"
#import "IIUserModel.h"
#import "IIUserRelationshipModel.h"

static NSString * const DATA_KEY = @"data";
static NSString * const INSTAGRAM_URL = @"https://www.instagram.com";

static NSInteger NUMBER_OF_ITEMS_TO_RETRIVE = 18;

@interface IIModelManager ()

@property (strong, nonatomic) Reachability * instagramReach;

@end

@implementation IIModelManager

+ (instancetype)sharedManager{
    static dispatch_once_t pred;
    static IIModelManager *_sharedManager = nil;
    dispatch_once(&pred, ^{
        _sharedManager = [[IIModelManager alloc] init];
    });
    return _sharedManager;
}

-(id)init {
    self = [super init];
    if (self) {
        self.instagramReach = [Reachability reachabilityWithHostname:INSTAGRAM_URL];
    }
    return self;
}

- (void)getUserIdForUserWithUsername:(NSString*)username completion:(void (^)(NSString * userId, IIError * error))completion {
    if ([self isIntenetConnectionAvaliable]) {
        [[IIServerManager sharedManager] getUserDataForUserWithUsername:username completion:^(NSDictionary * response, NSError * error) {
            if (response) {
                NSArray<IIUserModel*> * userModeles = [IIUserModel  userModelesFromArrayOfDictionaries:[response objectForKey:DATA_KEY]];
                IIUserModel * userModel = [self findUserWithExactUsername:username inArray:userModeles];
                if (userModel) {
                    completion(userModel.id, nil);
                }
                else {
                    completion(nil, [IIError errorWithCode:IIErrorCodeNoSuchUser]);
                }
            }
            else if(error) {
                completion(nil, [IIError errorWithCode:IIErrorCodeServerError]);
            }
        }];
    }
    else {
        completion(nil, [IIError errorWithCode:IIErrorCodeNoInternetConnection]);
    }
}

- (IIUserModel*)findUserWithExactUsername:(NSString*)username inArray:(NSArray<IIUserModel*>*)array {
    for (int i = 0; i < array.count; ++i) {
        if ([array[i].username isEqualToString:username]) {
            return array[i];
        }
    }
    return nil;
}


- (void)getUserIsPrivateFlagForUserWithUserId:(NSString*)userId completion:(void (^)(NSNumber * isPrivate, IIError * error))completion {
    if ([self isIntenetConnectionAvaliable]) {
        [[IIServerManager sharedManager] getRelationshipOfuserWithUserId:userId completion:^(NSDictionary *response, NSError *error) {
            if (error) {
                completion(nil, [IIError errorWithCode:IIErrorCodeServerError]);
            }
            else if(completion) {
                completion([IIUserRelationshipModel userRelationshipModelFromDictionary:[response objectForKey:DATA_KEY]].targetUserIsPrivate, nil);
            }
        }];
    }
    else {
        completion(nil, [IIError errorWithCode:IIErrorCodeNoInternetConnection]);
    }
}

- (void)getLatestMediaForUserWithId:(NSString*)userId completion:(void (^)(NSArray<IIMediaModel*> * media, IIError * error))completion {
    if ([self isIntenetConnectionAvaliable]) {
        [[IIServerManager sharedManager] getRicentMediaForUserWithUserId:userId completion:^(NSDictionary *response, NSError *error) {
            if (error) {
                return completion(nil,[IIError errorWithCode:IIErrorCodeServerError]);
            }
            else if (response) {
                NSArray<IIMediaModel*> * media = [IIMediaModel mediaModelArrayOfImagesFromArrayOfDictionaries:[response objectForKey:DATA_KEY]];
                completion(media, nil);
            }
        }];
    }
    else {
        completion(nil, [IIError errorWithCode:IIErrorCodeNoInternetConnection]);
    }
}

- (void)getOlderMediaForMaxId:(NSString*)maxId forUserWithId:(NSString*)userId completion:(void (^)(NSArray<IIMediaModel*> * media, IIError * error))completion {
    if ([self isIntenetConnectionAvaliable]) {
        [[IIServerManager sharedManager] getMediaForMaxId:maxId forUserWithId:userId completion:^(NSDictionary *response, NSError *error) {
            if (error) {
                completion(nil,[IIError errorWithCode:IIErrorCodeServerError]);
            }
            else if(response) {
                completion([IIMediaModel mediaModelArrayOfImagesFromArrayOfDictionaries:[response objectForKey:DATA_KEY]], nil);
            }
        }];
    }
    else {
        completion(nil, [IIError errorWithCode:IIErrorCodeNoInternetConnection]);
    }
}

- (void)getNewerMediaForMinId:(NSString*)minId forUserWithId:(NSString*)userId completion:(void (^)(NSArray<IIMediaModel*> * media, IIError * error))completion {
    if ([self isIntenetConnectionAvaliable]) {
        [[IIServerManager sharedManager] getMediaForMinId:minId forUserWithId:userId completion:^(NSDictionary *response, NSError *error) {
            if (error) {
                completion(nil,[IIError errorWithCode:IIErrorCodeServerError]);
            }
            else if(response) {
                NSMutableArray<IIMediaModel*> * mediaModelesWithoutLastCachedMedia = [NSMutableArray arrayWithArray:[IIMediaModel mediaModelArrayOfImagesFromArrayOfDictionaries:[response objectForKey:DATA_KEY]]];
                if ([[mediaModelesWithoutLastCachedMedia lastObject].id isEqualToString:minId]) {
                    [mediaModelesWithoutLastCachedMedia removeObject:[mediaModelesWithoutLastCachedMedia lastObject]];
                }
                completion(mediaModelesWithoutLastCachedMedia, nil);
            }
        }];
    }
    else {
        completion(nil, [IIError errorWithCode:IIErrorCodeNoInternetConnection]);
    }
}

- (BOOL)isIntenetConnectionAvaliable {
    if (self.instagramReach.isReachable) {
        return true;
    }
    return false;
}

@end
