//
//  IIlnstagramFlowLayout.m
//  InstaImages
//
//  Created by Gumo on 16/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIlnstagramFlowLayout.h"

static NSInteger const NUMBER_OF_COLUMNS = 3;

@implementation IIlnstagramFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

-(CGFloat)minimumInteritemSpacing {
    return 1.0f;
}

-(CGFloat)minimumLineSpacing {
    return 1.0f;
}

-(UIEdgeInsets)sectionInset {
    return UIEdgeInsetsZero;
}


- (CGSize)itemSize
{
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - (NUMBER_OF_COLUMNS - 1)) / NUMBER_OF_COLUMNS;
    return CGSizeMake(itemWidth, itemWidth);
}



@end
