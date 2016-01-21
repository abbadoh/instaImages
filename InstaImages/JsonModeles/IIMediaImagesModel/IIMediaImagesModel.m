//
//  IIMediaImagesModel.m
//  InstaImages
//
//  Created by Gumo on 16/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIMediaImagesModel.h"

@implementation IIMediaImagesModel

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
