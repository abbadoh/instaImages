//
//  IIUserRelationshipModel.m
//  InstaImages
//
//  Created by Gumo on 20/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIUserRelationshipModel.h"

@implementation IIUserRelationshipModel

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

+(IIUserRelationshipModel*)userRelationshipModelFromDictionary:(NSDictionary*)dictionary {
    NSError* err = nil;
    IIUserRelationshipModel * relationshipModel = [[IIUserRelationshipModel alloc]initWithDictionary:dictionary error:&err];
    if (!err) {
        return relationshipModel;
    }
    return nil;
}


@end
