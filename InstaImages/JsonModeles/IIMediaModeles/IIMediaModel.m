//
//  IIMediaModel.m
//  InstaImages
//
//  Created by Gumo on 16/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIMediaModel.h"

static NSString * const TYPE_IMAGE = @"image";

@implementation IIMediaModel

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

-(NSString*)getLowResolutionImageUrl {
    return self.images.lowResolution.url;
}

-(NSString*)getThumbnailImageUrl {
    return self.images.thumbnail.url;
}

+(NSArray<IIMediaModel*>*)mediaModelArrayFromArrayOfDictionaries:(NSArray*)dataArray {
    NSMutableArray * mediaModelArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (int i = 0; i < dataArray.count; ++i) {
        NSError* err = nil;
        IIMediaModel * mediaModel = [[IIMediaModel alloc]initWithDictionary:dataArray[i] error:&err];
        if (!err) {
            [mediaModelArray addObject:mediaModel];
        }
    }
    return mediaModelArray;
}

+(NSArray<IIMediaModel*>*)mediaModelArrayOfImagesFromArrayOfDictionaries:(NSArray*)dataArray {
    NSMutableArray * mediaModelArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (int i = 0; i < dataArray.count; ++i) {
        NSError* err = nil;
        IIMediaModel * mediaModel = [[IIMediaModel alloc]initWithDictionary:dataArray[i] error:&err];
        if (!err) {
            if ([mediaModel.type isEqualToString:TYPE_IMAGE]) {
                [mediaModelArray addObject:mediaModel];
            }
        }
    }
    return mediaModelArray;
}


@end
