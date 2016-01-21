//
//  IIMediaImagesModel.h
//  InstaImages
//
//  Created by Gumo on 16/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "IIMediaSingeImageModel.h"


@interface IIMediaImagesModel : JSONModel

@property (strong, nonatomic) IIMediaSingeImageModel * lowResolution;
@property (strong, nonatomic) IIMediaSingeImageModel * standardResolution;
@property (strong, nonatomic) IIMediaSingeImageModel * thumbnail;

@end
