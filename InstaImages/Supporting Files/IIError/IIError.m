//
//  IIError.m
//  InstaImages
//
//  Created by Gumo on 20/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIError.h"

@implementation IIError

+(instancetype)errorWithCode:(IIErrorCode)code {
   return [[IIError alloc] initWithCode:code];
}

-(id)initWithCode:(IIErrorCode)code {
    self = [super init];
    if (self) {
        _errorCode = code;
        _errorMessage = [self getErrorMessageForCode:code];
    }
    return self;
}

-(NSString*)getErrorMessageForCode:(IIErrorCode)code {
    switch (code) {
        case IIErrorCodeNoInternetConnection:
            return @"No internet Connection";
            break;
        case IIErrorCodeNoSuchUser:
            return @"Such user does not exist.";
            break;
        case IIErrorCodeServerError:
            return @"Server error, try again.";
        default:
            break;
    }
    return @"";
}

@end
