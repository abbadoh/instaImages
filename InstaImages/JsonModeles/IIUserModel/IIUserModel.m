//
//  IIUserModel.m
//  InstaImages
//
//  Created by Gumo on 20/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIUserModel.h"

@implementation IIUserModel

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

+ (NSArray<IIUserModel*>*)userModelesFromArrayOfDictionaries:(NSArray<NSDictionary*>*)dataArray {
    NSMutableArray * userModelArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (int i = 0; i < dataArray.count; ++i) {
        NSError* err = nil;
        IIUserModel * userModel = [[IIUserModel alloc]initWithDictionary:dataArray[i] error:&err];
        if (!err) {
            [userModelArray addObject:userModel];
        }
    }
    return userModelArray;
}


@end
