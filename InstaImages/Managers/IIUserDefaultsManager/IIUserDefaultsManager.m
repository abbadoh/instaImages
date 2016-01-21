//
//  IIUserDefaultsManager.m
//  InstaImages
//
//  Created by Gumo on 19/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "IIUserDefaultsManager.h"

static NSString * const AUTOCOMPLETE_ARRAY_KEY = @"IIUSER_DEFAULTS_AUTOCOMPLETE_ARRAY_KEY";

@implementation IIUserDefaultsManager

+ (void)saveUsernameToAutocomleteArray:(NSString*)username {
    NSMutableArray * autocompleteArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:AUTOCOMPLETE_ARRAY_KEY]];
    if (![autocompleteArray containsObject:username]) {
        [autocompleteArray addObject:username];
        [[NSUserDefaults standardUserDefaults] setObject:autocompleteArray forKey:AUTOCOMPLETE_ARRAY_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSArray*)getAutocompleteArray {
    return [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:AUTOCOMPLETE_ARRAY_KEY]];
}

@end
