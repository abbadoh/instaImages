//
//  IIUserDefaultsManager.h
//  InstaImages
//
//  Created by Gumo on 19/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IIUserDefaultsManager : NSObject

+ (void)saveUsernameToAutocomleteArray:(NSString*)username;
+ (NSArray*)getAutocompleteArray;

@end
