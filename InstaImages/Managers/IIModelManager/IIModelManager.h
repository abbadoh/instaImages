//
//  IIModelManager.h
//  InstaImages
//
//  Created by Gumo on 16/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IIMediaModel.h"
#import "IIError.h"

@interface IIModelManager : NSObject

+ (instancetype)sharedManager;

- (void)getUserIdForUserWithUsername:(NSString*)username completion:(void (^)(NSString * userId, IIError * error))completion;
- (void)getUserIsPrivateFlagForUserWithUserId:(NSString*)userId completion:(void (^)(NSNumber * isPrivate, IIError * error))completion;
- (void)getLatestMediaForUserWithId:(NSString*)userId completion:(void (^)(NSArray<IIMediaModel*> * media, IIError * error))completion;
- (void)getOlderMediaForMaxId:(NSString*)maxId forUserWithId:(NSString*)userId completion:(void (^)(NSArray<IIMediaModel*> * media, IIError * error))completion;
- (void)getNewerMediaForMinId:(NSString*)minId forUserWithId:(NSString*)userId completion:(void (^)(NSArray<IIMediaModel*> * media, IIError * error))completion;


@end
