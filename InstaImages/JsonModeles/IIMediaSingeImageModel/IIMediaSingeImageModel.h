//
//  IIMediaSingeImageModel.h
//  InstaImages
//
//  Created by Gumo on 16/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface IIMediaSingeImageModel : JSONModel

@property (assign, nonatomic) NSInteger height;
@property (strong, nonatomic) NSString * url;
@property (assign, nonatomic) NSInteger width;

@end
