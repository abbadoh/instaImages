//
//  IIError.h
//  InstaImages
//
//  Created by Gumo on 20/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    IIErrorCodeServerError,
    IIErrorCodeNoInternetConnection,
    IIErrorCodeNoSuchUser,
} IIErrorCode;

@interface IIError : NSObject

@property (assign, nonatomic, readonly) IIErrorCode errorCode;
@property (strong, nonatomic, readonly) NSString * errorMessage;

+ (instancetype)errorWithCode:(IIErrorCode)code;

@end
