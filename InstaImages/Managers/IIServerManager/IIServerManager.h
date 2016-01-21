//
//  IIServerManager.h
//  InstaImages
//
//  Created by Gumo on 15/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IIServerManager : NSObject

+ (instancetype)sharedManager;

-(void)getUserDataForUserWithUsername:(NSString*)username completion:(void (^)(NSDictionary * response, NSError * error))completion;
- (void)getRelationshipOfuserWithUserId:(NSString*)userId completion:(void (^)(NSDictionary * response, NSError * error))completion;
- (void)getRicentMediaForUserWithUserId:(NSString*)userId completion:(void (^)(NSDictionary * response, NSError * error))completion;
- (void)getMediaForMaxId:(NSString*)maxId forUserWithId:(NSString*)userId completion:(void (^)(NSDictionary * response, NSError * error))completion;
- (void)getMediaForMinId:(NSString*)minId forUserWithId:(NSString*)userId completion:(void (^)(NSDictionary * response, NSError * error))completion;

@end
