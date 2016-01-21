//
//  IIUserModel.h
//  InstaImages
//
//  Created by Gumo on 20/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface IIUserModel : JSONModel

@property (strong, nonatomic) NSString * fullName;
@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * profilePicture;
@property (strong, nonatomic) NSString * username;

+ (NSArray<IIUserModel*>*)userModelesFromArrayOfDictionaries:(NSArray<NSDictionary*>*)dataArray;

@end
