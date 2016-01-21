//
//  IIAutocompleteManager.m
//  InstaImages
//
//  Created by Gumo on 19/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIAutocompleteManager.h"

static IIAutocompleteManager *sharedManager;

@interface IIAutocompleteManager ()
    @property (strong,nonatomic) NSArray<NSString*> * autocompleteArray;
@end

@implementation IIAutocompleteManager

+ (IIAutocompleteManager *)sharedManager
{
    static dispatch_once_t done;
    dispatch_once(&done, ^{ sharedManager = [[IIAutocompleteManager alloc] init]; });
    return sharedManager;
}

- (void)setAutocompleteArrayOfUsernames:(NSArray*)array {
    self.autocompleteArray = array;
}

#pragma mark - HTAutocompleteTextFieldDelegate

- (NSString *)textField:(HTAutocompleteTextField *)textField
    completionForPrefix:(NSString *)prefix
             ignoreCase:(BOOL)ignoreCase
{
    if (!self.autocompleteArray) {
        return @"";
    }
    
    NSString *stringToLookFor;
    if (ignoreCase)
    {
        stringToLookFor = [prefix lowercaseString];
    }
    else
    {
        stringToLookFor = prefix;
    }
    
    for (NSString *stringFromReference in self.autocompleteArray)
    {
        NSString *stringToCompare;
        if (ignoreCase)
        {
            stringToCompare = [stringFromReference lowercaseString];
        }
        else
        {
            stringToCompare = stringFromReference;
        }
        
        if ([stringToCompare hasPrefix:stringToLookFor])
        {
            return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor] withString:@""];
        }
        
    }
    return @"";
}

@end
