//
//  IIUserRelationshipModel.h
//  InstaImages
//
//  Created by Gumo on 20/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface IIUserRelationshipModel : JSONModel

@property (strong, nonatomic) NSString * incomingStatus;
@property (strong, nonatomic) NSString * outgoingStatus;
@property (strong, nonatomic) NSNumber * targetUserIsPrivate;

+(IIUserRelationshipModel*)userRelationshipModelFromDictionary:(NSDictionary*)dictionary;

@end
