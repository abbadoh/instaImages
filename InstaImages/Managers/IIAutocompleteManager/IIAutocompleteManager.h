//
//  IIAutocompleteManager.h
//  InstaImages
//
//  Created by Gumo on 19/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTAutocompleteTextField.h"

@interface IIAutocompleteManager : NSObject <HTAutocompleteDataSource>

+ (IIAutocompleteManager *)sharedManager;
- (void)setAutocompleteArrayOfUsernames:(NSArray*)array;

@end
