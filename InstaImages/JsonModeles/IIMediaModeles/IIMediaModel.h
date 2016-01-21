//
//  IIMediaModel.h
//  InstaImages
//
//  Created by Gumo on 16/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "IIMediaImagesModel.h"

@interface IIMediaModel : JSONModel

@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString<Ignore>* comments;
@property (assign, nonatomic) NSInteger createdTime;
@property (strong, nonatomic) NSString<Ignore>* caption;
@property (strong, nonatomic) NSString * link;
@property (strong, nonatomic) NSString<Ignore>* tags;
@property (strong, nonatomic) NSString<Ignore>* likes;
@property (strong, nonatomic) NSString * type;
@property (strong, nonatomic) NSString<Ignore>* usersInPhoto;
@property (strong, nonatomic) NSString<Ignore>* location;
@property (strong, nonatomic) NSString * filter;
@property (strong, nonatomic) IIMediaImagesModel * images;
@property (assign, nonatomic) BOOL userHasLiked;
@property (strong, nonatomic) NSString<Ignore>* users;
@property (strong, nonatomic) NSString<Ignore>* attribution;

//+(NSArray<IIMediaModel*>*)mediaModelArrayFromArrayOfDictionaries:(NSArray*)dataArray;
+(NSArray<IIMediaModel*>*)mediaModelArrayOfImagesFromArrayOfDictionaries:(NSArray*)dataArray;

-(NSString*)getLowResolutionImageUrl;
-(NSString*)getThumbnailImageUrl;



@end
